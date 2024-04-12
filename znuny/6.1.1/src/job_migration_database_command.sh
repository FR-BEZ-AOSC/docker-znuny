DUMP_FILE="/tmp/znuny-db-dump.sql"

function create_remote_database_dump() {
  export PGPASSWORD=${args[-w]}
  pg_dump -U ${args[-u]} -h ${args[-h]} -p ${args[-p]} -d ${args[-n]} -f ${DUMP_FILE}

  sleep 1
  echo "false" > ${DUMP_FILE}
}

function delete_local_database() {
  database_deletion_pgsql "${ZNUNY_DATABASE_HOST}" "${ZNUNY_DATABASE_PORT}" "${ZNUNY_DATABASE_NAME}" "${ZNUNY_DATABASE_USER}" "${ZNUNY_DATABASE_PASSWORD}"

  sleep 1
  echo "false" > ${DUMP_FILE}
}

function create_user_roles() {
  database_role_pgsql "${ZNUNY_DATABASE_HOST}" "${ZNUNY_DATABASE_PORT}" "${ZNUNY_DATABASE_NAME}" "${ZNUNY_DATABASE_USER}" "${ZNUNY_DATABASE_PASSWORD}"

  sleep 1
  echo "false" > ${DUMP_FILE}
}

function import_dump_into_current_database() {
  export PGPASSWORD=${ZNUNY_DATABASE_PASSWORD}
  psql -U ${ZNUNY_DATABASE_USER} -h ${ZNUNY_DATABASE_HOST} -p ${ZNUNY_DATABASE_PORT} -d ${ZNUNY_DATABASE_NAME} < ${DUMP_FILE}

  sleep 1
  echo "false" > ${DUMP_FILE}
}

echo "true" > ${DUMP_FILE}

create_remote_database_dump 2>&1 |\
while $(cat ${DUMP_FILE}); do
  if IFS= read -r MESSAGE; then
    if [[ -n "${MESSAGE}" ]]; then
      echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"migration_dump\", \"message\":\"${MESSAGE}\"}"
    fi
  fi
done

echo "true" > ${DUMP_FILE}

delete_local_database 2>&1 |\
while $(cat ${DUMP_FILE}); do
  if IFS= read -r MESSAGE; then
    if [[ -n "${MESSAGE}" ]]; then
      echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"migration_purge\", \"message\":\"${MESSAGE}\"}"
    fi
  fi
done

echo "true" > ${DUMP_FILE}

create_user_roles 2>&1 |\
while $(cat ${DUMP_FILE}); do
  if IFS= read -r MESSAGE; then
    if [[ -n "${MESSAGE}" ]]; then
      echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"migration_settings\", \"message\":\"${MESSAGE}\"}"
    fi
  fi
done

echo "true" > ${DUMP_FILE}

import_dump_into_current_database 2>&1 |\
while $(cat ${DUMP_FILE}); do
  if IFS= read -r MESSAGE; then
    if [[ -n "${MESSAGE}" ]]; then
      echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"migration_import\", \"message\":\"${MESSAGE}\"}"
    fi
  fi
done

rm -f ${DUMP_FILE}
