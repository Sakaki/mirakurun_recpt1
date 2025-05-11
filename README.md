# mirakurun recpt1

recpt1をenable-b25しつつビルドするDockerfileです。

## 動作環境

* Ubuntu Server 24.04
* Docker Engine 28.0.4

## 準備

```bash
# pt3ドライバのinstall
git clone https://github.com/m-tsudo/pt3
cd pt3/
make
sudo make install
sudo bash dkms.install
sudo reboot
```

## Usage

```bash
docker build -t mirakurun_recpt1 .
```
