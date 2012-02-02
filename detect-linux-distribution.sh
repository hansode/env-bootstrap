#!/bin/sh
#

LANG=C
LC_ALL=C

set -e

# * /etc/lsb-release
# DISTRIB_ID=Ubuntu
# DISTRIB_RELEASE=10.04
# DISTRIB_CODENAME=lucid
# DISTRIB_DESCRIPTION="Ubuntu 10.04.3 LTS"
#
# * /etc/redhat-release
# CentOS Linux release 6.0 (Final)
# Red Hat Enterprise Linux Server release 6.0 (Santiago)
# Scientific Linux release 6.0 (Carbon)

DISTRIB_ID=
DISTRIB_RELEASE=
DISTRIB_FLAVOR=

# rhel
if [ -f /etc/redhat-release ]; then
  DISTRIB_FLAVOR=RedHat
  if [ -f /etc/centos-release ]; then
    DISTRIB_ID=CentOS
  elif [ -f  /etc/fedora-release ]; then
    DISTRIB_ID=Fedora
  else
    # rhel, scientific
    case "$(sed 's,Linux .*,,; s, ,,g' /etc/redhat-release)" in
    Scientific)
      DISTRIB_ID=Scientific
      ;;
    RedHatEnterprise)
      DISTRIB_ID=RHEL
      ;;
    CentOS*)
      # 5.x
      DISTRIB_ID=CentOS
      ;;
    *)
      DISTRIB_ID=Unknown
      ;;
    esac
  fi
  DISTRIB_RELEASE=$(sed -e 's/.*release \(.*\) .*/\1/' /etc/redhat-release)
# debian
elif [ -f /etc/debian_version ]; then
  DISTRIB_FLAVOR=Debian
  if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
  else
    DISTRIB_ID=Debian
  fi
# others
else
  DISTRIB_ID=Unknown
fi

cat <<EOS
DISTRIB_FLAVOR=${DISTRIB_FLAVOR}
DISTRIB_ID=${DISTRIB_ID}
DISTRIB_RELEASE=${DISTRIB_RELEASE}
EOS
