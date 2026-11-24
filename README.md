# 流浪猫狗救助系统

基于 SSM（Spring + SpringMVC + MyBatis）的 JavaWeb 课程项目

## 技术栈

- JDK 1.8（高版本 JDK 请用 `--release 8 -parameters` 编译）
- MySQL 8.0
- Tomcat 9.0
- Spring 5.3.18
- MyBatis 3.5.10
- Bootstrap 5
- Maven

## 已完成模块

### 前台用户端
- 用户注册/登录/个人中心/找回密码/注销账号
- 宠物列表/详情/申请领养/回访/退养
- 求助列表/详情/发布求助/求助响应
- 寻宠启事（发布、审核、撤回、找回、下架）
- 处罚查询与申诉（独立申诉表 + A组处罚内申诉）
- 举报提交与记录（`/report/publish` 与 `/report/submit` 两套入口）
- 志愿者认证、证书申请、消息中心、评论功能
- 知识科普、活动报名
- **志愿签到 / 签退 / 我的工时（C 组补充，`/sign/list`）**
- **物资捐赠 / 我的捐赠记录（C 组补充，`/material/list`）**

### 后台管理端
- 数据看板（含待审核寻宠、待复核申诉等待办统计）
- 用户管理、管理员管理、志愿者审核
- 宠物管理、领养审核、回访/退养管理
- 求助管理、求助响应管理、评论管理
- 寻宠启事管理、处罚申诉复核
- 举报管理（含 A组举报记录）、处罚管理
- 物资管理与库存预警、证书管理、活动管理、知识管理
- **志愿签到记录与工时审核（`/admin/sign/list`）**
- **志愿工时统计看板（`/admin/sign/stats`）**
- **看板接入签到次数 / 累计工时 / 捐赠笔数 / 待审核工时统计**

## 快速开始

### 1. 环境准备
- JDK 1.8
- MySQL 8.0
- Tomcat 9.0
- Maven 3.6+

### 2. 数据库配置
```sql
-- 创建数据库（脚本首行会自动建库，也可手动执行）
CREATE DATABASE pet_adoption CHARACTER SET utf8mb4;

-- 导入根目录 pet_adoption.sql（唯一脚本，共 27 张表）
```

> 数据库脚本统一为根目录 `pet_adoption.sql`，已包含志愿者认证表、A组举报记录表、处罚申诉字段，
> 以及 C 组补齐的 `volunteer_sign`（志愿签到/工时）表；`sql/` 下的重复脚本已移除。
> 三人请导入**同一份最终脚本**，不要各导各的。

> **安全加固说明**：JSP 输出全局 HTML 转义防 XSS、密码重置图形验证码（`/captcha.jpg`）、
> PBKDF2 加盐密码存储（旧 MD5 在登录成功时自动升级）、登录失败锁定（5 次锁 15 分钟）、友好错误页。

修改 `src/main/resources/jdbc.properties` 中的数据库账号密码

### 3. 项目部署
```bash
# 先运行库存逻辑的回归测试
mvn test

# 标准构建（Maven）
mvn clean package

# 无 Maven / 高版本 JDK 时，用 C 组提供的脚本固化 --release 8 -parameters
LIB_DIR=/path/to/WEB-INF/lib ./build-local.sh

# 把 target/pet-adoption.war 放到 Tomcat 的 webapps 目录下
```

> 本机无 MySQL / Tomcat 时，可只做编译自检：`build-local.sh` 会输出 class 数与 war 产物。
> 已验证：120 个 Java 全部编译通过（0 错误），字节码 major 52（Java 8）。

物资库存由入库、出库或捐赠操作调整，并同步记录流水；单次操作最多 100 万件。
出库必须填写用途。有库存或历史流水的物资不能删除，以免丢失库存或审计记录。

### 4. 访问
- 前台：http://localhost:8080/pet-adoption/
- 后台：http://localhost:8080/pet-adoption/admin/dashboard
- C 组新增前台入口：`/sign/list`、`/material/list`
- C 组新增后台入口：`/admin/sign/list`、`/admin/sign/stats`

## 测试账号

| 账号 | 密码 | 角色 | 绑定邮箱 |
|------|------|------|----------|
| admin | admin123 | 超级管理员 | admin@pet-adoption.local |
| manager | 123456 | 平台管理员 | manager@pet-adoption.local |
| testuser | 123456 | 普通用户 | testuser@pet-adoption.local |

> 初始化脚本中的密码为旧版 MD5，首次登录成功后自动升级为 PBKDF2 加盐哈希。
> 三个演示账号均已绑定邮箱，可直接走「找回密码」流程；自行注册的账号需先在个人中心绑定邮箱。
> 部署到公网前请务必修改这些初始口令。

## 项目结构

```
pet-adoption/
├── src/main/java/com/salmon/pet/
│   ├── controller/     # 控制器
│   ├── service/       # 业务逻辑
│   ├── mapper/         # 数据访问
│   ├── entity/         # 实体类
│   └── utils/          # 工具类
├── src/main/resources/
│   ├── mapper/         # MyBatis XML
│   ├── spring/         # Spring 配置
│   └── jdbc.properties # 数据库配置
├── src/main/webapp/
│   └── WEB-INF/views/  # JSP 页面
├── pet_adoption.sql    # 唯一建表脚本
├── build-local.sh      # 无 Maven 环境的本地构建脚本
└── pom.xml
```
