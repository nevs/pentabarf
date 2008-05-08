
PSQL=psql

LOG_TARGETS = install all import user
LOG_FILE = install.log

ifneq ($(LOGGING_ENABLED),y)
$(LOG_TARGETS):
	@$(MAKE) LOGGING_ENABLED=y $@ 2>&1 | tee "$(LOG_FILE)"
else

all: install import

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
		${PSQL} -c 'SELECT log.activate_logging();'

import:
		cd data && ${PSQL} -f import.sql

user:
		${PSQL} -f pentabarf-user.sql

endif
