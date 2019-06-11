NUXEO_HOME='~/nuxeo-cap'

alias cpweb='cp -r `find . -path "*/src/main/resources/web/nuxeo.war" -exec echo {}/ \;`'

compctl -k "(gui nogui help start stop restart configure wizard console status startbg restartbg pack mp-purge mp-list mp-init mp-add mp-install mp-uninstall mp-remove mp-reset -dc)" "*nuxeoctl"

gitf() {
  for dir in . *; do
    if [ -d "$dir"/.git ]; then
      echo "[$dir]"
      (cd "$dir" ; git "$@")
      echo
    fi
  done
}

gitfa() {
   ADDONS=$(mvn help:effective-pom -N|grep '<module>' |cut -d ">" -f 2 |cut -d "<" -f 1)
   for dir in $ADDONS; do
     if [ -d "$dir"/.git ]; then
       echo "[$dir]"
       (cd "$dir" ; git "$@")
       echo
     fi
   done
}

nuxeoctl() {
  [ -d ./bin ] || return 1
  BASE_PATH=./bin
  NUXEOCTL=$BASE_PATH/nuxeoctl
  chmod +x $NUXEOCTL
  $NUXEOCTL  "$@"
}

nxconsole() {
  nuxeoctl console | awk '
    /INFO/ { print "\033[34m" $0 "\033[0m" ;next}
    /WARN/ { print "\033[33m" $0 "\033[0m" ;next}
    /ERROR/ { print "\033[31m" $0 "\033[0m" ;next}
    1 {print}
  '
}

nxstart() {
  nuxeoctl start
  tail -f log/server.log | awk '
    /INFO/ { print "\033[34m" $0 "\033[0m" ;next}
    /WARN/ { print "\033[33m" $0 "\033[0m" ;next}
    /ERROR/ { print "\033[31m" $0 "\033[0m" ;next}
    1 {print}
  '
}

nxstop() {
  nuxeoctl stop
}

nxrestart() {
  nuxeoctl restart
  tail -f log/server.log | awk '
    /INFO/ { print "\033[34m" $0 "\033[0m" ;next}
    /WARN/ { print "\033[33m" $0 "\033[0m" ;next}
    /ERROR/ { print "\033[31m" $0 "\033[0m" ;next}
    1 {print}
  '
}

nxlink() {
  if (( ! $# )); then
    echo "usage: nxlink <folder>"
    return 1
  fi
  find . -name "nuxeo-*.jar" ! -name "*-test*.jar" ! -name "*-with-dependencies.jar" -exec ln -fs $PWD/{} $1/nxserver/bundles \;
}

cplinks() {
  if (( ! $# )); then
    echo "usage: cplinks <source folder> <target folder>"
    return 1
  fi
  find $1 -type l -exec cp -R {} $2 \;
}
