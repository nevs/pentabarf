
BEGIN;

ALTER TABLE auth.domain RENAME TO old_domain;
CREATE TABLE base.domain( domain TEXT NOT NULL);
CREATE TABLE auth.domain( PRIMARY KEY(domain) ) INHERITS( base.domain );
CREATE TABLE log.domain() INHERITS( base.logging,base.domain );
INSERT INTO auth.domain SELECT domain FROM auth.old_domain;
DROP TABLE auth.old_domain CASCADE;

ALTER TABLE auth.object_domain RENAME TO old_object_domain;
CREATE TABLE base.object_domain( object TEXT NOT NULL, domain TEXT NOT NULL);
CREATE TABLE auth.object_domain( PRIMARY KEY(object, domain), FOREIGN KEY(domain) REFERENCES auth.domain(domain) ON UPDATE CASCADE ON DELETE CASCADE ) INHERITS( base.object_domain);
CREATE TABLE log.object_domain() INHERITS( base.logging, base.object_domain ); 
INSERT INTO auth.object_domain(object,domain) SELECT object,domain FROM auth.old_object_domain;
DROP TABLE auth.old_object_domain;

ALTER TABLE language ADD COLUMN language TEXT;

UPDATE language SET language='aa' WHERE iso_639_code='aar';
UPDATE language SET language='ab' WHERE iso_639_code='abk';
UPDATE language SET language='ae' WHERE iso_639_code='ave';
UPDATE language SET language='af' WHERE iso_639_code='afr';
UPDATE language SET language='ak' WHERE iso_639_code='aka';
UPDATE language SET language='am' WHERE iso_639_code='amh';
UPDATE language SET language='an' WHERE iso_639_code='arg';
UPDATE language SET language='ar' WHERE iso_639_code='ara';
UPDATE language SET language='as' WHERE iso_639_code='asm';
UPDATE language SET language='av' WHERE iso_639_code='ava';
UPDATE language SET language='ay' WHERE iso_639_code='aym';
UPDATE language SET language='az' WHERE iso_639_code='aze';
UPDATE language SET language='ba' WHERE iso_639_code='bak';
UPDATE language SET language='be' WHERE iso_639_code='bel';
UPDATE language SET language='bg' WHERE iso_639_code='bul';
UPDATE language SET language='bh' WHERE iso_639_code='bih';
UPDATE language SET language='bi' WHERE iso_639_code='bis';
UPDATE language SET language='bm' WHERE iso_639_code='bam';
UPDATE language SET language='bn' WHERE iso_639_code='ben';
UPDATE language SET language='bo' WHERE iso_639_code='tib';
UPDATE language SET language='br' WHERE iso_639_code='bre';
UPDATE language SET language='bs' WHERE iso_639_code='bos';
UPDATE language SET language='ca' WHERE iso_639_code='cat';
UPDATE language SET language='ce' WHERE iso_639_code='che';
UPDATE language SET language='ch' WHERE iso_639_code='cha';
UPDATE language SET language='co' WHERE iso_639_code='cos';
UPDATE language SET language='cr' WHERE iso_639_code='cre';
UPDATE language SET language='cs' WHERE iso_639_code='cze';
UPDATE language SET language='cu' WHERE iso_639_code='chu';
UPDATE language SET language='cv' WHERE iso_639_code='chv';
UPDATE language SET language='cy' WHERE iso_639_code='wel';
UPDATE language SET language='da' WHERE iso_639_code='dan';
UPDATE language SET language='de' WHERE iso_639_code='ger';
UPDATE language SET language='dv' WHERE iso_639_code='div';
UPDATE language SET language='dz' WHERE iso_639_code='dzo';
UPDATE language SET language='ee' WHERE iso_639_code='ewe';
UPDATE language SET language='el' WHERE iso_639_code='gre';
UPDATE language SET language='en' WHERE iso_639_code='eng';
UPDATE language SET language='eo' WHERE iso_639_code='epo';
UPDATE language SET language='es' WHERE iso_639_code='spa';
UPDATE language SET language='et' WHERE iso_639_code='est';
UPDATE language SET language='eu' WHERE iso_639_code='baq';
UPDATE language SET language='fa' WHERE iso_639_code='per';
UPDATE language SET language='ff' WHERE iso_639_code='ful';
UPDATE language SET language='fi' WHERE iso_639_code='fin';
UPDATE language SET language='fj' WHERE iso_639_code='fij';
UPDATE language SET language='fo' WHERE iso_639_code='fao';
UPDATE language SET language='fr' WHERE iso_639_code='fre';
UPDATE language SET language='fy' WHERE iso_639_code='fry';
UPDATE language SET language='ga' WHERE iso_639_code='gle';
UPDATE language SET language='gd' WHERE iso_639_code='gla';
UPDATE language SET language='gl' WHERE iso_639_code='glg';
UPDATE language SET language='gn' WHERE iso_639_code='grn';
UPDATE language SET language='gu' WHERE iso_639_code='guj';
UPDATE language SET language='gv' WHERE iso_639_code='glv';
UPDATE language SET language='ha' WHERE iso_639_code='hau';
UPDATE language SET language='he' WHERE iso_639_code='heb';
UPDATE language SET language='hi' WHERE iso_639_code='hin';
UPDATE language SET language='ho' WHERE iso_639_code='hmo';
UPDATE language SET language='hr' WHERE iso_639_code='scr';
UPDATE language SET language='ht' WHERE iso_639_code='hat';
UPDATE language SET language='hu' WHERE iso_639_code='hun';
UPDATE language SET language='hy' WHERE iso_639_code='arm';
UPDATE language SET language='hz' WHERE iso_639_code='her';
UPDATE language SET language='ia' WHERE iso_639_code='ina';
UPDATE language SET language='id' WHERE iso_639_code='ind';
UPDATE language SET language='ie' WHERE iso_639_code='ile';
UPDATE language SET language='ig' WHERE iso_639_code='ibo';
UPDATE language SET language='ii' WHERE iso_639_code='iii';
UPDATE language SET language='ik' WHERE iso_639_code='ipk';
UPDATE language SET language='io' WHERE iso_639_code='ido';
UPDATE language SET language='is' WHERE iso_639_code='ice';
UPDATE language SET language='it' WHERE iso_639_code='ita';
UPDATE language SET language='iu' WHERE iso_639_code='iku';
UPDATE language SET language='ja' WHERE iso_639_code='jpn';
UPDATE language SET language='jv' WHERE iso_639_code='jav';
UPDATE language SET language='ka' WHERE iso_639_code='geo';
UPDATE language SET language='kg' WHERE iso_639_code='kon';
UPDATE language SET language='ki' WHERE iso_639_code='kik';
UPDATE language SET language='kj' WHERE iso_639_code='kua';
UPDATE language SET language='kk' WHERE iso_639_code='kaz';
UPDATE language SET language='kl' WHERE iso_639_code='kal';
UPDATE language SET language='km' WHERE iso_639_code='khm';
UPDATE language SET language='kn' WHERE iso_639_code='kan';
UPDATE language SET language='ko' WHERE iso_639_code='kor';
UPDATE language SET language='kr' WHERE iso_639_code='kau';
UPDATE language SET language='ks' WHERE iso_639_code='kas';
UPDATE language SET language='ku' WHERE iso_639_code='kur';
UPDATE language SET language='kv' WHERE iso_639_code='kom';
UPDATE language SET language='kw' WHERE iso_639_code='cor';
UPDATE language SET language='ky' WHERE iso_639_code='kir';
UPDATE language SET language='la' WHERE iso_639_code='lat';
UPDATE language SET language='lb' WHERE iso_639_code='ltz';
UPDATE language SET language='lg' WHERE iso_639_code='lug';
UPDATE language SET language='li' WHERE iso_639_code='lim';
UPDATE language SET language='ln' WHERE iso_639_code='lin';
UPDATE language SET language='lo' WHERE iso_639_code='lao';
UPDATE language SET language='lt' WHERE iso_639_code='lit';
UPDATE language SET language='lu' WHERE iso_639_code='lub';
UPDATE language SET language='lv' WHERE iso_639_code='lav';
UPDATE language SET language='mg' WHERE iso_639_code='mlg';
UPDATE language SET language='mh' WHERE iso_639_code='mah';
UPDATE language SET language='mi' WHERE iso_639_code='mao';
UPDATE language SET language='mk' WHERE iso_639_code='mac';
UPDATE language SET language='ml' WHERE iso_639_code='mal';
UPDATE language SET language='mn' WHERE iso_639_code='mon';
UPDATE language SET language='mo' WHERE iso_639_code='mol';
UPDATE language SET language='mr' WHERE iso_639_code='mar';
UPDATE language SET language='ms' WHERE iso_639_code='may';
UPDATE language SET language='mt' WHERE iso_639_code='mlt';
UPDATE language SET language='my' WHERE iso_639_code='bur';
UPDATE language SET language='na' WHERE iso_639_code='nau';
UPDATE language SET language='nb' WHERE iso_639_code='nob';
UPDATE language SET language='nd' WHERE iso_639_code='nde';
UPDATE language SET language='ne' WHERE iso_639_code='nep';
UPDATE language SET language='ng' WHERE iso_639_code='ndo';
UPDATE language SET language='nl' WHERE iso_639_code='dut';
UPDATE language SET language='nn' WHERE iso_639_code='nno';
UPDATE language SET language='no' WHERE iso_639_code='nor';
UPDATE language SET language='nr' WHERE iso_639_code='nbl';
UPDATE language SET language='nv' WHERE iso_639_code='nav';
UPDATE language SET language='ny' WHERE iso_639_code='nya';
UPDATE language SET language='oc' WHERE iso_639_code='oci';
UPDATE language SET language='oj' WHERE iso_639_code='oji';
UPDATE language SET language='om' WHERE iso_639_code='orm';
UPDATE language SET language='or' WHERE iso_639_code='ori';
UPDATE language SET language='os' WHERE iso_639_code='oss';
UPDATE language SET language='pa' WHERE iso_639_code='pan';
UPDATE language SET language='pi' WHERE iso_639_code='pli';
UPDATE language SET language='pl' WHERE iso_639_code='pol';
UPDATE language SET language='ps' WHERE iso_639_code='pus';
UPDATE language SET language='pt' WHERE iso_639_code='por';
UPDATE language SET language='qu' WHERE iso_639_code='que';
UPDATE language SET language='rm' WHERE iso_639_code='roh';
UPDATE language SET language='rn' WHERE iso_639_code='run';
UPDATE language SET language='ro' WHERE iso_639_code='rum';
UPDATE language SET language='ru' WHERE iso_639_code='rus';
UPDATE language SET language='rw' WHERE iso_639_code='kin';
UPDATE language SET language='ry' WHERE iso_639_code='sla';
UPDATE language SET language='sa' WHERE iso_639_code='san';
UPDATE language SET language='sc' WHERE iso_639_code='srd';
UPDATE language SET language='sd' WHERE iso_639_code='snd';
UPDATE language SET language='se' WHERE iso_639_code='sme';
UPDATE language SET language='sg' WHERE iso_639_code='sag';
INSERT INTO language(language) VALUES ('sh');
UPDATE language SET language='si' WHERE iso_639_code='sin';
UPDATE language SET language='sk' WHERE iso_639_code='slo';
UPDATE language SET language='sl' WHERE iso_639_code='slv';
UPDATE language SET language='sm' WHERE iso_639_code='smo';
UPDATE language SET language='sn' WHERE iso_639_code='sna';
UPDATE language SET language='so' WHERE iso_639_code='som';
UPDATE language SET language='sq' WHERE iso_639_code='alb';
UPDATE language SET language='sr' WHERE iso_639_code='scc';
UPDATE language SET language='ss' WHERE iso_639_code='ssw';
UPDATE language SET language='st' WHERE iso_639_code='sot';
UPDATE language SET language='su' WHERE iso_639_code='sun';
UPDATE language SET language='sv' WHERE iso_639_code='swe';
UPDATE language SET language='sw' WHERE iso_639_code='swa';
UPDATE language SET language='ta' WHERE iso_639_code='tam';
UPDATE language SET language='te' WHERE iso_639_code='tel';
UPDATE language SET language='tg' WHERE iso_639_code='tgk';
UPDATE language SET language='th' WHERE iso_639_code='tha';
UPDATE language SET language='ti' WHERE iso_639_code='tir';
UPDATE language SET language='tk' WHERE iso_639_code='tuk';
UPDATE language SET language='tl' WHERE iso_639_code='tgl';
UPDATE language SET language='tn' WHERE iso_639_code='tsn';
UPDATE language SET language='to' WHERE iso_639_code='ton';
UPDATE language SET language='tr' WHERE iso_639_code='tur';
UPDATE language SET language='ts' WHERE iso_639_code='tso';
UPDATE language SET language='tt' WHERE iso_639_code='tat';
UPDATE language SET language='tw' WHERE iso_639_code='twi';
UPDATE language SET language='ty' WHERE iso_639_code='tah';
UPDATE language SET language='ug' WHERE iso_639_code='uig';
UPDATE language SET language='uk' WHERE iso_639_code='ukr';
UPDATE language SET language='ur' WHERE iso_639_code='urd';
UPDATE language SET language='uz' WHERE iso_639_code='uzb';
UPDATE language SET language='ve' WHERE iso_639_code='ven';
UPDATE language SET language='vi' WHERE iso_639_code='vie';
UPDATE language SET language='vo' WHERE iso_639_code='vol';
UPDATE language SET language='wa' WHERE iso_639_code='wln';
UPDATE language SET language='wo' WHERE iso_639_code='wol';
UPDATE language SET language='xh' WHERE iso_639_code='xho';
UPDATE language SET language='yi' WHERE iso_639_code='yid';
UPDATE language SET language='yo' WHERE iso_639_code='yor';
UPDATE language SET language='za' WHERE iso_639_code='zha';
UPDATE language SET language='zh' WHERE iso_639_code='chi';
UPDATE language SET language='zu' WHERE iso_639_code='zul';

