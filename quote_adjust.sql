/* (a) Create QUOTE_ADJUST table */
CREATE TABLE `QUOTE_ADJUST` (
 `INSTRUMENT_ID` int(11) NOT NULL,
 `LAST_ASK_PRICE` decimal(18,4) DEFAULT 0.0000,
 `LAST_ASK_SEQ_NBR` int(11) DEFAULT 0,
 `LAST_BID_PRICE` decimal(18,4) DEFAULT 0.0000,
 `LAST_BID_SEQ_NBR` int(11) DEFAULT 0,
 `AMPLITUDE` decimal(18,4) DEFAULT 0.0000,
 `SWITCHPOINT` int(11) DEFAULT 0,
 `DIRECTION` tinyint(4) DEFAULT 1,
 PRIMARY KEY (`INSTRUMENT_ID`)
);

/* (b) Initialize with instrument_ids from INSTRUMENT */
INSERT INTO QUOTE_ADJUST (instrument_id) SELECT INSTRUMENT_ID FROM INSTRUMENT;

/*	(c) Update AMPLITUDE by a random factor of 2 */
UPDATE QUOTE_ADJUST SET AMPLITUDE=(RAND()+.5);

/* (d) Update QUOTE_ADJUST switchpoint to random function of 750 quotes */
UPDATE QUOTE_ADJUST SET switchpoint = ROUND((RAND() + .5) * 750);
