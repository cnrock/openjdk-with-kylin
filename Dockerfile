# --------- 1. 选择基础镜像 ---------
# 基础镜像需要支持目标架构（x86_64 和 aarch64）
FROM macrosan/kylin:v10-sp3-2403
LABEL maintainer="Wan Jie <webmaster@wanjie.info>"

# --------- 2. 安装 OpenJDK 17（支持多架构）--------
RUN set -eux; \
    ARCH=$(uname -m); \
    case "$ARCH" in \
        x86_64) \
            JDK_URL="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.19%2B10/OpenJDK17U-jdk_x64_linux_hotspot_17.0.19_10.tar.gz" \
            ;; \
        aarch64) \
            JDK_URL="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.19%2B10/OpenJDK17U-jdk_aarch64_linux_hotspot_17.0.19_10.tar.gz" \
            ;; \
        *) \
            echo "Unsupported architecture: $ARCH"; exit 1 \
            ;; \
    esac; \
    curl -L -o /tmp/jdk.tgz "$JDK_URL"; \
    mkdir -p /usr/local/jdk17; \
    tar -xzf /tmp/jdk.tgz -C /usr/local/jdk17 --strip-components=1; \
    rm -f /tmp/jdk.tgz; \
    ln -sf /usr/local/jdk17/bin/java /usr/bin/java; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 可选：设置环境变量
ENV JAVA_HOME=/usr/local/jdk17 \
    PATH="${JAVA_HOME}/bin:${PATH}" \
    LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    JAVA_TOOL_OPTIONS="-Duser.timezone=Asia/Shanghai"

# --------- 3. 验证 / 运行示例 ---------
# 注意：一个 Dockerfile 只能有一条 CMD，这里只保留 java -version
#CMD ["java", "-version"]
CMD ["jshell -v"]
