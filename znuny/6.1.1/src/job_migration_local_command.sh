DUMP_FILE="${args[path]}"

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
  if [[ ${args[-f]} == "true" ]]; then
    psql -v ON_ERROR_STOP=off -U ${ZNUNY_DATABASE_USER} -h ${ZNUNY_DATABASE_HOST} -p ${ZNUNY_DATABASE_PORT} -d ${ZNUNY_DATABASE_NAME} < ${DUMP_FILE}
  else
    psql -U ${ZNUNY_DATABASE_USER} -h ${ZNUNY_DATABASE_HOST} -p ${ZNUNY_DATABASE_PORT} -d ${ZNUNY_DATABASE_NAME} < ${DUMP_FILE}
  fi

  sleep 1
  echo "false" > ${DUMP_FILE}
}

echo "true" > ${DUMP_FILE}

customLogger "info" "migration_dump" "Purge the current database"
delete_local_database 2>&1 |\
while $(cat ${DUMP_FILE}); do
  if IFS= read -r MESSAGE; then
    if [[ -n "${MESSAGE}" ]]; then
      echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"migration_purge\", \"message\":\"${MESSAGE}\"}"
    fi
  fi
done

echo "true" > ${DUMP_FILE}

customLogger "info" "migration_dump" "Ensure roles exists"
create_user_roles 2>&1 |\
while $(cat ${DUMP_FILE}); do
  if IFS= read -r MESSAGE; then
    if [[ -n "${MESSAGE}" ]]; then
      echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"migration_settings\", \"message\":\"${MESSAGE}\"}"
    fi
  fi
done

echo "true" > ${DUMP_FILE}

customLogger "info" "migration_dump" "Import the database dump"
import_dump_into_current_database 2>&1 |\
while $(cat ${DUMP_FILE}); do
  if IFS= read -r MESSAGE; then
    if [[ -n "${MESSAGE}" ]]; then
      echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"migration_import\", \"message\":\"${MESSAGE}\"}"
    fi
  fi
done

