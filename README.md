# Laravel Docker

Laravel の開発環境を Docker で構築する。

## 技術スタック

- PHP 8.0.8
- Nginx 1.21.1
- Mysql 8.0.25

### 参照: 最新バージョンの確認

- [PHP](https://github.com/docker-library/docs/blob/master/php/README.md#supported-tags-and-respective-dockerfile-links)
- [Nginx](https://hub.docker.com/_/nginx/)
- [MySQL](https://hub.docker.com/_/mysql/)
- [Laravel](https://github.com/laravel/framework/releases)

## インストールからアプリケーションの起動まで

Laravel Docker のリポジトリを取得する。

```shell
git clone https://github.com/nemaphila/laravel-docker
```

ディレクトリ名を任意のアプリケーション名に変更する。

```shell
mv laravel-docker 任意のアプリケーション名
cd 任意のアプリケーション名
```

.env ファイルを作成する。

```shell
cp .env.sample .env
```

.env を開き、データベース情報を編集する。

```diff
-- DB_NAME = db_name
++ DB_NAME = 任意のデータベース名
-- DB_USER = db_user_name
++ DB_USER = 任意のデータベースのユーザー名
-- DB_PASSWORD: db_password
++ DB_PASSWORD: 任意のデータベースのパスワード
```

コンテナを起動し、app コンテナに入る。

```shell
docker-compose up -d && docker-compose exec app bash
```

Laravel をインストールする。

```shell
composer create-project --prefer-dist laravel/laravel 任意のアプリケーション名
```

docker/default.conf を開き、次のように編集する。

```diff
server {
    listen 80;

--    root  /var/www/html;
++    root  /var/www/html/任意のアプリケーション名/public;
    index index.php index.html index.htm;
```

任意のアプリケーション名/.env を開き、次のように編集する。

```diff
DB_CONNECTION=mysql
-- DB_HOST=127.0.0.1
++ DB_HOST=mysql
DB_PORT=3306
-- DB_DATABASE=homestead
++ DB_DATABASE=任意のデータベース名
-- DB_USERNAME=homestead
++ DB_USERNAME=任意のデータベースのユーザー名
-- DB_PASSWORD=secret
++ DB_PASSWORD=任意のデータベースのパスワード
```

コンテナを再起動し、app コンテナに入る。

```shell
docker-compose restart && docker-compose exec app bash
```

マイグレーションを実行する。

```shell
cd 任意のアプリケーション名
php artisan migrate
```

[localhost:8000](http://localhost:8000/) で動作することを確認する。

## 参考記事

- [Laravelの環境をDockerで構築するチュートリアル](https://tech.windii.jp/backend/laravel/laravel-with-docker-compose)
- [M1 Macでno matching manifest for linux/arm64/v8が発生した](https://ryotarch.com/docker/no-matching-manifest-for-linux-arm64-v8-on-m1-mac/)

