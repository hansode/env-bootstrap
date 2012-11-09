#!/bin/bash
#
# requiers:
#  bash
#  dirname, pwd
#  detect-linux-distribution.sh
#  getent, groupadd, useradd, chpasswd
#  cat, egrep
#
set -e

## variables

readonly abs_dirname=$(cd $(dirname $0) && pwd)

eval `${abs_dirname}/detect-linux-distribution.sh`

declare devel_user=$(echo ${DISTRIB_ID} | tr A-Z a-z)
declare devel_group=${devel_user}
declare devel_home=/home/${devel_user}

## main

cat <<EOS
devel_user=${devel_user}
devel_group=${devel_user}
devel_home=/home/${devel_user}
EOS

getent group  ${devel_group} >/dev/null || groupadd ${devel_group}
getent passwd ${devel_user}  >/dev/null || useradd -g ${devel_group} -d ${devel_home} -s /bin/bash -m ${devel_user}
echo ${devel_user}:${devel_user} | chpasswd

declare devel_group=$(getent group ${devel_group} | awk -F: '{print $1}')
declare devel_home=$(getent passwd ${devel_user}  | awk -F: '{print $6}')
declare work_dir=${devel_home}/work

cat <<EOS
devel_user  = ${devel_user}
devel_group = ${devel_group}
devel_home  = ${devel_home}
work_dir    = ${work_dir}
EOS

[[ -f /etc/sudoers ]] && {
  egrep ^${devel_user} /etc/sudoers -q || {
   echo "${devel_user} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
  }
}
