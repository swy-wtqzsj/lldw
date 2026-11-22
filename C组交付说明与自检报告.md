# C 组交付说明与自检报告

> 分支：`feature/group-c-volunteer-sign-material`（从 `main` 建，**未直接推 main**）
> 依据：A 组《给 B/C 组的协作注意事项》+《表格_20261118.csv》分工表中 C 组一行
> 目标：三人代码合到一起后能编译、能连库、所有页面跑得通

---

## 一、基线判断

| 材料 | 作用 | 结论 |
|---|---|---|
| `https://github.com/swy-wtqzsj/lldw.git` | 主仓库 | `main` 已合并 A 组 PR #1 与 B 组提交，含 113 个 Java / 60 个 JSP；A 组要求的「先合并 A 分支」已完成，无需再 merge |
| `https://github.com/swy-wtqzsj/demo-repository.git` | GitHub 自动生成的模板仓库 | 仅 README/index.html/workflows，无需求文档 |
| `lldw(1).zip`（11-18 快照） | 旧版本参考 | 未合并 A 组代码的旧 `main`（约 60 Java / 36 JSP），且 `target/pet-adoption/WEB-INF/lib` 提供了 26 个依赖 jar，本次用它完成无 Maven 环境下的编译 |
| `给BC组的协作注意事项.md` | **A 对 B/C 的具体要求** | 补表约定、Git 流程、共享导航文件、路由避让、环境对齐、§7 自检清单 |
| `表格_20261118.csv` | 分工表 | C 组业务域与页面/Controller/Service/Entity 清单 |

对照分工表逐项核对后，C 组在合并版 `main` 上**尚缺两块**：

1. `volunteer_sign` 志愿签到 / 工时统计（A 在注意事项 §1 点名由 C 组补的表；分工表里的 `VolunteerSign` 实体、「工时统计」后台页、「统计查询」服务）
2. 前台「物资捐赠」页面（分工表 PET‑1 前台页面；原仓库只有后台 `/admin/material`）

其余 C 组模块（知识、求助、寻宠、评论、活动、物资出入库与库存预警、数据看板）均已存在且路由可达。

---

## 二、本次补齐内容

### 1. 数据库：补 `volunteer_sign`（A 组 §1）

- 补进**同一份**脚本 `pet_adoption.sql`（README 已说明这是唯一脚本，`sql/` 下的重复脚本已移除），表编号 25；现有 27 张表。
- 严格遵守 A 的约定：表名小写下划线、关联用户字段 `user_id INT NOT NULL`、与现有表风格一致（InnoDB / utf8mb4 / 中文 COMMENT / 索引）。
- 字段：签到、签退、工时 `DECIMAL(4,1)`、服务类型、服务内容、状态（服务中/已签退/已作废）、工时审核状态（待审核/已通过/已驳回）、审核意见。
- 附 2 条初始化示例数据，使工时统计页在导库后即可见效果（可自行清理）。

**关于 A 提到的另两张缺表（请 B 组 / 组长确认）：**

| A 列出的缺表 | 当前仓库状态 | 处理 |
|---|---|---|
| `material`（C 组） | 已有 `material` + `material_record`，物资模块完整 | 不重复建表 |
| `visit_record`（B 组） | 回访记录由 `revisit` 表实现，B 组回访/退养模块已完整 | 不越界代改；机械补 `visit_record` 会与 `revisit` 重复，建议 B 组确认是否要改名 |

> **同步要求（A §1）**：请 A、B 在合并本分支后，重新导入根目录 `pet_adoption.sql`，三人本地保持同一份最终脚本。

### 2. 志愿签到 / 工时统计全链路（新增 8 个文件）

| 层 | 文件 |
|---|---|
| Entity | `entity/VolunteerSign.java` |
| Mapper | `mapper/VolunteerSignMapper.java`、`resources/mapper/VolunteerSignMapper.xml` |
| Service | `service/VolunteerSignService.java`、`service/impl/VolunteerSignServiceImpl.java` |
| Controller | `controller/VolunteerSignController.java`（前台 `/sign`）、`controller/AdminVolunteerSignController.java`（后台 `/admin/sign`） |
| JSP | `views/sign/list.jsp`、`views/admin/sign_list.jsp`、`views/admin/sign_stats.jsp` |

功能：签到（同一用户不允许并存多条未签退记录）、签退自动结算工时（0.1–24 小时，保留 1 位小数）、我的签到与累计工时、后台签到记录筛选与工时审核、审核通过后把累计工时同步回 `volunteer.work_hours`（不改动 A 组的 Java 文件）、志愿者工时排行与全局汇总看板。

### 3. 前台物资捐赠（新增 2 个文件 + 6 处扩展）

- 新增 `controller/MaterialController.java`（`/material`）、`views/material/list.jsp`：库存浏览（含低库存预警）、选择已有物资或填写新物资捐赠、我的捐赠记录。
- 扩展 `MaterialService` / `MaterialServiceImpl` 的 `donate(...)`、`getDonationsByOperator(...)`；`MaterialMapper` 增 `selectByName` / `updateDonor`；`MaterialRecordMapper` 增 `selectDonationsByOperator`。
- 捐赠走**入库 + 出入库流水**，`usage_desc = '物资捐赠'`，与后台库存预警共用同一份数据，零侵入既有表结构。

### 4. 路由与共享导航（A 组 §3 / §5）

- 新增路由前缀 `/sign`、`/admin/sign`、`/material`，**未撞** A 组列出的任何已占用前缀；`/admin/**` 由现有 `LoginInterceptor` 保护。
- 三个共享文件按 A 的建议**由 C 统一维护一次**：
  - `index.jsp`：主导航加「物资捐赠」，登录后加「志愿签到」
  - `WEB-INF/views/admin/dashboard.jsp`：左侧菜单加「志愿签到」「工时统计」，内容概览加签到次数/累计工时/捐赠笔数，待办加「待审核工时」
  - `WEB-INF/views/user/profile.jsp`：我的服务加「我的签到与工时」「物资捐赠」
