
PGADMIN=postgres
DATABASE=phoenix
DBUSER=sven
DBADMIN=sven
SUDOCMD=sudo

install_db:
		-${SUDOCMD} -u ${PGADMIN} createuser ${DBADMIN} -S -D -R
		-${SUDOCMD} -u ${PGADMIN} createuser ${DBUSER} -S -D -R
		-${SUDOCMD} -u ${PGADMIN} createdb -O ${DBADMIN} ${DATABASE}
		-${SUDOCMD} -u ${PGADMIN} createlang plpgsql ${DATABASE}
		psql ${DATABASE} ${DBADMIN} -f schema.sql
		psql ${DATABASE} ${DBADMIN} -f tables.sql
		psql ${DATABASE} ${DBADMIN} -f conflict.sql

