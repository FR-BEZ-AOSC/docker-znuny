DUMP_FILE="/tmp/znuny-db-dump.sql"

zcli user system

zcli config znuny

zcli config apache

zcli config crons

zcli user permissions

zcli check modules

zcli check config

export PGPASSWORD=${args[-w]}
pg_dump -U ${args[-u]} -h ${args[-h]} -p ${args[-p]} -d ${args[-n]} -f ${DUMP_FILE}

sleep 1

database_deletion_pgsql "${ZNUNY_DATABASE_HOST}" "${ZNUNY_DATABASE_PORT}" "${ZNUNY_DATABASE_NAME}" "${ZNUNY_DATABASE_USER}" "${ZNUNY_DATABASE_PASSWORD}"

sleep 1

database_role_pgsql "${ZNUNY_DATABASE_HOST}" "${ZNUNY_DATABASE_PORT}" "${ZNUNY_DATABASE_NAME}" "${ZNUNY_DATABASE_USER}" "${ZNUNY_DATABASE_PASSWORD}"

sleep 1

export PGPASSWORD=${ZNUNY_DATABASE_PASSWORD}

# echo "PGPASSWORD=${ZNUNY_DATABASE_PASSWORD} pg_restore -U ${ZNUNY_DATABASE_USER} -h ${ZNUNY_DATABASE_HOST} -p ${ZNUNY_DATABASE_PORT} -d ${ZNUNY_DATABASE_NAME} ${DUMP_FILE}"
psql -U ${ZNUNY_DATABASE_USER} -h ${ZNUNY_DATABASE_HOST} -p ${ZNUNY_DATABASE_PORT} -d ${ZNUNY_DATABASE_NAME} < ${DUMP_FILE}

rm -f ${DUMP_FILE}
