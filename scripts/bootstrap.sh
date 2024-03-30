#! /usr/bin/env sh

# Do argument checks
if [ ! "$#" -ge 1 ]; then
    echo "Usage: $0 {distro}"
    echo "Example: $0 'rhel'"
    echo "(Default platform 'rhel')"
    exit 1
fi

# DISTRO
DISTRO="rhel"
if [ ! -z "$1" ]; then
    DISTRO=$1
fi

rhel_install() {
    xfs_growfs /dev/vda3
    dnf update -y
    dnf install -y dnf-plugins-core yum-utils bash-completion
    dnf install epel-release -y
    dnf config-manager --set-enabled powertools
    dnf groupinstall -y "Development Tools"
    dnf install -y git cmake
    dnf -y install wget cmake3 libxml2 libxml2-devel bc
    dnf -y install octave
    dnf -y install ncurses-devel readline-devel
    dnf -y install python3.11 python3.11-pip perl-ExtUtils-ParseXS
    dnf -y install https://www.mdsplus.org/dist/el8/stable/RPMS/noarch/mdsplus-repo-7.132-0.el8.noarch.rpm
    dnf -y install mdsplus-kernel* mdsplus-java* mdsplus-python* mdsplus-devel*
    systemctl stop firewalld
    systemctl disable firewalld
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1
}

if [ "$DISTRO" == "rhel" ]; then
    rhel_install
else
    echo "NOT IMPLEMENTED YET!!!"
fi
