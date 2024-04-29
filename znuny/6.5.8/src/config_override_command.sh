TMP_LOCK_FILE="/tmp/config_override.lock"
ZNUNY_CUSTOM_DIRECTORY="/opt/otrs/Custom"

echo "true" > ${TMP_LOCK_FILE}

# function set_configurations_overrides() {
#   IFS=','

#   for OVERRIDE in ${ZNUNY_CONFIGURATIONS_OVERRIDES}; do
#     ORIGIN=$(echo "${OVERRIDE}" | cut -d':' -f1)
#     DESTINATION=$(echo "${OVERRIDE}" | cut -d':' -f2)

#     if [[ -f ${ORIGIN} ]]; then
#       customLogger "info" "config_override" "Create '${DESTINATION}' from '${ORIGIN}'"
#       mkdir -p $(dirname ${DESTINATION})
#       cp -f ${DESTINATION} ${ORIGIN}
#     else
#       customLogger "info" "config_override" "Failed to create '${DESTINATION}' from '${ORIGIN}'. '${DESTINATION}' not found"
#     fi
#   done
  
#   unset IFS

#   sleep 1
#   echo "false" > ${TMP_LOCK_FILE}
# }

function set_configurations_overrides() {
  for OVERRIDE_DIR in $(find ${ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY:-$DEFAULT_ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY} -type d -name '*'); do
    # echo "${ZNUNY_CUSTOM_DIRECTORY}/`echo \"${OVERRIDE_DIR}\" | sed \"s*${ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY:-$DEFAULT_ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY}**g\"`"
    mkdir -p "${ZNUNY_CUSTOM_DIRECTORY}/`echo \"${OVERRIDE_DIR}\" | sed \"s*${ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY:-$DEFAULT_ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY}**g\"`"
  done

  for OVERRIDE_FILE in $(find ${ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY:-$DEFAULT_ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY} -type f -name '*'); do
    # echo "${ZNUNY_CUSTOM_DIRECTORY}/`echo \"${OVERRIDE_FILE}\" | sed \"s*${ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY:-$DEFAULT_ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY}**g\"`"
    cp -f "${OVERRIDE_FILE}" "${ZNUNY_CUSTOM_DIRECTORY}/`echo \"${OVERRIDE_FILE}\" | sed \"s*${ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY:-$DEFAULT_ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY}**g\"`"
  done

  sleep 1
  echo "false" > ${TMP_LOCK_FILE}
}

# if [[ ! -z ${ZNUNY_CONFIGURATIONS_OVERRIDES} ]]; then
customLogger "info" "config_override" "Configure custom configurations overrides"
set_configurations_overrides 2>&1 |\
  while $(cat ${TMP_LOCK_FILE}); do
    if IFS= read -r MESSAGE; then
      if [[ -n "${MESSAGE}" ]]; then
        echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"config_override\", \"message\":\"${MESSAGE}\"}"
      fi
    fi
  done
# fi

rm -f ${TMP_LOCK_FILE}
