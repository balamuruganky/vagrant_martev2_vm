#! /usr/bin/env sh

# Do argument checks
if [ ! "$#" -ge 1 ]; then
    echo "Usage: $0 {ws_path}"
    echo "Example: $0 '/home/vagrant/martev2_ws'"
    exit 1
fi

# DISTRO
WS_PATH="/home/vagrant/martev2_ws"
if [ ! -z "$1" ]; then
    WS_PATH=$1
fi

echo "***** Workspace Path : $WS_PATH"
export OPCUA_BRANCH=1.3
export EPICS_BRANCH=R7.0.6

pull_sources() {
    pip3.11 install --user python-dateutil six sphinx
    git config --global http.postBuffer 524288000
    git config --global core.compression 0
    cd "$WS_PATH"
    git clone https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2.git MARTe2-dev
    git clone -b "#351_OPCUA-Review" https://github.com/balamuruganky/MARTe2-components.git --depth=1
    git clone https://github.com/balamuruganky/MARTe2-demos-padova.git
    git clone -b ${OPCUA_BRANCH} https://github.com/open62541/open62541.git --depth=1
    wget https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-demos-padova/raw/develop/Other/SDN_1.0.12_nonCCS.tar.gz
    tar zxvf SDN_1.0.12_nonCCS.tar.gz
    rm -f SDN_1.0.12_nonCCS.tar.gz
    ln -sf open62541 open62541-${OPCUA_BRANCH}
    ln -sf epics-base epics-base-${EPICS_BRANCH}
    ls -lart
}

build_opcua() {
    cd "${WS_PATH}" || { echo "Unable to cd to $WS_PATH"; exit 56; }
    # Build the open62541 library:
    mkdir -p ${WS_PATH}/open62541/build && cd $_ && cmake3 -DUA_ENABLE_AMALGAMATION=ON .. && make
}

build_marte2() {
    cd "${WS_PATH}" || { echo "Unable to cd to $WS_PATH"; exit 56; }
    cd "${WS_PATH}/MARTe2-dev" && make -f Makefile.x86-linux
    cd "${WS_PATH}/SDN_1.0.12_nonCCS" && make
    cd "${WS_PATH}/MARTe2-components" && make -f Makefile.linux
}

build_marte2_demos() {
    cd "${WS_PATH}/MARTe2-demos-padova" && make -f Makefile.x86-linux
}

pull_sources
build_opcua
build_marte2
build_marte2_demos
