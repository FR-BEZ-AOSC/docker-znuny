customLogger "info" "check_modules" "Check Perl modules"
su -c "/opt/otrs/bin/otrs.CheckModules.pl --all 2>&1>/dev/null" -s /bin/bash otrs 2>&1 |\
  while true; do
    if IFS= read -r MESSAGE; then
      if [[ -n "${MESSAGE}" ]]; then
        echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"znuny\", \"message\":\"${MESSAGE}\"}"
      fi
    fi
  done &

# customLogger "info" "check_modules" "Ensure all packages are installed"
customLogger "info" "check_modules" "Check packages installations"
su -c "/opt/otrs/bin/otrs.Console.pl Admin::Package::ReinstallAll" -s /bin/bash otrs 2>&1 |\
  while true; do
    if IFS= read -r MESSAGE; then
      if [[ -n "${MESSAGE}" ]]; then
        echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"znuny\", \"message\":\"${MESSAGE}\"}"
      fi
    fi
  done &


