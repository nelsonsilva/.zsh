wifi-password() {

  # locate airport(1)
  airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
  if [ ! -f $airport ]; then
    echo "ERROR: Can't find \`airport\` CLI program at \"$airport\"."
    exit 1
  fi

  # get current ssid
  ssid="`$airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'`"
  if [ "$ssid" = "" ]; then
    echo "ERROR: Could not retrieve current SSID. Are you connected?" >&2
    exit 1
  fi

  # warn user about keychain dialog
  echo "\033[90m … getting password for \"$ssid\". \033[39m"
  echo "\033[90m … keychain prompt incoming. \033[39m"

  sleep 2

  # source: http://blog.macromates.com/2006/keychain-access-from-shell/
  pwd="`security find-generic-password -ga \"$ssid\" 2>&1 >/dev/null`"

  if [[ $pwd =~ "could" ]]; then
    echo "ERROR: Could not find SSID \"$ssid\"" >&2
    exit 1
  fi

  # clean up password
  pwd=$(echo "$pwd" | sed -e "s/^.*\"\(.*\)\".*$/\1/")

  # print
  echo "\033[96m ✓ \"$pwd\" \033[39m"
}
