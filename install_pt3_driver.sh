# /bin/sh

# ビルドツールのインストール
apt update
apt install -y build-essential dkms

# デフォルトのpt3ドライバの無効化
echo 'blacklist earth_pt3' >> /etc/modprobe.d/blacklist.conf

# pt3ドライバのビルド
git clone --depth 1 https://github.com/m-tsudo/pt3.git
cd pt3/
make
make install
bash dkms.install
