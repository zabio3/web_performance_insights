web_performance_insights
===

Repository for web content performance verification

## Overview

 - Measure web content performance using [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/).
    - Use [ngrok](https://ngrok.com/) to expose local environment to the internet for measurement
    - Dynamically rewrite target FQDN to ngrok-issued FQDN using OpenResty

 - For content compression: [httrack](https://www.httrack.com/) or `wget -r -np <target_url>`

## Version
 - Tested on CentOS 7 and Amazon Linux

## Architecture

#### First Cache

 - Pre-cache content on the cache server

![First Cache](sequence_tools/images/first_cache.svg.png)

#### Measurement

 - Sequence diagram of request flow when accessing the target FQDN top page

##### Cached Content (Target FQDN)

![Cached Content](sequence_tools/images/target_fqdn_cache.svg.png)

##### Uncached Content (Target FQDN)

![Uncached Content](sequence_tools/images/target_fqdn_no_cache.svg.png)

##### Non-Target FQDN Content

![Non-Target FQDN Content](sequence_tools/images/not_target_fqdn.svg.png)

## Usage

### AWS Deployment

 - Register AWS CLI credentials beforehand. Set instance type, subnet id, ami id, key, etc. in configuration.tf.

```
cd terraform
terraform apply
```

### Server Setup

```
cd playbook
ansible-playbook build.yml
```

### Proxy Server (OpenResty) Setup

```docker
docker-compose build openresty_proxy
docker-compose up -d openresty_proxy
```

#### Generate New Proxy Config

 - Generate ngrok address beforehand (for exposing proxy server externally. Set cache server address as second argument if using cache server in front)

```
sh bin/create_fqdn_conf.sh <target_fqdn> <front_address>
```

#### Delete Proxy Config

 - Delete proxy server config (soft delete)

```
sh bin/delete_fqdn_conf.sh <target_fqdn>
```

### Cache Server (Nuster) Setup

```docker
docker-compose build nuster_cache
docker-compose up -d nuster_cache
```

## Multi-Browser Testing

 - [Using BrowserStack](https://www.browserstack.com/automate/node)

```
npm install -g selenium-webdriver
```

## Additional Documentation

 - [OpenResty](Dockerfiles/openresty/README.md)
 - [Nuster](Dockerfiles/nuster/README.md)
 - [Sequence Diagrams](sequence_tools/README.md)
 - [Verification Notes](verify.md)
