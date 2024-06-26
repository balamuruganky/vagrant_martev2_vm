#! /usr/bin/env sh

# Do argument checks
if [ ! "$#" -ge 1 ]; then
    echo "Usage: $0 {ws_path}"
    echo "Example: $0 '/home/vagrant/martev2_ws'"
    exit 1
fi

# WS_PATH
if [ ! -z "$1" ]; then
    WS_PATH=$1
else
    WS_PATH="/home/vagrant/martev2_ws"
fi

echo "***** Workspace Path : $WS_PATH"
EXPORTS_FILE_PATH=/etc/profile.d/martev2_exports.sh

exports() {
    echo "export MARTe2_DIR=${WS_PATH}/MARTe2-dev" >> ${EXPORTS_FILE_PATH}
    echo "export MARTe2_Components_DIR=${WS_PATH}/MARTe2-components" >> ${EXPORTS_FILE_PATH}
    echo "export OPEN62541_LIB=${WS_PATH}/open62541/build/bin" >> ${EXPORTS_FILE_PATH}
    echo "export OPEN62541_INCLUDE=${WS_PATH}/open62541/build" >> ${EXPORTS_FILE_PATH}
    echo "export SDN_CORE_INCLUDE_DIR=${WS_PATH}/SDN_1.0.12_nonCCS/src/main/c++/include/" >> ${EXPORTS_FILE_PATH}
    echo "export SDN_CORE_LIBRARY_DIR=${WS_PATH}/SDN_1.0.12_nonCCS/target/lib/" >> ${EXPORTS_FILE_PATH}
    echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MARTe2_DIR/Build/x86-linux/Core/:$SDN_CORE_LIBRARY_DIR" >> ${EXPORTS_FILE_PATH}
    chmod +x ${EXPORTS_FILE_PATH}
}

if [ -f "$EXPORTS_FILE_PATH" ]; then
    echo "$EXPORTS_FILE_PATH exists. No action required."
else
    echo "$EXPORTS_FILE_PATH does not exist. Copying the file"
    exports
fi

