検証メモ
===

## 解析

goでネットワークのレスポンスヘッダーのパースを行う
 - 対象FQDNのみパース
 - 何に時間を取られているのか？（dnsルックアップ、レンダブロックのチェック）
 - cache (etag, cache-control, expiretimeの長さ)
 - gzip, zopfli(deflateより効率よい)
 - js, css圧縮
 - 画像系のチェック
 - document.writeがあるかチェック
 などなど
 
## コンテンツ圧縮について

 - [brotriでのキャッシュ](https://github.com/google/ngx_brotli)
    - varyヘッダー付与忘れずに
    - zstandardとかどうなんだろう比較
 - gzip static(zopfliのため)
    - cacheさせておく(キャッシュ用のサーバ追加)
 - image/jpegが圧縮されているかで、負荷がかかるので確認してチューニング
 
## プロキシ、キャッシュサーバについて

 - [H2O - an optimized HTTP server with support for HTTP/1.x and HTTP/2](https://github.com/h2o/h2o/)
    - nginxの性能6倍らしい（fastlyも利用している）

## 参考
