APP_USER="otrs"

customLogger "info" "user_permissions" "Set the permission for the user onto the applications directories"
/opt/otrs/bin/otrs.SetPermissions.pl 2>&1>/dev/null 