DELETE FROM language WHERE language IS NULL;
ALTER TABLE language RENAME TO old_language;
CREATE TABLE base.language ( language TEXT NOT NULL, localized BOOL NOT NULL DEFAULT FALSE);
CREATE TABLE language ( PRIMARY KEY (language)) INHERITS( base.language );
CREATE TABLE log.language () INHERITS( base.logging, base.language );
INSERT INTO language(language,localized) SELECT language,f_localized FROM old_language;

ALTER TABLE language_localized RENAME TO old_language_localized;
CREATE TABLE base.language_localized ( language TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE language_localized (
  FOREIGN KEY( language ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( translated ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY ( language, translated )
) INHERITS( base.language_localized );
CREATE TABLE log.language_localized () INHERITS( base.logging, base.language_localized );
INSERT INTO language_localized(language,translated,name) SELECT (SELECT language FROM old_language WHERE old_language.language_id = old_language_localized.language_id),(SELECT language FROM old_language WHERE old_language.language_id = old_language_localized.translated_id), name FROM old_language_localized;
DROP TABLE old_language_localized CASCADE;

ALTER TABLE auth.permission RENAME TO old_permission;
CREATE TABLE base.permission ( permission TEXT NOT NULL, rank INTEGER);
CREATE TABLE auth.permission ( PRIMARY KEY(permission)) INHERITS( base.permission );
CREATE TABLE log.permission ( PRIMARY KEY(permission)) INHERITS( base.logging, base.permission );
INSERT INTO auth.permission(permission,rank) SELECT permission,rank FROM auth.old_permission;

ALTER TABLE auth.permission_localized RENAME TO old_permission_localized;
CREATE TABLE base.permission_localized ( permission TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE auth.permission_localized (
  PRIMARY KEY( permission, translated ),
  FOREIGN KEY( permission ) REFERENCES auth.permission( permission ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( translated ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.permission_localized );
CREATE TABLE log.permission_localized () INHERITS( base.logging, base.permission_localized );
INSERT INTO auth.permission_localized(permission,translated,name) SELECT permission,(SELECT language FROM old_language WHERE old_language.language_id=old_permission_localized.translated_id),name FROM auth.old_permission_localized;
DROP TABLE auth.old_permission_localized;

ALTER TABLE auth.role RENAME TO old_role;
CREATE TABLE base.role ( role TEXT NOT NULL, rank INTEGER);
CREATE TABLE auth.role ( PRIMARY KEY( role )) INHERITS( base.role );
CREATE TABLE log.role () INHERITS( base.logging, base.role );
INSERT INTO auth.role(role,rank) SELECT role,rank FROM auth.old_role;

ALTER TABLE auth.role_localized RENAME TO old_role_localized;
CREATE TABLE base.role_localized ( role TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE auth.role_localized (
  PRIMARY KEY( role, translated ),
  FOREIGN KEY( role ) REFERENCES auth.role( role ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( translated ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.role_localized );
CREATE TABLE log.role_localized () INHERITS( base.logging, base.role_localized );
INSERT INTO auth.role_localized(role,translated,name) SELECT role,(SELECT language FROM old_language WHERE old_language.language_id=old_role_localized.translated_id),name FROM auth.old_role_localized;
DROP TABLE auth.old_role_localized;

ALTER TABLE auth.role_permission RENAME TO old_role_permission;
CREATE TABLE base.role_permission ( role TEXT NOT NULL, permission TEXT NOT NULL);
CREATE TABLE auth.role_permission (
  PRIMARY KEY( role, permission ),
  FOREIGN KEY( role ) REFERENCES auth.role( role ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( permission ) REFERENCES auth.permission( permission ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.role_permission );
CREATE TABLE log.role_permission () INHERITS( base.logging, base.role_permission );
INSERT INTO auth.role_permission(role,permission) SELECT role,permission FROM auth.old_role_permission;
DROP TABLE auth.old_role_permission;
DROP TABLE auth.old_permission;

ALTER TABLE country RENAME TO old_country;
CREATE TABLE base.country ( country TEXT NOT NULL);
CREATE TABLE country ( PRIMARY KEY( country )) INHERITS( base.country );
CREATE TABLE log.country () INHERITS( base.logging, base.country );
INSERT INTO country(country) SELECT iso_3166_code FROM old_country;

ALTER TABLE country_localized RENAME TO old_country_localized;
CREATE TABLE base.country_localized ( country TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE country_localized (
  FOREIGN KEY( country ) REFERENCES country( country ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( translated ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY( country, translated )
) INHERITS( base.country_localized );
CREATE TABLE log.country_localized () INHERITS( base.logging, base.country_localized );
INSERT INTO country_localized(country,translated,name) SELECT (SELECT iso_3166_code FROM old_country WHERE old_country.country_id=old_country_localized.country_id),(SELECT language FROM old_language WHERE old_language.language_id=old_country_localized.language_id),name FROM old_country_localized;
DROP TABLE old_country_localized CASCADE;

ALTER TABLE currency RENAME TO old_currency;
CREATE TABLE base.currency ( currency TEXT NOT NULL, exchange_rate DECIMAL(15,5));
CREATE TABLE currency ( PRIMARY KEY( currency )) INHERITS( base.currency ); 
CREATE TABLE log.currency () INHERITS( base.logging, base.currency );
INSERT INTO currency(currency) SELECT iso_4217_code FROM old_currency;

ALTER TABLE currency_localized RENAME TO old_currency_localized;
CREATE TABLE base.currency_localized ( currency TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE currency_localized (
  FOREIGN KEY (currency) REFERENCES currency (currency) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (currency, translated)
) INHERITS( base.currency_localized );
CREATE TABLE log.currency_localized () INHERITS( base.logging, base.currency_localized );
INSERT INTO currency_localized(currency,translated,name) SELECT (SELECT iso_4217_code FROM old_currency WHERE old_currency.currency_id=old_currency_localized.currency_id),(SELECT language FROM old_language WHERE old_language.language_id=old_currency_localized.language_id),name FROM old_currency_localized;
DROP TABLE old_currency_localized CASCADE;

ALTER TABLE transport RENAME TO old_transport;
CREATE TABLE base.transport ( transport TEXT, rank INTEGER); 
CREATE TABLE transport ( PRIMARY KEY (transport)) INHERITS( base.transport );
CREATE TABLE log.transport () INHERITS( base.logging, base.transport );
INSERT INTO transport(transport) SELECT tag FROM old_transport;

ALTER TABLE transport_localized RENAME TO old_transport_localized;
CREATE TABLE base.transport_localized ( transport TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE transport_localized (
  FOREIGN KEY (transport) REFERENCES transport (transport) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (transport, translated)
) INHERITS( base.transport_localized );
CREATE TABLE log.transport_localized () INHERITS( base.logging, base.transport_localized );
INSERT INTO transport_localized(transport,translated,name) SELECT (SELECT tag FROM old_transport WHERE old_transport.transport_id=old_transport_localized.transport_id),(SELECT language FROM old_language WHERE old_language.language_id=old_transport_localized.language_id),name FROM old_transport_localized;
DROP TABLE old_transport_localized CASCADE;

ALTER TABLE ui_message RENAME TO old_ui_message;
CREATE TABLE base.ui_message ( ui_message TEXT NOT NULL );
CREATE TABLE ui_message ( PRIMARY KEY (ui_message)) INHERITS( base.ui_message );
CREATE TABLE log.ui_message () INHERITS( base.logging, base.ui_message );
INSERT INTO ui_message(ui_message) SELECT ui_message FROM old_ui_message;

ALTER TABLE ui_message_localized RENAME TO old_ui_message_localized;
CREATE TABLE base.ui_message_localized ( ui_message TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE ui_message_localized (
  FOREIGN KEY (ui_message) REFERENCES ui_message (ui_message) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (ui_message, translated)
) INHERITS( base.ui_message_localized );
CREATE TABLE log.ui_message_localized () INHERITS( base.logging, base.ui_message_localized );
INSERT INTO ui_message_localized(ui_message,translated,name) SELECT ui_message,(SELECT language FROM old_language WHERE old_language.language_id=old_ui_message_localized.language_id),name FROM old_ui_message_localized;
DROP TABLE old_ui_message_localized;
DROP TABLE old_ui_message;

ALTER TABLE phone_type RENAME TO old_phone_type;
CREATE TABLE base.phone_type ( phone_type TEXT NOT NULL, scheme TEXT, rank INTEGER);
CREATE TABLE phone_type ( PRIMARY KEY( phone_type )) INHERITS( base.phone_type );
CREATE TABLE log.phone_type () INHERITS( base.logging, base.phone_type );
INSERT INTO phone_type(phone_type,scheme,rank) SELECT phone_type,scheme,rank FROM old_phone_type;

ALTER TABLE phone_type_localized RENAME TO old_phone_type_localized;
CREATE TABLE base.phone_type_localized ( phone_type TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE phone_type_localized (
  FOREIGN KEY (phone_type) REFERENCES phone_type (phone_type) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (phone_type, translated)
) INHERITS( base.phone_type_localized );
CREATE TABLE log.phone_type_localized () INHERITS( base.logging, base.phone_type_localized );
INSERT INTO phone_type_localized(phone_type,translated,name) SELECT phone_type,(SELECT language FROM old_language WHERE old_language.language_id=old_phone_type_localized.language_id),name FROM old_phone_type_localized;
DROP TABLE old_phone_type_localized;

ALTER TABLE mime_type RENAME TO old_mime_type;
CREATE TABLE base.mime_type ( mime_type TEXT NOT NULL, file_extension TEXT, image BOOL NOT NULL DEFAULT FALSE);
CREATE TABLE mime_type ( PRIMARY KEY (mime_type)) INHERITS( base.mime_type );
CREATE TABLE log.mime_type () INHERITS( base.logging, base.mime_type );
INSERT INTO mime_type(mime_type,file_extension,image) SELECT mime_type,file_extension,f_image FROM old_mime_type;

ALTER TABLE mime_type_localized RENAME TO old_mime_type_localized;
CREATE TABLE base.mime_type_localized ( mime_type TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE mime_type_localized (
  FOREIGN KEY (mime_type) REFERENCES mime_type (mime_type) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (mime_type, translated)
) INHERITS( base.mime_type_localized );
CREATE TABLE log.mime_type_localized () INHERITS( base.logging, base.mime_type_localized );
INSERT INTO mime_type_localized(mime_type,translated,name) SELECT mime_type,(SELECT language FROM old_language WHERE old_language.language_id=old_mime_type_localized.language_id),name FROM old_mime_type_localized;
DROP TABLE old_mime_type_localized CASCADE;

ALTER TABLE im_type RENAME TO old_im_type;
CREATE TABLE base.im_type ( im_type TEXT NOT NULL, scheme TEXT, rank INTEGER);
CREATE TABLE im_type ( PRIMARY KEY (im_type)) INHERITS( base.im_type );
CREATE TABLE log.im_type () INHERITS( base.logging, base.im_type );
INSERT INTO im_type( im_type, scheme, rank ) SELECT im_type,scheme,rank FROM old_im_type;

ALTER TABLE im_type_localized RENAME TO old_im_type_localized;
CREATE TABLE base.im_type_localized ( im_type TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE im_type_localized (
  FOREIGN KEY (im_type) REFERENCES im_type (im_type) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (im_type, translated)
) INHERITS( base.im_type_localized );
CREATE TABLE log.im_type_localized () INHERITS( base.logging, base.im_type_localized );
INSERT INTO im_type_localized(im_type,translated,name) SELECT im_type,(SELECT language FROM old_language WHERE old_language.language_id=old_im_type_localized.language_id),name FROM old_im_type_localized;
DROP TABLE old_im_type_localized;

-- get proper timezone stuff
DROP TABLE time_zone_localized CASCADE;
DROP TABLE time_zone CASCADE;

CREATE TABLE base.timezone ( timezone TEXT NOT NULL, abbreviation TEXT NOT NULL, utc_offset INTERVAL NOT NULL);
CREATE TABLE timezone ( PRIMARY KEY( timezone )) INHERITS( base.timezone );
CREATE TABLE log.timezone () INHERITS( base.logging, base.timezone );

INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Abidjan', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Accra', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Addis_Ababa', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Algiers', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Asmara', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Asmera', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Bamako', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Bangui', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Banjul', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Bissau', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Blantyre', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Brazzaville', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Bujumbura', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Cairo', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Casablanca', 'WET', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Ceuta', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Conakry', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Dakar', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Dar_es_Salaam', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Djibouti', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Douala', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/El_Aaiun', 'WET', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Freetown', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Gaborone', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Harare', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Johannesburg', 'SAST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Kampala', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Khartoum', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Kigali', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Kinshasa', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Lagos', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Libreville', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Lome', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Luanda', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Lubumbashi', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Lusaka', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Malabo', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Maputo', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Maseru', 'SAST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Mbabane', 'SAST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Mogadishu', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Monrovia', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Nairobi', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Ndjamena', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Niamey', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Nouakchott', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Ouagadougou', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Porto-Novo', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Sao_Tome', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Timbuktu', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Tripoli', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Tunis', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Africa/Windhoek', 'WAST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Adak', 'HADT', '-09:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Anchorage', 'AKDT', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Anguilla', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Antigua', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Araguaina', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Argentina/Buenos_Aires', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Argentina/Catamarca', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Argentina/ComodRivadavia', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Argentina/Cordoba', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Argentina/Jujuy', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Argentina/La_Rioja', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Argentina/Mendoza', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Argentina/Rio_Gallegos', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Argentina/San_Juan', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Argentina/Tucuman', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Argentina/Ushuaia', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Aruba', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Asuncion', 'PYST', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Atikokan', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Atka', 'HADT', '-09:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Bahia', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Barbados', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Belem', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Belize', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Blanc-Sablon', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Boa_Vista', 'AMT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Bogota', 'COT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Boise', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Buenos_Aires', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Cambridge_Bay', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Campo_Grande', 'AMT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Cancun', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Caracas', 'VET', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Catamarca', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Cayenne', 'GFT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Cayman', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Chicago', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Chihuahua', 'MST', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Coral_Harbour', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Cordoba', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Costa_Rica', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Cuiaba', 'AMT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Curacao', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Danmarkshavn', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Dawson', 'PDT', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Dawson_Creek', 'MST', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Denver', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Detroit', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Dominica', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Edmonton', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Eirunepe', 'ACT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/El_Salvador', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Ensenada', 'PST', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Fortaleza', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Fort_Wayne', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Glace_Bay', 'ADT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Godthab', 'WGT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Goose_Bay', 'ADT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Grand_Turk', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Grenada', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Guadeloupe', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Guatemala', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Guayaquil', 'ECT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Guyana', 'GYT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Halifax', 'ADT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Havana', 'CDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Hermosillo', 'MST', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Indiana/Indianapolis', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Indiana/Knox', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Indiana/Marengo', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Indiana/Petersburg', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Indianapolis', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Indiana/Tell_City', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Indiana/Vevay', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Indiana/Vincennes', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Indiana/Winamac', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Inuvik', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Iqaluit', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Jamaica', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Jujuy', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Juneau', 'AKDT', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Kentucky/Louisville', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Kentucky/Monticello', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Knox_IN', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/La_Paz', 'BOT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Lima', 'PET', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Los_Angeles', 'PDT', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Louisville', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Maceio', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Managua', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Manaus', 'AMT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Martinique', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Mazatlan', 'MST', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Mendoza', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Menominee', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Merida', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Mexico_City', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Miquelon', 'PMDT', '-02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Moncton', 'ADT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Monterrey', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Montevideo', 'UYST', '-02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Montreal', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Montserrat', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Nassau', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/New_York', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Nipigon', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Nome', 'AKDT', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Noronha', 'FNT', '-02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/North_Dakota/Center', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/North_Dakota/New_Salem', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Panama', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Pangnirtung', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Paramaribo', 'SRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Phoenix', 'MST', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Port-au-Prince', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Porto_Acre', 'ACT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Port_of_Spain', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Porto_Velho', 'AMT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Puerto_Rico', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Rainy_River', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Rankin_Inlet', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Recife', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Regina', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Resolute', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Rio_Branco', 'ACT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Rosario', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Santiago', 'CLST', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Santo_Domingo', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Sao_Paulo', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Scoresbysund', 'EGT', '-01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Shiprock', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/St_Johns', 'NDT', '-02:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/St_Kitts', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/St_Lucia', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/St_Thomas', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/St_Vincent', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Swift_Current', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Tegucigalpa', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Thule', 'ADT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Thunder_Bay', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Tijuana', 'PST', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Toronto', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Tortola', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Vancouver', 'PDT', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Virgin', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Whitehorse', 'PDT', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Winnipeg', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Yakutat', 'AKDT', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('America/Yellowknife', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Antarctica/Casey', 'WST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Antarctica/Davis', 'DAVT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Antarctica/DumontDUrville', 'DDUT', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Antarctica/Mawson', 'MAWT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Antarctica/McMurdo', 'NZDT', '13:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Antarctica/Palmer', 'CLST', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Antarctica/Rothera', 'ROTT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Antarctica/South_Pole', 'NZDT', '13:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Antarctica/Syowa', 'SYOT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Antarctica/Vostok', 'VOST', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Aden', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Almaty', 'ALMT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Amman', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Anadyr', 'ANAT', '12:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Aqtau', 'AQTT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Aqtobe', 'AQTT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Ashgabat', 'TMT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Ashkhabad', 'TMT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Baghdad', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Bahrain', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Baku', 'AZT', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Bangkok', 'ICT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Beirut', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Bishkek', 'KGT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Brunei', 'BNT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Calcutta', 'IST', '05:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Choibalsan', 'CHOT', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Chongqing', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Chungking', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Colombo', 'IST', '05:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Dacca', 'BDT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Damascus', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Dhaka', 'BDT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Dili', 'TLT', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Dubai', 'GST', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Dushanbe', 'TJT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Gaza', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Harbin', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Hong_Kong', 'HKT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Hovd', 'HOVT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Irkutsk', 'IRKT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Istanbul', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Jakarta', 'WIT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Jayapura', 'EIT', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Jerusalem', 'IST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Kabul', 'AFT', '04:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Kamchatka', 'PETT', '12:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Karachi', 'PKT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Kashgar', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Katmandu', 'NPT', '05:45:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Krasnoyarsk', 'KRAT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Kuala_Lumpur', 'MYT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Kuching', 'MYT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Kuwait', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Macao', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Macau', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Magadan', 'MAGT', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Makassar', 'CIT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Manila', 'PHT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Muscat', 'GST', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Nicosia', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Novosibirsk', 'NOVT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Omsk', 'OMST', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Oral', 'ORAT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Phnom_Penh', 'ICT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Pontianak', 'WIT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Pyongyang', 'KST', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Qatar', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Qyzylorda', 'QYZT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Rangoon', 'MMT', '06:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Riyadh', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Riyadh87', 'zzz', '03:07:04');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Riyadh88', 'zzz', '03:07:04');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Riyadh89', 'zzz', '03:07:04');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Saigon', 'ICT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Sakhalin', 'SAKT', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Samarkand', 'UZT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Seoul', 'KST', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Shanghai', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Singapore', 'SGT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Taipei', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Tashkent', 'UZT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Tbilisi', 'GET', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Tehran', 'IRST', '03:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Tel_Aviv', 'IST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Thimbu', 'BTT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Thimphu', 'BTT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Tokyo', 'JST', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Ujung_Pandang', 'CIT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Ulaanbaatar', 'ULAT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Ulan_Bator', 'ULAT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Urumqi', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Vientiane', 'ICT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Vladivostok', 'VLAT', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Yakutsk', 'YAKT', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Yekaterinburg', 'YEKT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Asia/Yerevan', 'AMT', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/ACT', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Adelaide', 'CST', '10:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Brisbane', 'EST', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Broken_Hill', 'CST', '10:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Canberra', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Currie', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Darwin', 'CST', '09:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Eucla', 'CWST', '09:45:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Hobart', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/LHI', 'LHST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Lindeman', 'EST', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Lord_Howe', 'LHST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Melbourne', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/North', 'CST', '09:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/NSW', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Perth', 'WST', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Queensland', 'EST', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/South', 'CST', '10:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Sydney', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Tasmania', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Victoria', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/West', 'WST', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Australia/Yancowinna', 'CST', '10:30:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Amsterdam', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Andorra', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Athens', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Belfast', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Belgrade', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Berlin', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Bratislava', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Brussels', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Bucharest', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Budapest', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Chisinau', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Copenhagen', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Dublin', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Gibraltar', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Guernsey', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Helsinki', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Isle_of_Man', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Istanbul', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Jersey', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Kaliningrad', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Kiev', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Lisbon', 'WET', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Ljubljana', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/London', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Luxembourg', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Madrid', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Malta', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Mariehamn', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Minsk', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Monaco', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Moscow', 'MSK', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Nicosia', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Oslo', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Paris', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Podgorica', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Prague', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Riga', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Rome', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Samara', 'SAMT', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/San_Marino', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Sarajevo', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Simferopol', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Skopje', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Sofia', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Stockholm', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Tallinn', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Tirane', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Tiraspol', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Uzhgorod', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Vaduz', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Vatican', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Vienna', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Vilnius', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Volgograd', 'VOLT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Warsaw', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Zagreb', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Zaporozhye', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utc_offset) VALUES ('Europe/Zurich', 'CET', '01:00:00');

ALTER TABLE link_type RENAME TO old_link_type;
CREATE TABLE base.link_type ( link_type TEXT NOT NULL, template TEXT, rank INTEGER);
CREATE TABLE link_type ( PRIMARY KEY (link_type)) INHERITS( base.link_type ); 
CREATE TABLE log.link_type () INHERITS( base.logging, base.link_type );
INSERT INTO link_type(link_type,template,rank) SELECT link_type,template,rank FROM old_link_type;

ALTER TABLE link_type_localized RENAME TO old_link_type_localized;
CREATE TABLE base.link_type_localized ( link_type TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE link_type_localized (
  FOREIGN KEY (link_type) REFERENCES link_type (link_type) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (link_type, translated)
) INHERITS( base.link_type_localized );
CREATE TABLE log.link_type_localized () INHERITS( base.logging, base.link_type_localized );
INSERT INTO link_type_localized(link_type,translated,name) SELECT link_type,(SELECT language FROM old_language WHERE old_language.language_id=old_link_type_localized.language_id),name FROM old_link_type_localized;
DROP TABLE old_link_type_localized CASCADE;

ALTER TABLE conference_phase RENAME TO old_conference_phase;
CREATE TABLE base.conference_phase ( conference_phase TEXT NOT NULL, rank INTEGER);
CREATE TABLE conference_phase ( PRIMARY KEY (conference_phase)) INHERITS( base.conference_phase ); 
CREATE TABLE log.conference_phase () INHERITS( base.logging, base.conference_phase );
INSERT INTO conference_phase(conference_phase,rank) SELECT conference_phase,rank FROM old_conference_phase;

ALTER TABLE conference_phase_localized RENAME TO old_conference_phase_localized;
CREATE TABLE base.conference_phase_localized ( conference_phase TEXT NOT NULL, translated TEXT NOT NULL, name TEXT NOT NULL);
CREATE TABLE conference_phase_localized (
  FOREIGN KEY (conference_phase) REFERENCES conference_phase (conference_phase) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (translated) REFERENCES language (language) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_phase, translated)
) INHERITS( base.conference_phase_localized );
CREATE TABLE log.conference_phase_localized () INHERITS( base.logging, base.conference_phase_localized );
INSERT INTO conference_phase_localized(conference_phase,translated,name) SELECT conference_phase,(SELECT language FROM old_language WHERE old_language.language_id=old_conference_phase_localized.language_id),name FROM old_conference_phase_localized;
DROP TABLE old_conference_phase_localized;

-- make conference use new logging
ALTER TABLE conference RENAME TO old_conference;
CREATE TABLE base.conference (
  conference_id SERIAL NOT NULL,
  acronym TEXT NOT NULL UNIQUE,
  title TEXT NOT NULL,
  subtitle TEXT,
  conference_phase TEXT NOT NULL,
  start_date DATE NOT NULL,
  days SMALLINT NOT NULL DEFAULT 1,
  venue TEXT,
  city TEXT,
  country TEXT,
  timezone TEXT NOT NULL DEFAULT 'Europe/Berlin',
  currency TEXT,
  timeslot_duration INTERVAL NOT NULL DEFAULT '1:00:00',
  default_timeslots INTEGER NOT NULL DEFAULT 1,
  max_timeslot_duration INTEGER NOT NULL DEFAULT 10,
  day_change TIME WITHOUT TIME ZONE NOT NULL DEFAULT '0:00:00',
  remark TEXT,
  release TEXT,
  homepage TEXT,
  abstract_length INTEGER,
  description_length INTEGER,
  export_base_url TEXT,
  export_css_file TEXT,
  feedback_base_url TEXT,
  css TEXT,
  email TEXT,
  f_feedback_enabled BOOL NOT NULL DEFAULT FALSE,
  f_submission_enabled BOOL NOT NULL DEFAULT FALSE,
  f_visitor_enabled BOOL NOT NULL DEFAULT FALSE,
  f_reconfirmation_enabled BOOL NOT NULL DEFAULT FALSE
);
CREATE TABLE conference (
  FOREIGN KEY (conference_phase) REFERENCES conference_phase (conference_phase) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (country) REFERENCES country (country) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (timezone) REFERENCES timezone (timezone) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (currency) REFERENCES currency (currency) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY (conference_id)
) INHERITS( base.conference );
CREATE TABLE log.conference() INHERITS( base.logging, base.conference );
INSERT INTO conference( conference_id, acronym, title, subtitle, conference_phase, start_date, days, venue, city, country, currency, timeslot_duration, default_timeslots, max_timeslot_duration, day_change, remark, release, homepage, abstract_length, description_length, export_base_url, export_css_file, feedback_base_url, css, email, f_feedback_enabled, f_submission_enabled, f_visitor_enabled, f_reconfirmation_enabled ) SELECT conference_id, acronym, title, subtitle, conference_phase, start_date, days, venue, city, (SELECT iso_3166_code FROM old_country WHERE old_country.country_id = old_conference.country_id), (SELECT iso_4217_code FROM old_currency WHERE old_currency.currency_id = old_conference.currency_id), timeslot_duration, default_timeslots, max_timeslot_duration, day_change, remark, release, homepage, abstract_length, description_length, export_base_url, export_css_file, feedback_base_url, css, email, f_feedback_enabled, f_submission_enabled, f_visitor_enabled, f_reconfirmation_enabled FROM old_conference;
SELECT setval('base.conference_conference_id_seq',(SELECT max(conference_id) FROM conference));

ALTER TABLE conference_language RENAME TO old_conference_language;
CREATE TABLE base.conference_language ( conference_id INTEGER NOT NULL, language TEXT NOT NULL, rank INTEGER);
CREATE TABLE conference_language (
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language) REFERENCES language (language) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conference_id, language)
) INHERITS( base.conference_language );
CREATE TABLE log.conference_language () INHERITS( base.logging, base.conference_language );
INSERT INTO conference_language(conference_id,language) SELECT conference_id, (SELECT language FROM old_language WHERE old_language.language_id = old_conference_language.language_id) FROM old_conference_language;
DROP TABLE old_conference_language;

ALTER TABLE conference_link RENAME TO old_conference_link;
CREATE TABLE base.conference_link ( conference_link_id SERIAL NOT NULL, conference_id INTEGER NOT NULL, url TEXT NOT NULL, title TEXT, rank INTEGER);
CREATE TABLE conference_link ( FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (conference_link_id)) INHERITS( base.conference_link );
CREATE TABLE log.conference_link () INHERITS( base.logging,base.conference_link );
INSERT INTO conference_link(conference_id,url,title,rank) SELECT conference_id,url,title,rank FROM old_conference_link;
DROP TABLE old_conference_link;

DROP TABLE conference_localized;

ALTER TABLE conference_image RENAME TO old_conference_image;
CREATE TABLE base.conference_image ( conference_id INTEGER NOT NULL, mime_type TEXT NOT NULL, image BYTEA NOT NULL);
CREATE TABLE conference_image (
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (mime_type) REFERENCES mime_type (mime_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conference_id)
) INHERITS( base.conference_image );
CREATE TABLE log.conference_image () INHERITS( base.logging, base.conference_image );
INSERT INTO conference_image(conference_id,mime_type,image) SELECT conference_id,mime_type,image FROM old_conference_image;
DROP TABLE old_conference_image CASCADE;

ALTER TABLE conference_track RENAME TO old_conference_track;
CREATE TABLE base.conference_track ( conference_track TEXT NOT NULL, conference_id INTEGER NOT NULL, rank INTEGER, CHECK (strpos( conference_track, '/' ) = 0));
CREATE TABLE conference_track (
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_track,conference_id)
) INHERITS( base.conference_track );
CREATE TABLE log.conference_track () INHERITS( base.logging, base.conference_track );
INSERT INTO conference_track(conference_track,conference_id,rank) SELECT tag,conference_id,rank FROM old_conference_track;

DROP TABLE conference_track_localized CASCADE;

ALTER TABLE room RENAME TO old_room;
CREATE TABLE base.conference_room ( conference_id INTEGER NOT NULL, conference_room TEXT NOT NULL, public BOOL NOT NULL DEFAULT FALSE, size INTEGER, remark TEXT, rank INTEGER);
CREATE TABLE conference_room(
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_room, conference_id)
) INHERITS( base.conference_room );
CREATE TABLE log.conference_room() INHERITS( base.logging, base.conference_room );
INSERT INTO conference_room(conference_id,conference_room,public,size,remark,rank) SELECT conference_id,short_name,f_public,size,remark,rank FROM old_room;
DROP TABLE room_localized CASCADE;

-- make person use new logging
ALTER TABLE person RENAME TO old_person;

CREATE TABLE base.person (
  person_id SERIAL NOT NULL,
  title TEXT,
  gender BOOL,
  first_name TEXT,
  last_name TEXT,
  public_name TEXT,
  nickname TEXT,
  email TEXT,
  spam BOOL NOT NULL DEFAULT FALSE,
  address TEXT,
  street TEXT,
  street_postcode TEXT,
  po_box TEXT,
  po_box_postcode TEXT,
  city TEXT,
  country TEXT,
  iban TEXT,
  bic TEXT,
  bank_name TEXT,
  account_owner TEXT
);
CREATE TABLE public.person(
  CHECK (first_name IS NOT NULL OR last_name IS NOT NULL OR public_name IS NOT NULL OR nickname IS NOT NULL),
  FOREIGN KEY (country) REFERENCES country (country) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY (person_id)
) INHERITS( base.person );
CREATE TABLE log.person() INHERITS( base.logging, base.person );
INSERT INTO public.person( person_id, title, gender, first_name, last_name, public_name, nickname, email, spam, address, street, street_postcode, po_box, po_box_postcode, city, country, iban, bic, bank_name, account_owner ) SELECT person_id, title, gender, first_name, last_name, public_name, coalesce(nickname,login_name), email_contact, f_spam, address, street, street_postcode, po_box, po_box_postcode, city, (SELECT iso_3166_code FROM old_country WHERE old_country.country_id=old_person.country_id), iban, bic, bank_name, account_owner FROM old_person;
SELECT setval('base.person_person_id_seq',(SELECT max(person_id) FROM person));

ALTER TABLE conference_person RENAME TO old_conference_person;
CREATE TABLE base.conference_person (
  conference_person_id SERIAL NOT NULL,
  conference_id INTEGER NOT NULL,
  person_id INTEGER NOT NULL,
  abstract TEXT,
  description TEXT,
  remark TEXT,
  email TEXT
);
CREATE TABLE conference_person (
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_person_id),
  UNIQUE( conference_id, person_id)
) INHERITS( base.conference_person );
CREATE TABLE log.conference_person (
) INHERITS( base.logging, base.conference_person );
INSERT INTO conference_person(conference_person_id,conference_id,person_id,abstract,description,remark,email) SELECT conference_person_id,conference_id,person_id,abstract,description,remark,email_public FROM old_conference_person;
SELECT setval('base.conference_person_conference_person_id_seq',(SELECT max(conference_person_id) FROM conference_person));

ALTER TABLE conference_person_link RENAME TO old_conference_person_link;
CREATE TABLE base.conference_person_link ( conference_person_link_id SERIAL NOT NULL, conference_person_id INTEGER NOT NULL, url TEXT NOT NULL, title TEXT, rank INTEGER);
CREATE TABLE conference_person_link (
  FOREIGN KEY (conference_person_id) REFERENCES conference_person (conference_person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_person_link_id)
) INHERITS( base.conference_person_link );
CREATE TABLE log.conference_person_link () INHERITS( base.logging, base.conference_person_link );
INSERT INTO conference_person_link(conference_person_id,url,title,rank) SELECT conference_person_id,url,title,rank FROM old_conference_person_link;
DROP TABLE old_conference_person_link;

ALTER TABLE conference_person_link_internal RENAME TO old_conference_person_link_internal;
CREATE TABLE base.conference_person_link_internal ( conference_person_link_internal_id SERIAL NOT NULL, conference_person_id INTEGER NOT NULL, link_type TEXT NOT NULL, url TEXT NOT NULL, description TEXT, rank INTEGER);
CREATE TABLE conference_person_link_internal (
  FOREIGN KEY (conference_person_id) REFERENCES conference_person (conference_person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (link_type) REFERENCES link_type (link_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conference_person_link_internal_id)
) INHERITS( base.conference_person_link_internal );
CREATE TABLE log.conference_person_link_internal () INHERITS( base.logging, base.conference_person_link_internal );
INSERT INTO conference_person_link_internal(conference_person_id,link_type,url,description,rank) SELECT conference_person_id,link_type,url,description,rank FROM old_conference_person_link_internal;
DROP TABLE old_conference_person_link_internal;

CREATE TABLE base.account ( account_id SERIAL, login_name TEXT NOT NULL UNIQUE, email TEXT NOT NULL, salt TEXT, password TEXT, edit_token TEXT, current_language TEXT NOT NULL DEFAULT 'en', current_conference_id INTEGER, preferences TEXT, last_login TIMESTAMP, person_id INTEGER, CHECK (login_name <> 'logout'), CHECK ( strpos( login_name, ':' ) = 0 ));
CREATE TABLE auth.account (
  FOREIGN KEY( current_language ) REFERENCES language( language ) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY( current_conference_id ) REFERENCES conference( conference_id ) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY( person_id ) REFERENCES person( person_id ) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY( account_id )
) INHERITS( base.account );
CREATE TABLE log.account () INHERITS( base.logging, base.account );
INSERT INTO auth.account( login_name, email, salt, password, current_language, current_conference_id, preferences, last_login, person_id ) SELECT login_name, email_contact, substring(password, 1, 16), substring(password,17,32), 'en', current_conference_id, preferences, last_login, person_id FROM old_person WHERE login_name IS NOT NULL AND email_contact IS NOT NULL;
INSERT INTO auth.object_domain VALUES ('account','account');

CREATE TABLE base.account_role ( account_id INTEGER NOT NULL, role TEXT NOT NULL);
CREATE TABLE auth.account_role (
  PRIMARY KEY( account_id, role ),
  FOREIGN KEY( account_id) REFERENCES auth.account( account_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( role ) REFERENCES auth.role( role ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.account_role );
CREATE TABLE log.account_role() INHERITS( base.logging, base.account_role );
INSERT INTO auth.account_role(account_id,role) SELECT account_id, role FROM auth.person_role INNER JOIN auth.account USING(person_id);
DROP TABLE base.person_role CASCADE;
UPDATE auth.object_domain SET object = 'account_role' WHERE object = 'person_role';

ALTER TABLE person_phone RENAME TO old_person_phone;
CREATE TABLE base.person_phone ( person_phone_id SERIAL NOT NULL, person_id INTEGER NOT NULL, phone_type TEXT NOT NULL, phone_number TEXT NOT NULL, rank INTEGER);
CREATE TABLE person_phone (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (phone_type) REFERENCES phone_type (phone_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (person_phone_id)
) INHERITS( base.person_phone );
CREATE TABLE log.person_phone () INHERITS( base.logging, base.person_phone );
INSERT INTO person_phone(person_id,phone_type,phone_number,rank) SELECT person_id,phone_type,phone_number,rank FROM old_person_phone;
DROP TABLE old_person_phone;

ALTER TABLE person_rating RENAME TO old_person_rating;
CREATE TABLE base.person_rating (
  person_id INTEGER NOT NULL,
  evaluator_id INTEGER NOT NULL,
  speaker_quality SMALLINT CHECK (speaker_quality > 0 AND speaker_quality < 6),
  competence SMALLINT CHECK (competence > 0 AND competence < 6),
  remark TEXT,
  eval_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);
CREATE TABLE person_rating (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (evaluator_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_id, evaluator_id)
) INHERITS( base.person_rating );
INSERT INTO person_rating(person_id,evaluator_id,speaker_quality,competence,remark,eval_time) SELECT person_id,evaluator_id,speaker_quality,competence,remark,eval_time FROM old_person_rating;
DROP TABLE old_person_rating;

CREATE TABLE base.conference_person_travel (
  conference_person_id INTEGER NOT NULL,
  arrival_transport TEXT NOT NULL,
  arrival_from TEXT,
  arrival_to TEXT,
  arrival_number TEXT,
  arrival_date DATE,
  arrival_time TIME(0) WITH TIME ZONE,
  arrival_pickup BOOL NOT NULL DEFAULT FALSE,
  departure_pickup BOOL NOT NULL DEFAULT FALSE,
  departure_transport TEXT NOT NULL,
  departure_from TEXT,
  departure_to TEXT,
  departure_number TEXT,
  departure_date DATE,
  departure_time TIME(0) WITH TIME ZONE,
  travel_cost DECIMAL(16,2),
  travel_currency TEXT NOT NULL,
  accommodation_cost DECIMAL(16,2),
  accommodation_currency TEXT NOT NULL,
  accommodation_name TEXT,
  accommodation_street TEXT,
  accommodation_postcode TEXT,
  accommodation_city TEXT,
  accommodation_phone TEXT,
  accommodation_phone_room TEXT,
  arrived BOOL NOT NULL DEFAULT FALSE,
  fee DECIMAL(16,2),
  fee_currency TEXT NOT NULL,
  need_travel_cost BOOL NOT NULL DEFAULT FALSE,
  need_accommodation BOOL NOT NULL DEFAULT FALSE,
  need_accommodation_cost BOOL NOT NULL DEFAULT FALSE
);
CREATE TABLE conference_person_travel (
  FOREIGN KEY (conference_person_id) REFERENCES conference_person(conference_person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (arrival_transport) REFERENCES transport (transport) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (departure_transport) REFERENCES transport (transport) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (travel_currency) REFERENCES currency (currency) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (accommodation_currency) REFERENCES currency (currency) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (fee_currency) REFERENCES currency (currency) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (conference_person_id)
) INHERITS( base.conference_person_travel );
CREATE TABLE log.conference_person_travel () INHERITS( base.logging, base.conference_person_travel );
INSERT INTO conference_person(person_id,conference_id) SELECT person_id, conference_id FROM person_travel WHERE NOT EXISTS( SELECT 1 FROM conference_person WHERE conference_person.conference_id = person_travel.conference_id AND conference_person.person_id = person_travel.person_id );
INSERT INTO conference_person_travel(conference_person_id,arrival_transport,arrival_from,arrival_to,arrival_number,arrival_date,arrival_time,arrival_pickup,departure_pickup,departure_transport,departure_from,departure_to,departure_number,departure_date,departure_time,travel_cost,travel_currency,accommodation_cost,accommodation_currency,accommodation_name,accommodation_street,accommodation_postcode,accommodation_city,accommodation_phone,accommodation_phone_room,arrived,fee,fee_currency,need_travel_cost,need_accommodation,need_accommodation_cost) SELECT (SELECT conference_person_id FROM conference_person WHERE conference_person.person_id = person_travel.person_id AND conference_person.conference_id = person_travel.conference_id),(SELECT tag FROM old_transport WHERE old_transport.transport_id = person_travel.arrival_transport_id),arrival_from,arrival_to,arrival_number,arrival_date,arrival_time,f_arrival_pickup,f_departure_pickup,(SELECT tag FROM old_transport WHERE old_transport.transport_id = person_travel.departure_transport_id),departure_from,departure_to,departure_number,departure_date,departure_time,travel_cost,(SELECT iso_4217_code FROM old_currency WHERE old_currency.currency_id = person_travel.travel_currency_id),accommodation_cost,(SELECT iso_4217_code FROM old_currency WHERE old_currency.currency_id = person_travel.accommodation_currency_id),accommodation_name,accommodation_street,accommodation_postcode,accommodation_city,accommodation_phone,accommodation_phone_room,f_arrived,fee,(SELECT iso_4217_code FROM old_currency WHERE old_currency.currency_id = person_travel.fee_currency_id),f_need_travel_cost,f_need_accommodation,f_need_accommodation_cost FROM person_travel;
DROP TABLE person_travel;
DROP TABLE old_transport;

ALTER TABLE person_im RENAME TO old_person_im;
CREATE TABLE base.person_im ( person_im_id SERIAL NOT NULL, person_id INTEGER NOT NULL, im_type TEXT NOT NULL, im_address TEXT NOT NULL, rank INTEGER);
CREATE TABLE person_im (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (im_type) REFERENCES im_type (im_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (person_im_id)
) INHERITS( base.person_im );
CREATE TABLE log.person_im () INHERITS( base.logging, base.person_im );
INSERT INTO person_im(person_id,im_type,im_address,rank) SELECT person_id,im_type,im_address,rank FROM old_person_im;
DROP TABLE old_person_im;
DROP TABLE old_im_type;

ALTER TABLE person_availability RENAME TO old_person_availability;
CREATE TABLE base.person_availability ( person_availability_id SERIAL, person_id INTEGER NOT NULL, conference_id INTEGER NOT NULL, start_date TIMESTAMP WITH TIME ZONE NOT NULL, duration INTERVAL NOT NULL);
CREATE TABLE person_availability (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_availability_id),
  UNIQUE (person_id, conference_id, start_date)
) INHERITS( base.person_availability );
CREATE TABLE log.person_availability () INHERITS( base.logging, base.person_availability );
INSERT INTO person_availability(person_id,conference_id,start_date,duration) SELECT person_id,conference_id,start_date,duration FROM old_person_availability;
DROP TABLE old_person_availability;

ALTER TABLE person_image RENAME TO old_person_image;
CREATE TABLE base.person_image ( person_id INTEGER NOT NULL, mime_type TEXT NOT NULL, public BOOL NOT NULL DEFAULT FALSE, image BYTEA NOT NULL);
CREATE TABLE person_image (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (mime_type) REFERENCES mime_type (mime_type) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (person_id)
) INHERITS( base.person_image );
CREATE TABLE log.person_image () INHERITS( base.logging, base.person_image );
INSERT INTO person_image(person_id,mime_type,public,image) SELECT person_id,mime_type,f_public,image FROM old_person_image;
DROP TABLE old_person_image CASCADE;

ALTER TABLE person_language RENAME TO old_person_language;
CREATE TABLE base.person_language ( person_id INTEGER NOT NULL, language TEXT NOT NULL, rank INTEGER);
CREATE TABLE person_language (
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (language) REFERENCES language (language) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (person_id, language)
) INHERITS( base.person_language );
CREATE TABLE log.person_language () INHERITS( base.logging, base.person_language );
INSERT INTO person_language(person_id,language,rank) SELECT person_id,(SELECT language FROM old_language WHERE old_language.language_id=old_person_language.language_id),rank FROM old_person_language;
DROP TABLE old_person_language;

ALTER TABLE event_state RENAME TO old_event_state;
CREATE TABLE base.event_state ( event_state TEXT, rank INTEGER);
CREATE TABLE event_state ( PRIMARY KEY (event_state)) INHERITS( base.event_state );
CREATE TABLE log.event_state () INHERITS( base.logging, base.event_state );
INSERT INTO event_state(event_state) SELECT event_state FROM old_event_state;





DROP TABLE auth.account_activation;

CREATE TABLE auth.account_activation(
  account_id INTEGER UNIQUE NOT NULL,
  conference_id INTEGER,
  activation_string CHAR(64) NOT NULL UNIQUE,
  account_creation TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  FOREIGN KEY (account_id) REFERENCES auth.account(account_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (account_id)
);

DROP TABLE auth.password_reset_string;

CREATE TABLE auth.account_password_reset (
  account_id INTEGER UNIQUE NOT NULL,
  activation_string CHAR(64) NOT NULL UNIQUE,
  reset_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  PRIMARY KEY (account_id),
  FOREIGN KEY (account_id) REFERENCES auth.account (account_id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP FUNCTION auth.hash_password(TEXT);

ALTER TABLE person_transaction RENAME TO old_person_transaction;

CREATE TABLE person_transaction (
  person_transaction_id SERIAL,
  person_id INTEGER NOT NULL,
  changed_when TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  changed_by INTEGER NOT NULL,
  f_create BOOL NOT NULL DEFAULT FALSE,
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (changed_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_transaction_id)
);

INSERT INTO person_transaction(person_transaction_id,person_id,changed_when,changed_by,f_create) SELECT person_transaction_id,person_id,changed_when,changed_by,f_create FROM old_person_transaction;

SELECT setval(pg_get_serial_sequence('person_transaction','person_transaction_id'),(SELECT max(person_transaction_id) FROM person_transaction));

DROP TABLE old_person_transaction CASCADE;

ALTER TABLE log.log_transaction DROP CONSTRAINT log_transaction_person_id_fkey;
ALTER TABLE log.log_transaction ADD CONSTRAINT log_transaction_person_id_fkey FOREIGN KEY(person_id) REFERENCES person(person_id) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE conference_transaction RENAME TO old_conference_transaction;

CREATE TABLE conference_transaction (
  conference_transaction_id SERIAL,
  conference_id INTEGER NOT NULL,
  changed_when TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  changed_by INTEGER NOT NULL,
  f_create BOOL NOT NULL DEFAULT FALSE,
  FOREIGN KEY (conference_id) REFERENCES conference (conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (changed_by) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_transaction_id)
);

INSERT INTO conference_transaction(conference_transaction_id,conference_id,changed_when,changed_by,f_create) SELECT conference_transaction_id,conference_id,changed_when,changed_by,f_create FROM old_conference_transaction;

SELECT setval(pg_get_serial_sequence('conference_transaction','conference_transaction_id'),(SELECT max(conference_transaction_id) FROM conference_transaction));

DROP TABLE old_conference_transaction CASCADE;

ALTER TABLE event ADD COLUMN conference_room TEXT;
UPDATE event SET conference_room = (SELECT short_name FROM old_room WHERE old_room.room_id = event.room_id);

DROP TABLE old_room CASCADE;

CREATE TABLE base.conference_team (
  conference_id INTEGER NOT NULL,
  conference_team TEXT NOT NULL,
  rank INTEGER
);

CREATE TABLE conference_team (
  FOREIGN KEY (conference_id) REFERENCES conference(conference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (conference_id,conference_team)
) INHERITS (base.conference_team);

CREATE TABLE log.conference_team (
) INHERITS( base.logging, base.conference_team );

INSERT INTO conference_team(conference_id,conference_team,rank) SELECT conference_id,tag,rank FROM team;

ALTER TABLE event ADD COLUMN conference_team TEXT;
UPDATE event SET conference_team = (SELECT tag FROM team where team.team_id = event.team_id);

DROP TABLE team_localized CASCADE;
DROP TABLE team CASCADE;

COMMIT;

