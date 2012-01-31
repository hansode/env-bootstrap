#!/bin/bash
#
#
#
export LANG=C
export LC_ALL=C

set -e
abs_path=$(cd $(dirname $0) && pwd)
eval `${abs_path}/detect-linux-distribution.sh`

devel_user=$(echo ${DISTRIB_ID} | tr A-Z a-z)
devel_group=${devel_user}
devel_home=/home/${devel_user}

cat <<EOS
devel_user=${devel_user}
devel_group=${devel_user}
devel_home=/home/${devel_user}
EOS

#
getent group  ${devel_group} >/dev/null || groupadd ${devel_group}
getent passwd ${devel_user}  >/dev/null || useradd -g ${devel_group} -d ${devel_home} -s /bin/bash -m ${devel_user}
echo ${devel_user}:${devel_user} | chpasswd

devel_group=$(getent group ${devel_group} | awk -F: '{print $1}')
devel_home=$(getent passwd ${devel_user} | awk -F: '{print $6}')
work_dir=${devel_home}/work

cat <<EOS
devel_user  = ${devel_user}
devel_group = ${devel_group}
devel_home  = ${devel_home}
work_dir    = ${work_dir}
EOS

[ -f /etc/sudoers ] && {
  egrep ^${devel_user} /etc/sudoers -q || {
   echo "${devel_user} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
  }
}

exit 0
