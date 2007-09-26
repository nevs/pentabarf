
PSQL=psql

install:
		-createlang plpgsql
		${PSQL} -f schema.sql
		${PSQL} -f tables.sql
		${PSQL} -f views-localization.sql
		${PSQL} -f views.sql
		${PSQL} -f trigger.sql
		${PSQL} -f activate_trigger.sql
		${PSQL} -f types.sql
		${PSQL} -f functions.sql

all: install import

import:
		cd data && ${PSQL} -1 -f import.sql

user:
		${PSQL} -1 -f pentabarf-user.sql

