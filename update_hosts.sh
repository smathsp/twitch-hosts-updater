#!/bin/bash

# IP 地址
IP_ADDRESS="192.168.0.1"

# 获取 Twitch ingest 数据
INGEST_DATA=$(curl -s https://ingest.twitch.tv/ingests)

# 提取域名并生成 hosts 文件内容
DOMAINS=$(echo "$INGEST_DATA" | jq -r '.ingests[].url_template | select(. != null) | capture("//(?<domain>[^/]+)/").domain' | sort -u)

# 生成 hosts 文件内容
HOSTS_CONTENT=""
for DOMAIN in $DOMAINS; do
  HOSTS_CONTENT+="$IP_ADDRESS $DOMAIN"$'\n'  # 修改了这里
done

# 将 hosts 内容写入文件
echo "$HOSTS_CONTENT" > twitch-hosts

echo "Successfully updated hosts file: hosts"
