#!/usr/bin/env bash
#
#


set -u -e -o pipefail

case $action in
  help)
    bash_setup print_help $0
    ;;

  *)
    echo "Unknown option: $action" 1>&2
    exit 1
    ;;

esac
