#!/usr/bin/env bash
#
#
set -u -e -o pipefail

action=$1
shift

case $action in
  help|--help)
    bash_setup print_help $0
    ;;

  *)
    echo "Unknown option: $action" 1>&2
    exit 1
    ;;

esac
