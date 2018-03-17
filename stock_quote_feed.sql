/* Stock Quote Feed for simulating live feeds of the five different currencies we are working with.
   Namely, USD, RUB, JPY, CNY, and EUR
*/

DELIMITER //
DROP PROCEDURE IF EXISTS sp_quote_feed //
/* first try just input to output just loop count*/
create procedure sp_quote_feed(IN loops int)
      BEGIN
      declare this_instrument int(11);
      declare this_quote_date date;
      declare this_quote_seq_nbr int(11);
      declare this_trading_symbol varchar(15);
      declare this_quote_time datetime;
      declare this_ask_price decimal(18,4);
      declare this_ask_size int(11);
      declare this_bid_price decimal(18,4);
      declare this_bid_size int(11);
      declare loopcount int(11);
      declare maxloops int(11);

      /*variables for stockmarket.QUOTE_ADJUST values*/
      declare qa_last_ask_price decimal(18,4);
      declare qa_last_ask_seq_nbr int(11);
      declare qa_last_bid_price decimal(18,4);
      declare qa_last_bid_seq_nbr int(11);
      declare qa_amplitude decimal(18,4);
      declare qa_switchpoint int(11);
      declare qa_direction tinyint;
      declare db_done int default false;
      declare cur1 cursor for select * from stockmarket.STOCK_QUOTE
          use index for
          order by (XK2_STOCK_QUOTE,XK4_STOCK_QUOTE)
          order by QUOTE_SEQ_NBR,QUOTE_TIME;
      declare continue handler for not found set db_done=1; /* When cursor reaches the end of the table, set db_done to 1*/

      set maxloops=loops*1000;
      set loopcount=1;

      open cur1;
         quote_loop: LOOP
              if (db_done OR loopcount=maxloops) then leave quote_loop;
              end if;

              /* fetch attribute values for the current row and place them in variables. Fetch will update the row when it is called again*/
              fetch cur1 into this_instrument, this_quote_date, this_quote_seq_nbr, this_trading_symbol, this_quote_time, this_ask_price, this_ask_size, this_bid_price, this_bid_size;

              /*all update logic goes here...first get stockmarket.QUOTE_ADJUST values into variables*/
              select LAST_ASK_PRICE,LAST_ASK_SEQ_NBR,LAST_BID_PRICE,LAST_BID_SEQ_NBR,AMPLITUDE,SWITCHPOINT, DIRECTION into qa_last_ask_price,qa_last_ask_seq_nbr,qa_last_bid_price,qa_last_bid_seq_nbr,qa_amplitude,qa_switchpoint,qa_direction from stockmarket.QUOTE_ADJUST where INSTRUMENT_ID=this_instrument;

              /* If it is an ask, the ask_price is greater than zero */
              if this_ask_price > 0 then
                      update stockmarket.QUOTE_ADJUST set LAST_ASK_PRICE = this_ask_price where INSTRUMENT_ID = this_instrument;
                      update stockmarket.QUOTE_ADJUST set LAST_ASK_SEQ_NBR = this_quote_seq_nbr where INSTRUMENT_ID = this_instrument;

                      /* not first ask for this instance */
                      if qa_last_ask_price > 0 then
                              set this_ask_price = qa_last_ask_price + (ABS(this_ask_price-qa_last_ask_price) * qa_amplitude * qa_direction);
                          end if;

              /* Else, then it is a bid */
              else
                      update stockmarket.QUOTE_ADJUST set LAST_BID_PRICE = this_bid_price where INSTRUMENT_ID = this_instrument;
                      update stockmarket.QUOTE_ADJUST set LAST_BID_SEQ_NBR = this_quote_seq_nbr where INSTRUMENT_ID = this_instrument;
                      if qa_last_bid_price > 0 then /*not first bid for this inst*/

                              set this_bid_price = qa_last_bid_price + (ABS(this_bid_price-qa_last_bid_price) * qa_amplitude * qa_direction);
                          end if;

              end if;  /* end this if statement if this is an ask or a bid*/

              /* in all cases, check and reset switchpoint and if needed, reset amplitude and update dates*/
              if qa_switchpoint > 0 then
                        update stockmarket.QUOTE_ADJUST set SWITCHPOINT = SWITCHPOINT-1 where INSTRUMENT_ID=this_instrument ;
              else  /* switchpoint <=0, recalculate switchpoint and change direction */
                        update stockmarket.QUOTE_ADJUST set SWITCHPOINT = ROUND((RAND() + .5) * 400), DIRECTION=DIRECTION*-1 where INSTRUMENT_ID=this_instrument;
              end if;

              update stockmarket.QUOTE_ADJUST set AMPLITUDE = (RAND()+.5) where INSTRUMENT_ID = this_instrument;
              set this_quote_date = DATE_ADD(this_quote_date, INTERVAL 12 YEAR);
              set this_quote_time = DATE_ADD(this_quote_time, INTERVAL 12 YEAR);

              /* now write out the record*/
              insert into stockmarket.STOCK_QUOTE_FEED values(this_instrument, this_quote_date, this_quote_seq_nbr, this_trading_symbol, this_quote_time, this_ask_price, this_ask_size, this_bid_price, this_bid_size);
              set loopcount = loopcount + 1;
          END LOOP;

      close cur1; /* close the cursor */

END //
DELIMITER ;
