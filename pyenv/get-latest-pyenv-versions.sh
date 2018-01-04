#!/usr/bin/env bash
# Installs and uninstalls old Python 2.7, and 3.x versions.
#
# Currently does 2.7, 3.5, and 3.6.
#
# I mainly use this on OSX, and use brew-managed Pypy and Pypy 3, because it
# was faster than custom building Pypy 3 all the time.
set -efu
set -o pipefail

if ! which pyenv-migrate &> /dev/null; then
  echo 'pyenv-migrate is required for this script.'
  exit 1
fi

if ! which aria2c &> /dev/null; then
  echo 'aria2c is recommended to speed up downloads'
fi

installable_versions="$(pyenv install -l)"
installed_versions="$(pyenv versions --bare)"

global_versions=""

for version in "2.7" "3.5" "3.6"; do
  echo "Checking ${version}"
  version="${version/./\\.}"
  versions="$(echo "$installable_versions" | egrep "^\W*${version}")"
  echo "Found versions:"
  echo "${versions}"
  latest_version="$(echo "$versions" | grep -v "rc\|dev" | tail -n 1 | tr -d "[:space:]")"
  echo "Latest version: ${latest_version}"
  installed_version="$(echo "$installed_versions" | egrep "^\W*${version}" | tr -d "[:space:]")"
  echo "Installed version: ${installed_version}"
  if [[ "${installed_version}" != "${latest_version}" ]]; then
    echo "Needs to update!!!"
    pyenv install "${latest_version}"
    pyenv migrate "${installed_version}" "${latest_version}"
    pyenv uninstall -f "${installed_version}"
    global_versions="${global_versions} ${latest_version}"
  else
    echo "Already latest version: ${installed_version}"
  fi
  echo
done
(
  set -x
  pyenv global ${global_versions}
)