- `DashboardMapper.xml` 的 `selectCounts` 增加 5 个统计子查询（签到总数、累计工时、今日签到、待审核工时、捐赠笔数）。
- **请 A、B 后续要加菜单时把链接发我或在同一分支改，别三人同时改这三个文件。**

### 5. 构建与文档

- 新增 `build-local.sh`：无 Maven 时用 `javac --release 8 -parameters -encoding UTF-8` 编译并打 war，固化 A 组 §6 的 JDK 版本坑；有 Maven 时走 `mvn clean package -Dmaven.compiler.parameters=true`。
- 更新 `README.md`：补充 C 组模块、访问入口、27 张表说明、构建方式与测试账号差异。

---

## 三、A 组 §7 自检清单逐项结果

| # | A 的检查项 | 结果 | 证据 |
|---|---|---|---|
| 1 | `git status` 干净，三人分支合进 main | **部分** | A/B 已在 `main`；C 按 §2 在 `feature/group-c-volunteer-sign-material` 上开发并本地提交，**未直接推 main，待提 PR 合并** |
| 2 | 16 张表全部建成，导入无报错 | **通过（静态）/ 未实跑** | 27 张 CREATE TABLE（脚本已迭代，超过 A 当时的 13+3）；括号/主键/INSERT 引用表全部校验通过；`volunteer_sign.user_id INT NOT NULL` 已确认。本机无 MySQL，未实际导入 |
| 3 | 全量编译 0 错误，class 数 ≥ 60 | **通过** | 120 个 Java → 120 个 class，javac 0 错误；全部 major version = 52（Java 8） |
| 4 | 首页、登录、后台 dashboard 能打开 | **静态通过 / 未实跑** | 81 个视图引用全部有对应 JSP；本机无 Tomcat，未启动容器 |
| 5 | 三人页面逐个点开无 404/500 | **静态通过 / 未实跑** | 33 个 Controller / 132 条路由 / 64 个 JSP；JSP 链接 0 个找不到路由；完整路由重复 0 |
| 6 | 前台导航、后台菜单三人入口都在 | **通过** | 三个共享文件已统一补齐并交叉核对 |
| 7 | 没有重复的 Controller 路由 | **通过** | 完整路由重复 0；仅 `AdminPetController`/`AdminReturnController` 等复用类级前缀 `/admin/pet`，方法路径不同，属既有设计且不构成冲突 |

**构建产物**：`target/pet-adoption.war`（20 MB）
- 120 个 `.class`、64 个 JSP、23 个 Mapper XML、26 个依赖 jar、`WEB-INF/web.xml`、`index.jsp`、`static/**`
- provided 的 `javax.servlet-api` / `javax.servlet.jsp-api` 已从 war 中排除，避免与 Tomcat 冲突
- `target/` 被 `.gitignore` 忽略，war 不进 git，需本地取用

---

## 四、部署与验证（在有 MySQL 8 + Tomcat 9 的机器上）

```bash
# 1. 导入唯一脚本（会重建 pet_adoption 库，注意备份）
mysql -uroot -p < pet_adoption.sql

# 2. 核对 jdbc.properties（库名 pet_adoption / root / 123456 / localhost:3306）

# 3. 构建
mvn clean package
# 或：LIB_DIR=/path/to/WEB-INF/lib ./build-local.sh

# 4. 部署 target/pet-adoption.war 到 Tomcat 9 webapps，访问
#    http://localhost:8080/pet-adoption/
#    http://localhost:8080/pet-adoption/admin/dashboard
```

**登录账号**：`admin / admin123`（超级管理员）或 `manager / 123456`（管理员）。
> A 组注意事项 §6 写的 `admin / 123456` 与合并后 SQL 不一致：SQL 中 admin 的密码是 `admin123` 的 MD5
> `0192023a7bbd73250516f069df18b500`。若坚持用 `admin / 123456`，执行：
> `UPDATE user SET password='e10adc3949ba59abbe56e057f20f883e' WHERE username='admin';`
> 本次未擅自改动 A 组的初始化数据。

**C 组页面验收路径**：
- 前台：`/sign/list`（签到→签退→查看工时）、`/material/list`（捐赠→库存与流水变化）
- 后台：`/admin/sign/list`（筛选、通过/驳回工时）、`/admin/sign/stats`（工时排行）、`/admin/dashboard`（新增统计项）

---

## 五、Git 同步（A 组 §2）

```bash
git checkout main && git pull
git checkout feature/group-c-volunteer-sign-material
# 推送前先 pull 一次解决冲突
git push -u origin feature/group-c-volunteer-sign-material
# 在 GitHub 提 PR 合回 main，不要直接推 main
```

> 注意两点坑：origin 若是 ghproxy 镜像地址会推不上去，先
> `git remote set-url origin https://github.com/swy-wtqzsj/lldw.git`；
> 认证用 GitHub Personal Access Token，不是账号密码。

---

## 六、尚未完成 / 需人工确认

1. **本机无 MySQL 8 / Tomcat 9**，数据库导入与页面实跑（登录、点开页面、无 404/500）无法在本环境执行，以上为静态 + 编译级验证。请在有环境的机器上按第四节走一遍。
2. `visit_record` 的命名分歧（见第二节表格）需 B 组 / 组长拍板。
3. `admin` 密码与 A 组文档的差异需统一口径。
4. 本分支尚未 push、尚未提 PR（按 A 组 §2 由组长合并）。
