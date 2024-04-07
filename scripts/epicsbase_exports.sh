#! /usr/bin/env sh

# Do argument checks
if [ ! "$#" -ge 1 ]; then
    echo "Usage: $0 {ws_path}"
    echo "Example: $0 '/home/vagrant/martev2_ws'"
    exit 1
fi

# DISTRO
if [ ! -z "$1" ]; then
    WS_PATH=$1
else
    WS_PATH="/home/vagrant/martev2_ws"
fi

echo "***** Workspace Path : $WS_PATH"
export EPICS_BASE_DIR="${WS_PATH}"/epics-base
export EPICS_BASE_EXPORTS="/etc/profile.d/epicsbase_exports.sh"

epics_env() {
    touch ${EPICS_BASE_EXPORTS}
    echo "export EPICS_BASE=${EPICS_BASE_DIR}" >> ${EPICS_BASE_EXPORTS}
    echo "export EPICS_HOST_ARCH=$($EPICS_BASE_DIR/startup/EpicsHostArch)" >> ${EPICS_BASE_EXPORTS}
    echo "export PATH=$PATH:$EPICS_BASE/bin/$EPICS_HOST_ARCH" >> ${EPICS_BASE_EXPORTS}
    echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$EPICS_BASE/lib/$EPICS_HOST_ARCH" >> ${EPICS_BASE_EXPORTS}
    chmod +x ${EPICS_BASE_EXPORTS}
}

epics_env

if [ -f "$EPICS_BASE_EXPORTS" ]; then
    echo "$EPICS_BASE_EXPORTS exists. No action required."
else
    echo "$EPICS_BASE_EXPORTS does not exist. Copying the file"
    epics_env
fi
