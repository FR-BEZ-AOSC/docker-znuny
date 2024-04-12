CONFIG_PATH="/opt/otrs/Kernel/Config.pm"

set_env_database
set_env_mailing

customLogger "info" "config_znuny" "Check if the config file already exists"
if [[ -f "${CONFIG_PATH}" ]]; then
  customLogger "warn" "config_znuny" "The configuration file of Znuny already exists and will be replaced"
  rm ${CONFIG_PATH}
fi

customLogger "info" "config_znuny" "Create the configuration of Znuny"
touch ${CONFIG_PATH}

customLogger "info" "config_znuny" "Generate the licence"
gen_add_licence

customLogger "info" "config_znuny" "Generate packages"
gen_add_package

customLogger "info" "config_znuny" "Generate uses"
gen_add_use

customLogger "info" "config_znuny" "Generate sub"
gen_add_sub

customLogger "info" "config_znuny" "Generate database connection"
gen_add_database_credentials "${ZNUNY_DATABASE_HOST}" "${ZNUNY_DATABASE_NAME}" "${ZNUNY_DATABASE_USER}" "${ZNUNY_DATABASE_PASSWORD}"

customLogger "info" "config_znuny" "Generate the database driver"
gen_add_database_postgresql

customLogger "info" "config_znuny" "Generate the filesystem root directory"
gen_add_fs_root_dir

customLogger "info" "config_znuny" "Generate mailing configurations"
case ${ZNUNY_MAILING_TYPE} in
  "internal")
    gen_add_mailing_sendmail 
    ;;
  "external")
    gen_add_mailing_smtp ${ZNUNY_MAILING_HOST} ${ZNUNY_MAILING_PORT} ${ZNUNY_MAILING_USER} ${ZNUNY_MAILING_PASSWORD}
    ;;
esac

customLogger "info" "config_znuny" "Generate users authentications"
if [[ ! -z ${ZNUNY_AUTHENTICATIONS} ]]; then
  gen_add_authentication "${ZNUNY_AUTHENTICATIONS}"
fi

if [[ ! -z ${ZNUNY_LOG_PATH} ]]; then
  gen_add_log_file "${ZNUNY_LOG_PATH}"
  APP_USER="otrs"
  touch /var/log/znuny
  chown ${APP_USER} /var/log/znuny
else
  gen_add_log_rsyslog 
fi

customLogger "info" "config_znuny" "Generate the configuration return"
gen_add_return

customLogger "info" "config_znuny" "Generate the system stuffs"
gen_add_system_stuff

customLogger "info" "config_znuny" "End file"
gen_add_end
