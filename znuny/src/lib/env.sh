function set_env_database() {
  if [[ -z ${ZNUNY_DATABASE_HOST} ]]; then
    customLogger "error" "env" "Failed to load the environment variable ZNUNY_DATABASE_HOST"
    exit 1
  fi

  if [[ -z ${ZNUNY_DATABASE_NAME} ]]; then
    customLogger "error" "env" "Failed to load the environment variable ZNUNY_DATABASE_NAME"
    exit 1
  fi

  if [[ -z ${ZNUNY_DATABASE_USER} ]]; then
    customLogger "error" "env" "Failed to load the environment variable ZNUNY_DATABASE_USER"
    exit 1
  fi

  if [[ -z ${ZNUNY_DATABASE_PASSWORD} ]]; then
    customLogger "error" "env" "Failed to load the environment variable ZNUNY_DATABASE_PASSWORD"
    exit 1
  fi
}

function set_env_znuny() {
  if [[ -z ${ZNUNY_USER_ADMIN_NAME} ]]; then
    customLogger "error" "env" "Failed to load the environment variable ZNUNY_USER_ADMIN_NAME"
    exit 1
  fi

  if [[ -z ${ZNUNY_USER_ADMIN_PASSWORD} ]]; then
    customLogger "error" "env" "Failed to load the environment variable ZNUNY_USER_ADMIN_PASSWORD"
    exit 1
  fi
}

function set_env_mailing() {
  if [[ -z ${ZNUNY_MAILING_TYPE} ]]; then
    customLogger "warn" "env" "Failed to load the environment variable ZNUNY_MAILING_TYPE. It will be define to 'internal'"
    ZNUNY_MAILING_TYPE="internal"
  fi

  if [[ ${ZNUNY_MAILING_TYPE} == "external" ]]; then
    if [[ -z ${ZNUNY_MAILING_HOST} ]]; then
      customLogger "error" "env" "The mailing type is set to 'external' but the environment variable ZNUNY_MAILING_HOST is missing"
      exit 1
    fi

    if [[ -z ${ZNUNY_MAILING_PORT} ]]; then
      customLogger "error" "env" "The mailing type is set to 'external' but the environment variable ZNUNY_MAILING_PORT is missing"
      exit 1
    fi

    if [[ -z ${ZNUNY_MAILING_USER} ]]; then
      customLogger "error" "env" "The mailing type is set to 'external' but the environment variable ZNUNY_MAILING_USER is missing"
      exit 1
    fi

    if [[ -z ${ZNUNY_MAILING_PASSWORD} ]]; then
      customLogger "error" "env" "The mailing type is set to 'external' but the environment variable ZNUNY_MAILING_PASSWORD is missing"
      exit 1
    fi
  fi
}



