# 修改为自己的 AccessKey
AliAccessKeyId=""
AliAccessKeySecret=""

# acme.sh 执行 renewHook 时导出的环境变量列表
ACME_ENV_LIST=(
    "CERT_KEY_PATH"
    "CERT_FULLCHAIN_PATH"
    "Le_Domain"
)
# 检查环境变量是否存在
for value in "${ACME_ENV_LIST[@]}"; do
    [[ -v "$value" ]] || exit 1
done
unset value
# 获取证书自定义函数
get_cert() {
    # 使用 sed 删除掉证书文件的空行
    sed -e "/^$/d" "$CERT_FULLCHAIN_PATH"
}
# 获取密钥自定义函数
get_key() {
    cat "$CERT_KEY_PATH"
}

# shellcheck disable=SC2154
DOMAIN=$Le_Domain

if [[ "$Le_Domain" == \*.* ]]; then
    DOMAIN=".${Le_Domain#*\*.}"
else
    DOMAIN="$Le_Domain"
fi

aliyun dcdn \
    SetDcdnDomainSSLCertificate \
    --access-key-id $AliAccessKeyId \
    --access-key-secret $AliAccessKeySecret \
    --region cn-beijing \
    --endpoint dcdn.aliyuncs.com \
    --DomainName $DOMAIN \
    --SSLProtocol on \
    --CertType upload \
    --SSLPub="$(get_cert)" \
    --SSLPri="$(get_key)" || exit 1
