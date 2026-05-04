
## 1. Git 仓库 README.md

```markdown
# Kylin Linux V10 SP3 + OpenJDK 17 镜像构建

本项目提供了一个基于麒麟操作系统 V10 SP3 的 Docker 镜像，内置 OpenJDK 17，支持 **amd64 (x86_64)** 与 **arm64 (aarch64)** 双架构。

镜像已推送至 Docker Hub：[cnrock/openjdk:17.0.19_10](https://hub.docker.com/r/cnrock/openjdk)

## 特点

- 基于麒麟系统 V10 SP3 镜像 `macrosan/kylin:v10-sp3-2403`
- 安装 Eclipse Temurin OpenJDK 17.0.19+10
- 自动识别架构并下载对应 JDK 包
- 设置时区为 `Asia/Shanghai`，编码为 `UTF-8`
- 默认 CMD 为 `jshell -v`（也可根据需要修改为 `java -version`）

## 文件说明

- `Dockerfile`：构建镜像的脚本

## 构建方法

```bash
# 本地构建（当前架构）
docker build -t cnrock/openjdk:17.0.19_10 .

# 如需同时构建多架构并推送，可使用 buildx
docker buildx build --platform linux/amd64,linux/arm64 -t cnrock/openjdk:17.0.19_10 --push .
```

## 使用方法

```bash
# 直接运行容器（进入 jshell 交互环境）
docker run -it --rm cnrock/openjdk:17.0.19_10

# 运行一次性 java 命令
docker run --rm cnrock/openjdk:17.0.19_10 java -version

# 挂载当前目录并编译/运行 Java 代码
docker run --rm -v "$PWD":/workspace -w /workspace cnrock/openjdk:17.0.19_10 java Hello.java
```

## 验证镜像

```bash
# 查看 Java 版本
docker run --rm cnrock/openjdk:17.0.19_10 java -version

# 应输出类似：
# openjdk 17.0.19 2026-04-21
```

## 其他版本

后续计划补充更多 OpenJDK 版本（如 11、21 等）的镜像，敬请期待。

## 许可证

镜像内各组件版权归原作者所有，本项目仅提供构建脚本。
```

---

## 2. Docker Hub 仓库概述（Overview）

```markdown
# cnrock/openjdk – 麒麟 V10 SP3 + OpenJDK 17

基于麒麟操作系统 V10 SP3 的 OpenJDK 17 镜像，支持 **amd64** 和 **arm64** 架构。

## 标签

- `17.0.19_10` – OpenJDK 17.0.19+10 (Temurin)

## 快速开始

```bash
docker pull cnrock/openjdk:17.0.19_10
docker run -it --rm cnrock/openjdk:17.0.19_10 jshell -v
```

## 特点

- 基础镜像：`macrosan/kylin:v10-sp3-2403`
- JDK 来源：Eclipse Temurin (Adoptium)
- 时区：`Asia/Shanghai`
- 默认命令：`jshell -v`（Java 交互式命令行）

## 验证

```bash
docker run --rm cnrock/openjdk:17.0.19_10 java -version
```

## 多架构支持

- `linux/amd64`
- `linux/arm64`

镜像自动适配主机架构。

## 源代码

Dockerfile 及构建脚本可在以下仓库获取：  
[（https://github.com/cnrock/openjdk-with-kylin）](https://github.com/cnrock/openjdk-with-kylin)

> 后续计划补充 OpenJDK 11、21 等版本。
```

---
