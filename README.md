web_performance_insights
===

WEBコンテンツの検証用リポジトリ

## 概要

 - 測定は、「[pagespeed insights](https://developers.google.com/speed/pagespeed/insights/?hl=ja)」で行い、WEBコンテンツパフォーマンスを測定し検証するための環境。
    - 「[ngrok](https://ngrok.com/)」を使い、ローカル環境をインターネット上に公開することで測定可能
    - 内部の向け先を書き換える必要があるため、「対象FQDN」を「ngrokで発行されたFQDN」にopenrestyを使って動的に書き換える
    
 - 対象コンテンツの圧縮を行う際には、「[httrack](https://www.httrack.com/)」
   もしくは、「wget -r -np <対象URL>」
   
## バージョン関連
 - centos7系, amazon linux 動作確認済

## 構成

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

### AWS上でのデプロイ

 - 事前にaws-cliにcredentialの情報を登録しておく。configuration.tfに、インスタンスタイプ, subnet id, ami id, keyなどをセット。

```
cd terraform
terraform applay
```

### サーバ単位での設定


```
cd playbook
ansible-playbook build.yml
```


### プロキシサーバ (Openresty) の設定

```docker
docker-compose build openresty_proxy
docker-compose up -d openresty_proxy
```
 
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

### キャッシュサーバ (Nuster) の設定

```docker
docker-compose build nuster_cache
docker-compose up -d nuster_cache
```

## マルチブラウザテスト

 - [browserstack利用](https://www.browserstack.com/automate/node)

```
npm install -g selenium-webdriver

```


## 各README.md

 - [Openrestyについて](Dockerfiles/openresty/README.md)
 - [nusterについて](Dockerfiles/nuster/README.md)
 - [シーケンス図について](sequence_tools/README.md)
 - [検証メモ](verify.md)

