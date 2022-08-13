#!/bin/sh

isCommand() {
  # Retain backwards compatibility with common CI providers,
  # see: https://github.com/composer/docker/issues/107
  if [ "$1" = "sh" ]; then
    return 1
  fi

  convert.php --help
}
mkdir -p /app/output
# check if the first argument passed in looks like a flag
if [ "${1#-}" != "$1" ]; then
  set -- /sbin/tini -- convert.php "$@" --output=/app/output
# check if the first argument passed in is composer
elif [ "$1" = 'convert.php' ]; then
  set -- /sbin/tini -- "$@" --output=/app/output
# check if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- /sbin/tini -- convert.php "$@" --output=/app/output
fi

exec "$@"
