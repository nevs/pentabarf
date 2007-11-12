
PSQL=psql

install:
		-createlang plpgsql
		${PSQL} -f schema.sql
		${PSQL} -f tables.sql
		${PSQL} -f index.sql
		${PSQL} -f views.sql
		${PSQL} -f trigger.sql
		${PSQL} -f activate_trigger.sql
		${PSQL} -f types.sql
		${PSQL} -f functions.sql

all: install import

import:
		cd data && ${PSQL} -f import.sql

user:
		${PSQL} -f pentabarf-user.sql

