[Openresty](https://openresty.org/en/)
===

## 概要

オリジンコンテンツに対するパフォーマンスチューニング及び測定の自動化のため

## 詳細

openrestyのluaで、ローカル環境からのアクセスかつ特定のヘッダーが付与されている場合、対象のFQDNのconfを自動で書き換えるようにさせる。

 - ngrokで発行されたFQDNをリクエストすることで書き換え可能


#### コンテンツ圧縮について

 - 「pagespeed_insights」での結果を元に、圧縮したコンテンツを配置しておく。locationパスでのマッチングでコンテンツを返す
    - 圧縮コンテンツのパスをかくのも作業もdockerファイルでの対象外
    - このあたりもコンテンツ圧縮サーバを用意して自動化させたい

##### setup

```
docker-compose build --no-cache openresty_proxy
docker-compose up -d openresty_proxy
```

 - nginx.conf, conf.dディレクトリ以下のファイルを配置

ファイルの自動作成のため(nginxのグループ作って、rootに追加すれば、もっとセキュアにはなるが今回検証環境なので省略)

```
chmod 777 /etc/nginx/conf.d/./
```

## メモ
 - luaでconfファイルを自動生成させるには、対象ディレクトリへの書き込み権限が必要
 - luaでの変数一覧
    - https://gist.github.com/ykst/52205d4d4968298137ea0050c4569170
 - log周りも削除もしくは、外部に吐き出しなどしてもよいかも
    

## エラーメモ
 - [docker-composeでbuildする時にcacheを使わない](https://qiita.com/setouchi/items/e01557ae4647b8e3b1bc)
    - dockerfile書き換えても何度か変更されなかったため(nginx.confの書き換えが反映されていなくて調べるとこれが原因だった)
 - COPY failed: Forbidden path outside the build context: ../openresty/nginx.conf ()
    - DockerfileのCOPYは、コマンドを実行したディレクトリ以下のファイルしかコピーできないらしい。
 - COPY failed: stat /var/lib/docker/tmp/docker-builder425834845/nginx.conf: no such file or directory
    - [issueでバグとして報告されている。](https://github.com/openresty/docker-openresty/issues/64)
    - 手動でコピーするのはさすがにいけていない(一時しのぎで、volumeでつなげる)

## 参考

 - [docker-openresty](https://github.com/openresty/docker-openresty)