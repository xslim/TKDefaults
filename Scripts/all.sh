#!/bin/sh

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"


config="Release" 
if [ "$config" = "${CONFIGURATION}" ]; then
  sh "${DIR}/xcode-build-bump.sh"
#sh "${DIR}/xcode-version-bump.sh"
else
  echo "Running in ${CONFIGURATION}"
fi


