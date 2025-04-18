# acme.hook.sh

## 简介

收集一些用于 acme.sh 的 hook 脚本。

## acme.hook.ali_dcdn.sh

### 描述

阿里云全站加速 Https 证书更新脚本

### 使用方法

首先请安装 阿里云Cli 命令行工具

复制脚本文件，修改脚本中的 `AliAccessKeyId` 和 `AliAccessKeySecret`

然后，用下面的命令签发证书，`*.example.com` 替换成你的域名

> 域名要先添加到阿里云全站加速，否则会报错

```
acme.sh --issue --dns dns_dp -d *.example.com --reloadCmd /path/to/acme.hook.ali_dcdn.sh
```

后续的 renew 证书时也会自动更新证书