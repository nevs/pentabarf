
PGADMIN=postgres
DATABASE=phoenix
DBUSER=sven
DBADMIN=sven

install_db:
		-sudo -u ${PGADMIN} createuser ${DBADMIN} -S -D -R
		-sudo -u ${PGADMIN} createdb -O ${DBADMIN} ${DATABASE}
		-sudo -u ${PGADMIN} createlang plpgsql ${DATABASE}
		psql ${DATABASE} ${DBADMIN} -f schema.sql
		psql ${DATABASE} ${DBADMIN} -f tables.sql
		psql ${DATABASE} ${DBADMIN} -f conflict.sql

