# docker-development-environment-container

小規模チームでの開発用に各種サービスをセルフホストで作成するサンプル。

* [paulczar/omgwtfssl - Docker Image | Docker Hub](https://hub.docker.com/r/paulczar/omgwtfssl)
* [Nginx - Official Image | Docker Hub](https://hub.docker.com/_/nginx)

## Usage

* cloneしてきて起動する。
```sh
$ git clone https://github.com/nakahiro386/docker-development-environment-container.git dev-container
$ cd dev-container
$ docker-compose up -d
```
* `certs/ca.pem`をブラウザにインポートする。
    * IEの場合は`証明書をすべて次のストアに配置する。`を選択する。
    * 証明書ストアの`信頼されたルート証明機関`を選択する。

## Requirements

* Docker Engine
    * 1.13.1+
* docker-compose
    * 1.26.2

## License

MIT License

## Author

nakahiro386

