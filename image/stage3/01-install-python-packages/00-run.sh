#!/bin/bash -e

install -d "${ROOTFS_DIR}/opt/znail"
install -v -m 600 /vagrant/requirements.txt "${ROOTFS_DIR}/opt/znail/requirements.txt"
install -v -m 600 /vagrant/dist/pypi/*.whl "${ROOTFS_DIR}/opt/znail"

rm -f "${ROOTFS_DIR}/usr/local/bin/hub-ctrl"
ln -s /opt/znail/venv/lib/python3.7/site-packages/znail/netem/data/hub-ctrl "${ROOTFS_DIR}/usr/local/bin/hub-ctrl"

on_chroot << EOF
pushd /opt/znail
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
pip3 install *.whl
popd
EOF
