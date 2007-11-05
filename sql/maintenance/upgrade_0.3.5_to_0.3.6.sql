
BEGIN;

DROP TABLE time_zone_localized CASCADE;
DROP TABLE time_zone CASCADE;

CREATE TABLE timezone (
  timezone TEXT NOT NULL,
  abbreviation TEXT NOT NULL,
  utf_offset INTERVAL NOT NULL,
  PRIMARY KEY( name )
);

INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Abidjan', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Accra', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Addis_Ababa', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Algiers', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Asmara', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Asmera', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Bamako', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Bangui', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Banjul', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Bissau', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Blantyre', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Brazzaville', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Bujumbura', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Cairo', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Casablanca', 'WET', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Ceuta', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Conakry', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Dakar', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Dar_es_Salaam', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Djibouti', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Douala', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/El_Aaiun', 'WET', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Freetown', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Gaborone', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Harare', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Johannesburg', 'SAST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Kampala', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Khartoum', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Kigali', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Kinshasa', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Lagos', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Libreville', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Lome', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Luanda', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Lubumbashi', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Lusaka', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Malabo', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Maputo', 'CAT', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Maseru', 'SAST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Mbabane', 'SAST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Mogadishu', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Monrovia', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Nairobi', 'EAT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Ndjamena', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Niamey', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Nouakchott', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Ouagadougou', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Porto-Novo', 'WAT', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Sao_Tome', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Timbuktu', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Tripoli', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Tunis', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Africa/Windhoek', 'WAST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Adak', 'HADT', '-09:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Anchorage', 'AKDT', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Anguilla', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Antigua', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Araguaina', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Argentina/Buenos_Aires', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Argentina/Catamarca', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Argentina/ComodRivadavia', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Argentina/Cordoba', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Argentina/Jujuy', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Argentina/La_Rioja', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Argentina/Mendoza', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Argentina/Rio_Gallegos', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Argentina/San_Juan', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Argentina/Tucuman', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Argentina/Ushuaia', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Aruba', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Asuncion', 'PYST', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Atikokan', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Atka', 'HADT', '-09:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Bahia', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Barbados', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Belem', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Belize', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Blanc-Sablon', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Boa_Vista', 'AMT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Bogota', 'COT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Boise', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Buenos_Aires', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Cambridge_Bay', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Campo_Grande', 'AMT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Cancun', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Caracas', 'VET', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Catamarca', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Cayenne', 'GFT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Cayman', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Chicago', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Chihuahua', 'MST', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Coral_Harbour', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Cordoba', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Costa_Rica', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Cuiaba', 'AMT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Curacao', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Danmarkshavn', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Dawson', 'PDT', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Dawson_Creek', 'MST', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Denver', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Detroit', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Dominica', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Edmonton', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Eirunepe', 'ACT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/El_Salvador', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Ensenada', 'PST', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Fortaleza', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Fort_Wayne', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Glace_Bay', 'ADT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Godthab', 'WGT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Goose_Bay', 'ADT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Grand_Turk', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Grenada', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Guadeloupe', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Guatemala', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Guayaquil', 'ECT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Guyana', 'GYT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Halifax', 'ADT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Havana', 'CDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Hermosillo', 'MST', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Indiana/Indianapolis', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Indiana/Knox', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Indiana/Marengo', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Indiana/Petersburg', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Indianapolis', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Indiana/Tell_City', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Indiana/Vevay', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Indiana/Vincennes', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Indiana/Winamac', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Inuvik', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Iqaluit', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Jamaica', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Jujuy', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Juneau', 'AKDT', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Kentucky/Louisville', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Kentucky/Monticello', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Knox_IN', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/La_Paz', 'BOT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Lima', 'PET', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Los_Angeles', 'PDT', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Louisville', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Maceio', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Managua', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Manaus', 'AMT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Martinique', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Mazatlan', 'MST', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Mendoza', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Menominee', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Merida', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Mexico_City', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Miquelon', 'PMDT', '-02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Moncton', 'ADT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Monterrey', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Montevideo', 'UYST', '-02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Montreal', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Montserrat', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Nassau', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/New_York', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Nipigon', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Nome', 'AKDT', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Noronha', 'FNT', '-02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/North_Dakota/Center', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/North_Dakota/New_Salem', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Panama', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Pangnirtung', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Paramaribo', 'SRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Phoenix', 'MST', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Port-au-Prince', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Porto_Acre', 'ACT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Port_of_Spain', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Porto_Velho', 'AMT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Puerto_Rico', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Rainy_River', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Rankin_Inlet', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Recife', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Regina', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Resolute', 'EST', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Rio_Branco', 'ACT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Rosario', 'ART', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Santiago', 'CLST', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Santo_Domingo', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Sao_Paulo', 'BRT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Scoresbysund', 'EGT', '-01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Shiprock', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/St_Johns', 'NDT', '-02:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/St_Kitts', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/St_Lucia', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/St_Thomas', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/St_Vincent', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Swift_Current', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Tegucigalpa', 'CST', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Thule', 'ADT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Thunder_Bay', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Tijuana', 'PST', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Toronto', 'EDT', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Tortola', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Vancouver', 'PDT', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Virgin', 'AST', '-04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Whitehorse', 'PDT', '-07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Winnipeg', 'CDT', '-05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Yakutat', 'AKDT', '-08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('America/Yellowknife', 'MDT', '-06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Antarctica/Casey', 'WST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Antarctica/Davis', 'DAVT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Antarctica/DumontDUrville', 'DDUT', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Antarctica/Mawson', 'MAWT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Antarctica/McMurdo', 'NZDT', '13:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Antarctica/Palmer', 'CLST', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Antarctica/Rothera', 'ROTT', '-03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Antarctica/South_Pole', 'NZDT', '13:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Antarctica/Syowa', 'SYOT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Antarctica/Vostok', 'VOST', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Aden', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Almaty', 'ALMT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Amman', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Anadyr', 'ANAT', '12:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Aqtau', 'AQTT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Aqtobe', 'AQTT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Ashgabat', 'TMT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Ashkhabad', 'TMT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Baghdad', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Bahrain', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Baku', 'AZT', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Bangkok', 'ICT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Beirut', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Bishkek', 'KGT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Brunei', 'BNT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Calcutta', 'IST', '05:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Choibalsan', 'CHOT', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Chongqing', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Chungking', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Colombo', 'IST', '05:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Dacca', 'BDT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Damascus', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Dhaka', 'BDT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Dili', 'TLT', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Dubai', 'GST', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Dushanbe', 'TJT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Gaza', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Harbin', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Hong_Kong', 'HKT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Hovd', 'HOVT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Irkutsk', 'IRKT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Istanbul', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Jakarta', 'WIT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Jayapura', 'EIT', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Jerusalem', 'IST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Kabul', 'AFT', '04:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Kamchatka', 'PETT', '12:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Karachi', 'PKT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Kashgar', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Katmandu', 'NPT', '05:45:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Krasnoyarsk', 'KRAT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Kuala_Lumpur', 'MYT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Kuching', 'MYT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Kuwait', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Macao', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Macau', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Magadan', 'MAGT', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Makassar', 'CIT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Manila', 'PHT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Muscat', 'GST', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Nicosia', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Novosibirsk', 'NOVT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Omsk', 'OMST', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Oral', 'ORAT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Phnom_Penh', 'ICT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Pontianak', 'WIT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Pyongyang', 'KST', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Qatar', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Qyzylorda', 'QYZT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Rangoon', 'MMT', '06:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Riyadh', 'AST', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Riyadh87', 'zzz', '03:07:04');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Riyadh88', 'zzz', '03:07:04');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Riyadh89', 'zzz', '03:07:04');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Saigon', 'ICT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Sakhalin', 'SAKT', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Samarkand', 'UZT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Seoul', 'KST', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Shanghai', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Singapore', 'SGT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Taipei', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Tashkent', 'UZT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Tbilisi', 'GET', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Tehran', 'IRST', '03:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Tel_Aviv', 'IST', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Thimbu', 'BTT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Thimphu', 'BTT', '06:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Tokyo', 'JST', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Ujung_Pandang', 'CIT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Ulaanbaatar', 'ULAT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Ulan_Bator', 'ULAT', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Urumqi', 'CST', '08:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Vientiane', 'ICT', '07:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Vladivostok', 'VLAT', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Yakutsk', 'YAKT', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Yekaterinburg', 'YEKT', '05:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Asia/Yerevan', 'AMT', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/ACT', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Adelaide', 'CST', '10:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Brisbane', 'EST', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Broken_Hill', 'CST', '10:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Canberra', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Currie', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Darwin', 'CST', '09:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Eucla', 'CWST', '09:45:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Hobart', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/LHI', 'LHST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Lindeman', 'EST', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Lord_Howe', 'LHST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Melbourne', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/North', 'CST', '09:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/NSW', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Perth', 'WST', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Queensland', 'EST', '10:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/South', 'CST', '10:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Sydney', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Tasmania', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Victoria', 'EST', '11:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/West', 'WST', '09:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Australia/Yancowinna', 'CST', '10:30:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Amsterdam', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Andorra', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Athens', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Belfast', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Belgrade', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Berlin', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Bratislava', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Brussels', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Bucharest', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Budapest', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Chisinau', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Copenhagen', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Dublin', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Gibraltar', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Guernsey', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Helsinki', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Isle_of_Man', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Istanbul', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Jersey', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Kaliningrad', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Kiev', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Lisbon', 'WET', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Ljubljana', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/London', 'GMT', '00:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Luxembourg', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Madrid', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Malta', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Mariehamn', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Minsk', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Monaco', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Moscow', 'MSK', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Nicosia', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Oslo', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Paris', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Podgorica', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Prague', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Riga', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Rome', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Samara', 'SAMT', '04:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/San_Marino', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Sarajevo', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Simferopol', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Skopje', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Sofia', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Stockholm', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Tallinn', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Tirane', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Tiraspol', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Uzhgorod', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Vaduz', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Vatican', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Vienna', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Vilnius', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Volgograd', 'VOLT', '03:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Warsaw', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Zagreb', 'CET', '01:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Zaporozhye', 'EET', '02:00:00');
INSERT INTO timezone (timezone, abbreviation, utf_offset) VALUES ('Europe/Zurich', 'CET', '01:00:00');

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
  country_id INTEGER,
  timezone TEXT NOT NULL DEFAULT 'Europe/Berlin',
  currency_id INTEGER,
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

