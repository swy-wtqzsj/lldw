#!/usr/bin/env bash
# =============================================================
# 流浪猫狗救助系统 - 本地构建脚本（C 组补充）
#
# 背景：A 组《给BC组的协作注意事项》§6 要求用 JDK 8 编译目标，
#       本机若为高版本 JDK 必须加 `--release 8 -parameters`，
#       否则 Spring 启动会报 major version / 参数名错误。
#
# 用法：
#   1) 已装 Maven：  ./build-local.sh          （自动走 mvn clean package）
#   2) 未装 Maven：  LIB_DIR=/path/to/jars ./build-local.sh
#      LIB_DIR 里放 WEB-INF/lib 下的依赖 jar（含 servlet/jsp api 用于编译，
#      打 war 时会自动排除 provided 的 servlet/jsp api）。
#
# 产物：target/pet-adoption.war
# =============================================================
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

LIB_DIR="${1:-${LIB_DIR:-$ROOT/lib}}"
OUT="$ROOT/target/pet-adoption"
WAR="$ROOT/target/pet-adoption.war"
CLASSES="$ROOT/target/local-classes"

if command -v mvn >/dev/null 2>&1; then
    echo "[build] 检测到 Maven，执行 mvn clean package（强制 -parameters）"
    mvn -q clean package -Dmaven.compiler.parameters=true
    echo "[build] 产物: $WAR"
    exit 0
fi

if [ ! -d "$LIB_DIR" ]; then
    echo "[build] 缺少依赖 jar 目录: $LIB_DIR"
    echo "        请把 WEB-INF/lib 下的依赖 jar 放到该目录，或安装 Maven 后重试。"
    exit 1
fi

echo "[build] 未检测到 Maven，使用 javac --release 8 -parameters 编译"
rm -rf "$CLASSES" "$OUT" "$WAR"
mkdir -p "$CLASSES" "$OUT/WEB-INF/classes" "$OUT/WEB-INF/lib"

if command -v cygpath >/dev/null 2>&1; then
    CP="$(cygpath -w "$LIB_DIR")/*"
else
    CP="$LIB_DIR/*"
fi

find src/main/java -name '*.java' | sort > "$ROOT/target/sources.txt"
javac --release 8 -parameters -encoding UTF-8 -nowarn -cp "$CP" -d "$CLASSES" \
      @"$ROOT/target/sources.txt"

cp -r "$CLASSES"/. "$OUT/WEB-INF/classes/"
cp -r src/main/resources/. "$OUT/WEB-INF/classes/"

# provided 依赖不打进 war，避免与 Tomcat 自带的 servlet/jsp api 冲突
find "$LIB_DIR" -maxdepth 1 -name '*.jar' \
     ! -name 'javax.servlet-api-*.jar' \
     ! -name 'javax.servlet.jsp-api-*.jar' \
     -exec cp {} "$OUT/WEB-INF/lib/" \;

cp -r src/main/webapp/WEB-INF/views "$OUT/WEB-INF/"
cp src/main/webapp/WEB-INF/web.xml "$OUT/WEB-INF/"
cp src/main/webapp/index.jsp "$OUT/"
cp -r src/main/webapp/static "$OUT/"

(cd "$OUT" && jar cf "$WAR" .)

echo "[build] 产物: $WAR"
echo "[build] class 数: $(find "$CLASSES" -name '*.class' | wc -l)"
echo "[build] 完成（字节码目标 Java 8 / major 52）"
