DUMP_FILE="/tmp/znuny-db-dump.sql"

zcli user system

zcli config znuny

zcli config apache

zcli config crons

zcli user permissions

zcli check modules

zcli check config

export PGPASSWORD=${args[-w]}


echo "true" > ${DUMP_FILE}

function function_backup() {
  pg_dump -U ${args[-u]} -h ${args[-h]} -p ${args[-p]} -d ${args[-n]} -f ${DUMP_FILE}

  sleep 1

  echo "false" > ${DUMP_FILE}
}

function_backup 2>&1 |\
while $(cat ${DUMP_FILE}); do
  if IFS= read -r MESSAGE; then
    if [[ -n "${MESSAGE}" ]]; then
      echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"upgrade\", \"message\":\"${MESSAGE}\"}"
    fi
  fi
done



echo "true" > ${DUMP_FILE}

function function_delete_database() {
  database_deletion_pgsql "${ZNUNY_DATABASE_HOST}" "${ZNUNY_DATABASE_PORT}" "${ZNUNY_DATABASE_NAME}" "${ZNUNY_DATABASE_USER}" "${ZNUNY_DATABASE_PASSWORD}"

  sleep 1

  echo "false" > ${DUMP_FILE}
}

function_delete_database 2>&1 |\
while $(cat ${DUMP_FILE}); do
  if IFS= read -r MESSAGE; then
    if [[ -n "${MESSAGE}" ]]; then
      echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"upgrade\", \"message\":\"${MESSAGE}\"}"
    fi
  fi
done



echo "true" > ${DUMP_FILE}

function function_role_database() {
  database_role_pgsql "${ZNUNY_DATABASE_HOST}" "${ZNUNY_DATABASE_PORT}" "${ZNUNY_DATABASE_NAME}" "${ZNUNY_DATABASE_USER}" "${ZNUNY_DATABASE_PASSWORD}"

  sleep 1

  echo "false" > ${DUMP_FILE}
}

function_role_database 2>&1 |\
while $(cat ${DUMP_FILE}); do
  if IFS= read -r MESSAGE; then
    if [[ -n "${MESSAGE}" ]]; then
      echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"upgrade\", \"message\":\"${MESSAGE}\"}"
    fi
  fi
done


export PGPASSWORD=${ZNUNY_DATABASE_PASSWORD}

echo "true" > ${DUMP_FILE}

function function_run_sql_command() {
  psql -U ${ZNUNY_DATABASE_USER} -h ${ZNUNY_DATABASE_HOST} -p ${ZNUNY_DATABASE_PORT} -d ${ZNUNY_DATABASE_NAME} < ${DUMP_FILE}

  sleep 1

  echo "false" > ${DUMP_FILE}
}

function_run_sql_command 2>&1 |\
while $(cat ${DUMP_FILE}); do
  if IFS= read -r MESSAGE; then
    if [[ -n "${MESSAGE}" ]]; then
      echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"upgrade\", \"message\":\"${MESSAGE}\"}"
    fi
  fi
done

rm -f ${DUMP_FILE}
