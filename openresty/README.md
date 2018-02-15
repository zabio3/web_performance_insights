[Openresty](https://openresty.org/en/)
===

## 概要

オリジンコンテンツに対するパフォーマンスチューニング及び測定の自動化のため

## 詳細

openrestyのluaで、ローカル環境からのアクセスかつ特定のヘッダーが付与されている場合、対象のFQDNのconfを自動で書き換えるようにさせる。

 - ngrokで発行されたFQDNをリクエストすることで書き換え可能


##### setup

```
docker-compose up -d openresty_proxy
```

## 参考

 - [docker-openresty](https://github.com/openresty/docker-openresty)