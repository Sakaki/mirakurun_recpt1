# mirakurun recpt1

recpt1をenable-b25しつつビルドするDockerfileです。

## 動作環境

* Ubuntu Server 24.04
* Docker Engine 28.0.4

## 準備

pt3ドライバのインストール

```bash
sudo install_pt3_driver.sh
reboot
```

## 使い方

```bash
# イメージのみビルド
docker build -t mirakurun_recpt1 .

# docker composeで実行
docker compose up -d

# チャンネルスキャン（起動後しばらくしてから）
curl -X PUT "http://127.0.0.1:40772/api/config/channels/scan?type=GR&setDisabledOnAdd=false&refresh=true"
curl -X PUT "http://127.0.0.1:40772/api/config/channels/scan?type=BS&setDisabledOnAdd=false&refresh=true"
curl -X PUT "http://127.0.0.1:40772/api/config/channels/scan?type=CS&setDisabledOnAdd=false&refresh=true"
```
