DUMP_FILE="${args[path]}"

su -c "/opt/otrs/bin/otrs.Daemon.pl stop" -s /bin/sh otrs || true
su -c "/opt/otrs/bin/Cron.sh stop" -s /bin/sh otrs || true

if [[ "${ZNUNY_DATABASE_TYPE}" == "mysql" ]]; then
    echo "mysqldump -u ${args[-u]} -h ${args[-h]} -P ${args[-p]} -p ${args[-w]} ${args[-n]} > ${DUMP_FILE}"
    sleep 3
    echo "mysql -u ${ZNUNY_DATABASE_USER} -h ${ZNUNY_DATABASE_HOST} -P ${ZNUNY_DATABASE_PORT} -p ${ZNUNY_DATABASE_PASSWORD} ${ZNUNY_DATABASE_NAME} < ${DUMP_FILE}"
elif [[ "${ZNUNY_DATABASE_TYPE}" == "pgsql" ]]; then
    database_deletion_pgsql "${ZNUNY_DATABASE_HOST}" "${ZNUNY_DATABASE_PORT}" "${ZNUNY_DATABASE_NAME}" "${ZNUNY_DATABASE_USER}" "${ZNUNY_DATABASE_PASSWORD}"
    
    sleep 1

    database_role_pgsql "${ZNUNY_DATABASE_HOST}" "${ZNUNY_DATABASE_PORT}" "${ZNUNY_DATABASE_NAME}" "${ZNUNY_DATABASE_USER}" "${ZNUNY_DATABASE_PASSWORD}"

    sleep 1

    export PGPASSWORD=${ZNUNY_DATABASE_PASSWORD}

    # echo "PGPASSWORD=${ZNUNY_DATABASE_PASSWORD} pg_restore -U ${ZNUNY_DATABASE_USER} -h ${ZNUNY_DATABASE_HOST} -p ${ZNUNY_DATABASE_PORT} -d ${ZNUNY_DATABASE_NAME} ${DUMP_FILE}"
    if [[ ${args[-f]} == "true" ]]; then
        psql -v ON_ERROR_STOP=off -U ${ZNUNY_DATABASE_USER} -h ${ZNUNY_DATABASE_HOST} -p ${ZNUNY_DATABASE_PORT} -d ${ZNUNY_DATABASE_NAME} < ${DUMP_FILE}
    else
        psql -U ${ZNUNY_DATABASE_USER} -h ${ZNUNY_DATABASE_HOST} -p ${ZNUNY_DATABASE_PORT} -d ${ZNUNY_DATABASE_NAME} < ${DUMP_FILE}
    fi
fi

rm -f ${DUMP_FILE}
