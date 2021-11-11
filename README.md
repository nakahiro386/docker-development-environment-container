# docker-development-environment-container

小規模チームでの開発用に各種サービスをセルフホストで作成するサンプル。

* [paulczar/omgwtfssl - Docker Image | Docker Hub](https://hub.docker.com/r/paulczar/omgwtfssl)
* [Nginx - Official Image | Docker Hub](https://hub.docker.com/_/nginx)
* [osixia/openldap - Docker Image | Docker Hub](https://hub.docker.com/r/osixia/openldap)
* [osixia/phpldapadmin - Docker Image | Docker Hub](https://hub.docker.com/r/osixia/phpldapadmin)
* [portainer/portainer-ce - Docker Image | Docker Hub](https://hub.docker.com/r/portainer/portainer-ce)
* [Postgres - Official Image | Docker Hub](https://hub.docker.com/_/postgres)
    * gitbucket用
* [gitbucket/gitbucket - Docker Image | Docker Hub](https://hub.docker.com/r/gitbucket/gitbucket)

## Usage
* cloneしてきて起動する。
    ```sh
    $ git clone https://github.com/nakahiro386/docker-development-environment-container.git dev-container
    $ cd dev-container
    # 空ディレクトリでなければ起動できないため、.gitkeepが配置できない。
    $ sudo ./init.sh
    $ sudo docker-compose up -d
    ```
* `certs/ca.pem`をブラウザにインポートする。
    * IEの場合は`証明書をすべて次のストアに配置する。`を選択する。
    * 証明書ストアの`信頼されたルート証明機関`を選択する。
* `certs/cert.pem`をローカルに持ってきてgitの設定にパスを追加する。
    ```sh
    $ git config --global http."https://${SERVER_HOSTNAME}:${NGINX_SSL_PORT}/".sslCAInfo /path/to/your/cert.pem
    ```
* portainernの設定をする。
    * 初回ログイン時、管理者ユーザ`admin`のパスワードを入力する。
    * `Allow collection of anonymous statistics.`のチェックを外す（任意）
    * `Get Started`を選択
    * `Settings > Authentication`
        * `LDAP`を選択
        * `LDAP configuration`
            * `LDAP Server`
                * `openldap:389`(docker-composeで指定した名称)
            * `Anonymous mode`
                * off
            * `Reader DN`
                * cn=admin,dc=example,dc=org
        * `LDAP security`
            * 全部OFF
        * `Automatic user provisioning`
            * ON
        * `User search configratons`
            * Base DN
                * ou=Users,dc=example,dc=org
            * Username attribute
                * uid
            * Filter
                * ブランク
        * `Group search configurations`
            * Group Base DN
                * ou=Groups,dc=example,dc=org
            * Group Membership Attribute 
                * uniqueMember
            * Group Filter
                * ブランク
        * Save settings
    * `Users > Teams`
        * LDAPのグループ名と同じ名前でteamを作成する。
            * leaders
    * `Environments > Groups`
        * `Unassigned`(デフォルト)の`Manage access`を選択
        * プルダウンから登録したteamを選択する。


## Requirements

* Docker Engine
    * 1.13.1+
* docker-compose
    * 1.26.2

## License

MIT License

## Author

nakahiro386

