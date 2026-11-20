# 流浪猫狗救助系统

基于 SSM（Spring + SpringMVC + MyBatis）的 JavaWeb 课程项目

## 技术栈

- JDK 1.8
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

### 后台管理端
- 数据看板（含待审核寻宠、待复核申诉等待办统计）
- 用户管理、管理员管理、志愿者审核
- 宠物管理、领养审核、回访/退养管理
- 求助管理、求助响应管理、评论管理
- 寻宠启事管理、处罚申诉复核
- 举报管理（含 A组举报记录）、处罚管理
- 物资管理与库存预警、证书管理、活动管理、知识管理

## 快速开始

### 1. 环境准备
- JDK 1.8
- MySQL 8.0
- Tomcat 9.0
- Maven 3.6+

### 2. 数据库配置
```sql
-- 创建数据库
CREATE DATABASE pet_adoption CHARACTER SET utf8mb4;

-- 导入 pet_adoption.sql
```

> 数据库脚本统一为根目录 `pet_adoption.sql`，已包含志愿者认证表、A组举报记录表及处罚申诉字段；`sql/` 下的重复脚本已移除。

修改 `src/main/resources/jdbc.properties` 中的数据库账号密码

### 3. 项目部署
```bash
# 编译打包
mvn clean package

# 把 target/pet-adoption.war 放到 Tomcat 的 webapps 目录下
```

### 4. 访问
- 前台：http://localhost:8080/pet-adoption/
- 后台：http://localhost:8080/pet-adoption/admin/dashboard

## 测试账号

| 账号 | 密码 | 角色 |
|------|------|------|
| admin | admin123 | 超级管理员 |
| testuser | 123456 | 普通用户 |

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
└── pom.xml
```
