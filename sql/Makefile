
PGADMIN=postgres
DATABASE=phoenix
DBUSER=${USER}
DBADMIN=${USER}
SUDOCMD=sudo

all: install_db initial_data demo

install_db:
		-${SUDOCMD} -u ${PGADMIN} createuser ${DBADMIN} -S -D -R
		-${SUDOCMD} -u ${PGADMIN} createuser ${DBUSER} -S -D -R
		-${SUDOCMD} -u ${PGADMIN} createdb -O ${DBADMIN} ${DATABASE}
		-${SUDOCMD} -u ${PGADMIN} createlang plpgsql ${DATABASE}
		psql ${DATABASE} ${DBADMIN} -f install_db.sql

initial_data:
		(cd data;\
		 psql ${DATABASE} ${DBUSER} -f import.sql)

demo:
		psql ${DATABASE} ${DBADMIN} -f demo.sql

