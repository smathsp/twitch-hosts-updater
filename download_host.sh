#!/bin/bash

# 定义下载目标目录
DOWNLOAD_DIR="/data"

# 定义下载文件名 (修改后的文件名)
FILENAME="twitch-hosts"

# 定义 GitHub 仓库 URL
REPO_URL="https://github.com/smathsp/twitch-hosts-updater"

# 定义要下载的文件 URL
FILE_URL="${REPO_URL}/raw/main/${FILENAME}"

# 创建下载目录 (如果不存在)
mkdir -p "${DOWNLOAD_DIR}"

# 设置完整的文件路径
FULL_PATH="${DOWNLOAD_DIR}/${FILENAME}"

# 下载文件
echo "Downloading ${FILENAME} from ${FILE_URL} to ${FULL_PATH}..."
curl -s -L "${FILE_URL}" -o "${FULL_PATH}"

# 检查下载是否成功
if [ $? -eq 0 ]; then
  echo "Successfully downloaded ${FILENAME} to ${FULL_PATH}"
else
  echo "Error downloading ${FILENAME} from ${FILE_URL}"
  exit 1  # 以非零状态退出表示错误
fi

echo "Download complete."

# 重载配置
systemctl reload dnsmasq
if [ $? -ne 0 ]; then
  echo "Error reloading dnsmasq"
  exit 1  # 以非零状态退出表示错误
fi

echo "Successfully reloaded dnsmasq"

exit 0 # 以零状态退出表示成功
