# mirakurun recpt1

mirakurunの公式イメージにb25付きのrecpt1を入れるDockerfileです。
デフォルトの録画コマンドがうまく動かなかったときに使ってみてください。

## 動作環境

* Ubuntu Server 24.04
* Docker Engine 28.0.4

## 準備

pt3ドライバのインストール

```bash
sudo install_pt3_driver.sh
reboot

# pt3デバイスがあるか確認
ls /dev/pt3*
/dev/pt3video0  /dev/pt3video1  /dev/pt3video2  /dev/pt3video3
```

## 使い方

```bash
# イメージのみビルド
sudo docker build -t mirakurun_recpt1 .

# docker composeで実行
sudo docker compose up -d

# チャンネルスキャン（起動後しばらくしてから）
curl -X PUT "http://127.0.0.1:40772/api/config/channels/scan?type=GR&setDisabledOnAdd=false&refresh=true"
curl -X PUT "http://127.0.0.1:40772/api/config/channels/scan?type=BS&setDisabledOnAdd=false&refresh=true"
curl -X PUT "http://127.0.0.1:40772/api/config/channels/scan?type=CS&setDisabledOnAdd=false&refresh=true"
```
