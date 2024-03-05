customLogger "info" "check_config" "Rebuild configuration"
su -c "/opt/otrs/bin/otrs.Console.pl Maint::Config::Rebuild --cleanup" -s /bin/sh otrs 2>&1 |\
  while true; do
    if IFS= read -r MESSAGE; then
      if [[ -n "${MESSAGE}" ]]; then
        echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"source\":\"znuny\", \"message\":\"${MESSAGE}\"}"
      fi
    fi
  done &


