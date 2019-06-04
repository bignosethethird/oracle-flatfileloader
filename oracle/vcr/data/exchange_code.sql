------------------------------------------------------------------------------
-- $Header: vcr/data/exchange_code.sql 1.5 2005/10/21 11:10:23BST apenney DEV  $
------------------------------------------------------------------------------
-- Data population script for table vcr.exchange_code.
-- WARNING: *** This script overwrites the entire table! ***
--          *** Save important content before running.   ***
-- To run this script from the command line:
--   $ sqlplus "vcr/[password]@[instance]" @exchange_code.sql
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 19:11:27
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.exchange_code.

alter table vcr.source_market disable constraint fk_source_market_exch_code;

-- Truncate the table:
delete from vcr.exchange_code;

------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('AB','Saudi Arabia - Saudi Arabia');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('AC','Argentina - Buenos Cont');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('AD','Andorra - Andorra');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('AF','Argentina - Buenos Aires (Floor-SINAC)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('AI','Anguilla - Anguilla');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('AL','Albania - Albania');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('AR','Argentina - Buenos Aires (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('AS','Argentina - Buenos Sinac');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('AU','Australia - Australian Stock Exchange (ASX)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('AV','Austria - Vienna Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BA','Barbados - Bridgeton');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BB','Belgium - Brussels');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BC','undefined - BRVM Regional');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BD','Bangladesh - Bangladesh');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BG','Botswana - Gaborone');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BH','Bermuda - Hamilton');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BI','Bahrain - Bahrain');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BM','Bahamas - Bahamas');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BN','Brazil - Sao Paolo Exchange (After Market, Night Session)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BO','Brazil - Rio de Janeiro OTC Market (SOMA)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BP','Bosnia - Bosnia');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BS','Brazil - Sao Paulo (Regular Session)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BU','Bulgaria - Bulgaria');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BV','Brazil - Bovespa (Open Outcry)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BX','Brunei - Brunei');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('BZ','Brazil - Brazil (Composite, Regular and Night Session)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CA','Canada - Alberta Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CB','Colombia - Colombia (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CC','Chile - Santiago (de Comercio)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CD','Czech Republic - Prague SPAD');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CE','Chile - Bolsa Electronic Santiago');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CG','China - Shanghai');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CH','China - China (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CI','Chile - Chile (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CK','Czech Republic - Prague KOBOS');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CL','Colombia - Bolsa de Medellin');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CM','Canada - Montreal Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CN','Canada - Canada (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CO','undefined - Occidente');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CP','Czech Republic - Czech Republic (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CQ','Canada - Canadian Dealing Network');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CR','Costa Rica - Costa Rica');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CS','China - Shenzhen');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CT','Canada - Toronto Stock Exchange (TSE)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CU','Cook Islands - Cook Islands');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CV','Canada - Canadian Venture Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CW','Canada - Winnipeg Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CX','Colombia - Bolsa de Bogota');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CY','Cyprus - Cyprus');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('CZ','Croatia - Zagreb');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('DC','Denmark - Copenhagen');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('EA','Egypt - Alexandria');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('EC','Egypt - Cairo');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ED','Ecuador - Ecuador (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('EG','Ecuador - Guayaquil');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('EK','undefined - Eastern Carrib');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('EM','Europe - Euronext New Market');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('EN','Europe - Euronext');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('EQ','Ecuador - Quito');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ES','Europe - NASDAQ Europe');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ET','Estonia - Tallin Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('EX','Europe - NEWEX');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('EY','Egypt - Egypt');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('FH','Finland - Helsinki');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('FP','France - Paris');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('FS','Fiji - Fiji');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GA','Greece - Athens');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GB','Germany - Berlin');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GC','Germany - Bremen');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GD','Germany - Dusseldorf');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GF','Germany - Frankfurt');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GH','Germany - Hamburg');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GI','Germany - Hannover');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GM','Germany - Munich');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GN','Ghana - Ghana');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GQ','Germany - Xetra Stars');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GR','Germany - Germany (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GS','Germany - Stuttgart');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GT','Europe - EUREX');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GU','UK - Guernsey');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GW','Europe - EUWAX Stuttgart (Euro Warrant Exchange)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('GY','Germany - German Xetra');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('HB','Hungary - Hungary');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('HK','Hong Kong - Hong Kong');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IA','Ivory Coast - Ivory Coast');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IB','India - Mumbai');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IC','Italy - Italy Complete Day');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ID','Ireland - Dublin');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IE','Iran - Tehran');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IF','Italy - Italy After Hours');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IH','India - Delhi');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IJ','Indonesia - Jakarta');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IM','Italy - Milan');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IN','India - India (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IO','UK - Isle of Man');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IQ','Iraq - Iraq');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IR','Iceland - Iceland');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IS','India - National Stock Exchange of India');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IT','Israel - Tel Aviv');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('IY','undefined - Surabaya');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JA','Jamaica - Kingston');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JB','undefined - Brokers Broker Euro$ Warrant');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JF','Japan - Fukuoka');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JM','Japan - Optimark Japan');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JN','Japan - Nagoya');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JO','Japan - Osaka');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JP','Japan - Japan (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JQ','Japan - JASDAQ');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JR','Jordan - Jordan');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JS','Japan - Sapporo');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JT','Japan - Tokyo');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JX','Japan - Hercules Japan');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('JY','UK - Jersey');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('KK','Kuwait - Kuwait');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('KN','Kenya - Nairobi');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('KP','South Korea - Korea Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('KQ','South Korea - KOSDAQ');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('KS','South Korea - Korea (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('KY','Cayman Islands - Cayman Islands');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('KZ','Kazakhstan - Kazakhstan');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LB','Lebanon - Beirut');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LC','UK - London (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LE','Liechtenstein - Liechtenstein');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LF','Latvia - Riga Fixed Market');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LH','Lithuania - Lithuania');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LI','UK - London International');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LN','UK - London Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LQ','undefined - Liqdty Qt Ex');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LR','Latvia - Riga (Latvia Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LT','UK - London Tradepoint');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LV','Latvia - Riga Variable Market');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('LX','Luxembourg - Luxembourg');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MA','China - Macau');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MC','Morocco - Morocco');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MD','Spain - Madeira Islands');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MI','US - Marshall Islds');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MK','Malaysia - Kuala Lumpur');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MM','Mexico - Mexico City');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MN','Monaco - Monaco');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MP','Mauritius - Mauritius');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MQ','Mexico - MESDAQ');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MV','Malta - Malta');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MW','Malawi - Malawi');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('MZ','Mozambique - Maputo');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NA','Nederlands - Amsterdam');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NB','Belgium - Brussels New Market');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NC','Nicaragua - Nicaragua');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ND','Germany - NDQ Deutschlnd');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NE','Nederlands - Dutch Electronic Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NF','Germany - Frankfurt Neuer Markt');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NI','Italy - Italy New Market');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NK','Nepal - Katmandu');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NL','Nigeria - Lagos');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NM','Germany - German New Market (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NN','Nederlands - Netherlands New Market');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NO','Norway - Oslo');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NP','France - Paris New Market');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NT','Netherlands Antilles - Netherlands Antilles');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NV','New Zealand - OTC  New Zld');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NW','Namibia - Namibia');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NX','St Kitts and Nevis - St Kitts and Nevis');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NY','Germany - XETRA New Market');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('NZ','New Zealand - Auckland');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('OF','UK - OFEX London');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('OM','Oman - Omana');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('OS','undefined - Off Shore');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PA','Pakistan - Pakistan (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PC','Poland - Warsaw (Continuous)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PE','Peru - Lima');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PK','Pakistan - Karachi');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PL','Portugal - Lisbon');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PM','Philippines - Manila');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PN','Paraguay - Paraguay');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PP','Panama - Panama City');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PQ','US - NBQ Pink Sheets');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PS','Palestine - Palestine');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PT','Poland - Warsaw (Auction)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('PW','Poland - Warsaw (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('QD','Qatar - Qatar');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('RB','Belarus - Belarus');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('RM','Russia - MICEX');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('RO','Romania - Romania');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('RQ','undefined - RASDAQ');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('RR','Russia - Russian Trading Systems');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('RU','Russia - Russia (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SA','Spain - Valencia');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SB','Spain - Barcelona');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SC','Switzerland - Euro-contributor Warrants (Swiss)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SD','Swaziland - Mbabane');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SE','Switzerland - Elektronische Boerse Schweiz (EBS)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SG','Serbia - Belgrade');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SJ','South Africa - Johannesburg');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SK','Slovakia - Bratislava');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SL','Sri Lanka - Sri Lanka');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SM','Spain - Spain (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SN','Spain - Madrid');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SO','Spain - Bilbao');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SP','Singapore - Singapore');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SQ','Spain - Spain (Continous)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SR','Switzerland - Berne');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SS','Sweden - Stockholm');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ST','undefined - ContinuousNM');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SV','Slovenia - Slovenia');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('SW','Switzerland - Switzerland (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('TB','Thailand - Bangkok');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('TC','Turks and Caicos - Turks and Caicos');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('TF','Turkey - Istanbul (First Session)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('TI','Turkey - Istanbul (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('TL','UK - Gibraltar');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('TP','Trinidad - Port Spain');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('TS','Turkey - Istanbul (Second Session)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('TT','Taiwan - Taipei');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('TU','Tunisia - Tunisia');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('TZ','Tanzania - Tanzania');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UA','US - American Stock Exchange (AMEX)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UB','US - Boston Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UC','US - Cincinnati Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UD','US - NASD Alternative Dislay Facility');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UE','US - NASDAQ International');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UG','Uganda - Uganda');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UH','UAE - Abu Dhabi');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UI','US - Island Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UL','US - ISE Option Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UM','US - Chicago Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UN','US - New York Stock Exchange (NYSE)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UO','US - Chicago Board for Option Exchange (CBOE)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UP','US - Pacific Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UQ','US - NASDAQ / NMS / Small Cap');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UR','US - NASDAQ Small Cap');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('US','US - United States (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UT','US - NASDAQ iM');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UU','US - OTC Bulletin Board');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UV','US - OTC  US');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UX','US - Philidelphia Stock Exchange');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UY','Uruguay - Montevideo');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('UZ','Ukraine - Ukraine');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('VB','Bolivia - Bolivia');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('VC','Venezuela - Venezuela (Composite)');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('VE','Venezuela - Bolsa Electronica de Caracas');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('VI','British Virgin Islands - British Virgin Islands');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('VN','Vietnam - Vietnam');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('VS','Venezuela - Bolsa de Valores de Caracas');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('VX','Europe - Virt-x');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ZB','Belize - Belize');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ZC','Central Afr Rp - Central Afr Rp');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ZG','Gabon - Gabon');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ZH','Zimbabwe - Zimbabwe');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ZL','Zambia - Lusaka');
insert into vcr.exchange_code (EXCHANGE_CODE,DESCRIPTION) values('ZS','Senegal - Senegal');


commit;
alter table vcr.source_market disable constraint fk_source_market_exch_code;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

