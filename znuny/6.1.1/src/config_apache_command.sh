DEFAULT_ZNUNY_APACHE_DOMAIN="_default_"
gen_add_apache2_main_conf "${ZNUNY_APACHE_DOMAIN:-$DEFAULT_ZNUNY_APACHE_DOMAIN}"

customLogger "info" "config_apache" "Create the virtualhost to expose Znuny"
ln -s /opt/otrs/scripts/apache2-httpd.include.conf /etc/apache2/conf-available/zzz_znuny.conf || true

customLogger "info" "config_apache" "Enable then add rewrite rules"
if [[ ! -z ${ZNUNY_APACHE_REWRITE_RULES} ]]; then
  echo -e "\n###\n#Add custom rewrite rules\n###" >> /etc/apache2/conf-available/zzz_znuny.conf
  echo "<IfModule mod_rewrite.c>" >> /etc/apache2/conf-available/zzz_znuny.conf
  echo "    RewriteEngine on" >> /etc/apache2/conf-available/zzz_znuny.conf

  while IFS= read -r RULE; do
    echo "        ${RULE}" >> /etc/apache2/conf-available/zzz_znuny.conf
  done <<< "${ZNUNY_APACHE_REWRITE_RULES}"

  echo -e "</IfModule>\n" >> /etc/apache2/conf-available/zzz_znuny.conf
fi

echo -e "CustomLog \${APACHE_LOG_DIR}/znuny.log znuny" >> /etc/apache2/conf-available/zzz_znuny.conf

customLogger "info" "config_apache" "Enable required Apache modules - Part 1"
a2enmod perl headers deflate filter cgi 2>&1>/dev/null

customLogger "info" "config_apache" "Disable useless Apache modules"
a2dismod mpm_event 2>&1>/dev/null

customLogger "info" "config_apache" "Enable required Apache modules - Part 2"
a2enmod mpm_prefork 2>&1>/dev/null

customLogger "info" "config_apache" "Enable the virtualhost to expose Znuny"
a2enconf zzz_znuny 2>&1>/dev/null

