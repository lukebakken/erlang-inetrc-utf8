#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace

_tmp="$(realpath "$(dirname "$BASH_SOURCE")")"
readonly curdir="$_tmp"
unset _tmp

readonly certs_dir="$curdir/certs Евгений"
readonly data_dir="$curdir/data Евгений"

readonly ssl_dist_optfile_rmq0_conf_in="$data_dir/ssl_dist_optfile.rmq0.conf.in"
readonly ssl_dist_optfile_rmq0_conf_out="$curdir/ssl_dist_optfile.rmq0.conf"
readonly ssl_dist_optfile_rmq1_conf_in="$data_dir/ssl_dist_optfile.rmq1.conf.in"
readonly ssl_dist_optfile_rmq1_conf_out="$curdir/ssl_dist_optfile.rmq1.conf"

sed "s|@@CURDIR@@|$curdir|g" "$ssl_dist_optfile_rmq0_conf_in" > "$ssl_dist_optfile_rmq0_conf_out"
sed "s|@@CURDIR@@|$curdir|g" "$ssl_dist_optfile_rmq1_conf_in" > "$ssl_dist_optfile_rmq1_conf_out"
