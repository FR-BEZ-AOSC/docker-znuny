TMP_LOCK_FILE="/tmp/check_config.lock"

function check_modules_perl() {
  su -c "/opt/otrs/bin/otrs.CheckModules.pl --all 2>&1>/dev/null" -s /bin/bash otrs

  sleep 1
  echo "false" > ${TMP_LOCK_FILE}
}

function check_mmodules_packages() {
  su -c "/opt/otrs/bin/otrs.Console.pl Admin::Package::ReinstallAll" -s /bin/bash otrs || true

  sleep 1
  echo "false" > ${TMP_LOCK_FILE}
}

echo "true" > ${TMP_LOCK_FILE}

customLogger "info" "check_modules" "Check Perl modules"
check_modules_perl 2>&1 |\
  while $(cat ${TMP_LOCK_FILE}); do
    if IFS= read -r MESSAGE; then
      if [[ -n "${MESSAGE}" ]]; then
        echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"check_modules\", \"message\":\"${MESSAGE}\"}"
      fi
    fi
  done

echo "true" > ${TMP_LOCK_FILE}

customLogger "info" "check_modules" "Check packages installations"
check_mmodules_packages 2>&1 |\
  while $(cat ${TMP_LOCK_FILE}); do
    if IFS= read -r MESSAGE; then
      if [[ -n "${MESSAGE}" ]]; then
        echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"check_modules\", \"message\":\"${MESSAGE}\"}"
      fi
    fi
  done

rm -f ${TMP_LOCK_FILE}



