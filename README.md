web_performance_insights
===

WEBコンテンツの検証用リポジトリ

## 概要

 - 測定は、「[pagespeed insights](https://developers.google.com/speed/pagespeed/insights/?hl=ja)」で行い、WEBコンテンツパフォーマンスを測定し検証するための環境。
    - 「[ngrok](https://ngrok.com/)」を使い、ローカル環境をインターネット上に公開することで測定可能
    - 内部の向け先を書き換える必要があるため、「対象FQDN」を「ngrokで発行されたFQDN」にopenrestyを使って動的に書き換える
    
 - 対象コンテンツの圧縮を行う際には、「[httrack](https://www.httrack.com/)」
   もしくは、「wget -r -np <対象URL>」
 
## 構成

### シーケンス図

#### ファーストキャッシュ時

 - 事前にキャッシュサーバにキャッシュさせる必要があるため

![ファーストキャッシュ時](sequence_tools/images/first_cache.svg.png)

#### 測定時

 - 対象FQDNのtopページにrequestで、各々の紐づくrequestの流れのシーケンス図

##### 対象FQDNキャッシュコンテンツ

![対象FQDNキャッシュコンテンツ](sequence_tools/images/target_fqdn_cache.svg.png)

##### 対象FQDN未キャッシュコンテンツ

![対象FQDN未キャッシュコンテンツ](sequence_tools/images/target_fqdn_no_cache.svg.png)

##### 対象外FQDNコンテンツ

![対象外FQDNコンテンツ](sequence_tools/images/not_target_fqdn.svg.png)

## 利用方法

 - プロキシサーバ (Openresty) の設定
 
#### プロキシサーバに新規conf生成

 - 事前にngrokにアドレスを生成しておく(プロキシサーバを外部に公開する場合。キャッシュサーバを前段に利用したい場合は、キャッシュサーバのアドレスを第二引数に設定する)
 
```
sh bin/create_fqdn_conf.sh <target_fqdn> <front_address>
```

#### プロキシサーバのconfを削除

 - プロキシサーバのconf削除（論理削除）
 
```
sh bin/delete_fqdn_conf.sh <target_fqdn>
```


## 各README.md

 - [Openrestyについて](Dockerfiles/openresty/README.md)
 - [シーケンス図について](sequence_tools/README.md)
 - [検証メモ](verify.md)

