# /bin/sh
git clone --depth 1 https://github.com/m-tsudo/pt3.git
cd pt3/
make
make install
bash dkms.install