CREATE TABLE public.conference (
  FOREIGN KEY (conference_phase) REFERENCES conference_phase (conference_phase) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (country_id) REFERENCES country (country_id) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (timezone) REFERENCES timezone (timezone) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (currency_id) REFERENCES currency (currency_id) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY (conference_id)
) INHERITS( base.conference );

CREATE TABLE log.conference() INHERITS( base.logging, base.conference );

INSERT INTO public.conference( conference_id, acronym, title, subtitle, conference_phase, start_date, days, venue, city, country_id, currency_id, timeslot_duration, default_timeslots, max_timeslot_duration, day_change, remark, release, homepage, abstract_length, description_length, export_base_url, export_css_file, feedback_base_url, css, email, f_feedback_enabled, f_submission_enabled, f_visitor_enabled, f_reconfirmation_enabled ) SELECT conference_id, acronym, title, subtitle, conference_phase, start_date, days, venue, city, country_id, currency_id, timeslot_duration, default_timeslots, max_timeslot_duration, day_change, remark, release, homepage, abstract_length, description_length, export_base_url, export_css_file, feedback_base_url, css, email, f_feedback_enabled, f_submission_enabled, f_visitor_enabled, f_reconfirmation_enabled FROM public.old_conference;

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
  address TEXT,
  street TEXT,
  street_postcode TEXT,
  po_box TEXT,
  po_box_postcode TEXT,
  city TEXT,
  country_id INTEGER,
  iban TEXT,
  bic TEXT,
  bank_name TEXT,
  account_owner TEXT
);

