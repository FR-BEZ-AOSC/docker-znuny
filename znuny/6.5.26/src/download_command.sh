CONFIG_ZNUNY_VERSION=${args[-r]}
CONFIG_ZNUNY_CHECKSUM=${args[-s]}

DESTINATION="/tmp/znuny-${CONFIG_ZNUNY_VERSION}.tar.gz"

customLogger "info" "download" "Download the version ${CONFIG_ZNUNY_VERSION} of the archive of Znuny"
curl -fsSL \
  -o "${DESTINATION}" \
  "https://download.znuny.org/releases/znuny-${CONFIG_ZNUNY_VERSION}.tar.gz"

customLogger "info" "download" "Check the archive integrity"
if ! printf '%s  %s\n' "${CONFIG_ZNUNY_CHECKSUM}" "${DESTINATION}" | sha256sum --check --status; then
    customLogger "error" "The archive of the version ${CONFIG_ZNUNY_VERSION} of Znuny failed to pass the sum check with the hash ${CONFIG_ZNUNY_CHECKSUM}"
    exit 1
fi

customLogger "info" "download" "Extract the source code"
tar -xzf ${DESTINATION} -C /opt/otrs --strip-components=1

customLogger "info" "download" "Delete the archive of Znuny"
rm -f ${DESTINATION}

