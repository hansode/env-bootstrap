#!/bin/bash
#
#
#
export LANG=C
export LC_ALL=C

set -e

devel_user=$(whoami)
#devel_group=$(getent group $(id -g) 2>/dev/null | awk -F: '{print $1}')
devel_home=$(getent passwd ${devel_user} 2>/dev/null | awk -F: '{print $6}')
devel_home=${devel_home:-~}
work_dir=${devel_home}/work

cat <<EOS
devel_user  = ${devel_user}
devel_home  = ${devel_home}
work_dir    = ${work_dir}
EOS

[ -d ${work_dir} ] || mkdir ${work_dir}
mkdir -p ${work_dir}/repos/git/github.com

cd ${work_dir}/repos/git/github.com
projects="dotfiles env-builder"
for project in ${projects}; do
  echo ... ${project}
  [ -d ${project} ] || git clone git://github.com/hansode/${project}.git
  cd ${project}
  git pull
  cd -
done

cd ${work_dir}/repos/git/github.com/dotfiles
for i in *;do [ -d $i ] || contineu; echo ... $i; (cd $i && make); done

exit 0