CREATE TABLE public.person(
  CHECK (first_name IS NOT NULL OR last_name IS NOT NULL OR public_name IS NOT NULL OR nickname IS NOT NULL),
  FOREIGN KEY (country_id) REFERENCES country (country_id) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY (person_id)
) INHERITS( base.person );

CREATE TABLE log.person() INHERITS( base.logging, base.person );

INSERT INTO public.person( person_id, title, gender, first_name, last_name, public_name, nickname, email, address, street, street_postcode, po_box, po_box_postcode, city, country_id, iban, bic, bank_name, account_owner ) SELECT person_id, title, gender, first_name, last_name, public_name, coalesce(nickname,login_name), email_contact, address, street, street_postcode, po_box, po_box_postcode, city, country_id, iban, bic, bank_name, account_owner FROM old_person;

CREATE TABLE auth.account (
  account_id SERIAL,
  login_name TEXT NOT NULL,
  email TEXT NOT NULL,
  salt TEXT,
  password TEXT,
  edit_token TEXT,
  current_language_id INTEGER,
  current_conference_id INTEGER,
  preferences TEXT,
  last_login TIMESTAMP,
  person_id INTEGER REFERENCES public.person(person_id),
  CHECK (login_name <> 'logout'),
  CHECK ( strpos( login_name, ':' ) = 0 ),
  PRIMARY KEY( account_id )
);

INSERT INTO auth.account( login_name, email, salt, password, current_language_id, current_conference_id, preferences, last_login, person_id ) SELECT login_name, email_contact, substring(password, 1, 16), substring(password,17,32), current_language_id, current_conference_id, preferences, last_login, person_id FROM old_person WHERE login_name IS NOT NULL AND email_contact IS NOT NULL;

INSERT INTO auth.object_domain VALUES ('account','account');

CREATE TABLE base.account_role (
  account_id INTEGER NOT NULL,
  role TEXT NOT NULL
);

CREATE TABLE auth.account_role (
  PRIMARY KEY( account_id, role ),
  FOREIGN KEY( account_id) REFERENCES auth.account( account_id ) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY( role ) REFERENCES auth.role( role ) ON UPDATE CASCADE ON DELETE CASCADE
) INHERITS( base.account_role );

CREATE TABLE log.account_role() INHERITS( base.logging, base.account_role );

INSERT INTO auth.account_role(account_id,role) SELECT account_id, role FROM auth.person_role INNER JOIN auth.account USING(person_id);

DROP TABLE base.person_role CASCADE;


COMMIT;

