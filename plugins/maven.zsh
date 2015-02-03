export MAVEN_OPTS="-Xms2048m -Xmx4096m"

export ANT_OPTS="-Xms256m -Xmx1024m"

mvn() {
  command mvn $* | sed \
  -e 's_\(Failures: [1-9][0-9]*\)_[1;31m\1[0m_g' \
  -e 's_\(Errors: [1-9][0-9]*\)_[1;31m\1[0m_g' \
  -e 's_\(Skipped: [1-9][0-9]*\)_[1;33m\1[0m_g' \
  -e 's_\(\[WARN\].*\)_[1;33m\1[0m_g' \
  -e 's_\(\[WARNING\].*\)_[1;33m\1[0m_g' \
  -e 's_\(\[ERROR\].*\)_[1;31m\1[0m_g' \
  -e 's_\(\[INFO] BUILD SUCCESS\)_[1;32m\1[0m_g' \
  -e 's_\(\[INFO] BUILD SUCCESSFUL\)_[1;32m\1[0m_g'
}
