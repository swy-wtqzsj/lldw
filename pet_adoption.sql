-- =============================================================
-- 流浪猫狗救助系统 数据库建表脚本
-- DBMS: MySQL 5.7.26   存储引擎: InnoDB   字符集: utf8mb4
-- 数据库名: pet_adoption
-- 作者: 三文鱼小组 / 落地指导
-- =============================================================

DROP DATABASE IF EXISTS pet_adoption;
CREATE DATABASE pet_adoption DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE pet_adoption;

-- -------------------------------------------------------------
-- 1. 用户表 user
-- -------------------------------------------------------------
CREATE TABLE user (
  user_id        INT          NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  username       VARCHAR(20)  NOT NULL COMMENT '登录账号',
  password       VARCHAR(64)  NOT NULL COMMENT '密码(MD5加密)',
  phone          VARCHAR(11)  DEFAULT NULL COMMENT '手机号',
  email          VARCHAR(50)  DEFAULT NULL COMMENT '邮箱',
  nickname       VARCHAR(20)  DEFAULT NULL COMMENT '昵称',
  avatar         VARCHAR(255) DEFAULT NULL COMMENT '头像路径',
  gender         TINYINT      DEFAULT 0 COMMENT '性别:0未知1男2女',
  birthday       DATE         DEFAULT NULL COMMENT '生日',
  address        VARCHAR(100) DEFAULT NULL COMMENT '住址',
  role           TINYINT      DEFAULT 1 COMMENT '角色:1普通用户2志愿者3管理员9root',
  status         TINYINT      DEFAULT 1 COMMENT '账号状态:1正常0禁用',
  adopt_status   TINYINT      DEFAULT 1 COMMENT '领养资格:1正常2暂停3永久禁止',
  credit_score   INT          DEFAULT 100 COMMENT '信用分',
  real_name      VARCHAR(20)  DEFAULT NULL COMMENT '真实姓名(志愿者认证)',
  id_card        VARCHAR(20)  DEFAULT NULL COMMENT '身份证号(脱敏存储)',
  register_time   DATETIME     NOT NULL COMMENT '注册时间',
  PRIMARY KEY (user_id),
  UNIQUE KEY uk_username (username),
  UNIQUE KEY uk_phone (phone),
  UNIQUE KEY uk_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- -------------------------------------------------------------
-- 2a. 志愿者认证表 volunteer (A组)
-- -------------------------------------------------------------
CREATE TABLE volunteer (
  volunteer_id   INT          NOT NULL AUTO_INCREMENT COMMENT '志愿者记录ID',
  user_id        INT          NOT NULL COMMENT '申请用户ID',
  real_name      VARCHAR(20)  NOT NULL COMMENT '真实姓名',
  id_card        VARCHAR(18)  NOT NULL COMMENT '身份证号',
  phone          VARCHAR(11)  DEFAULT NULL COMMENT '联系电话',
  org_name       VARCHAR(100) DEFAULT NULL COMMENT '团队/机构名称',
  cert_type      TINYINT      DEFAULT 1 COMMENT '认证类型:1个人实名2团队/机构',
  cert_file      VARCHAR(255) DEFAULT NULL COMMENT '资质证明材料路径',
  intro          VARCHAR(500) DEFAULT NULL COMMENT '个人/团队简介',
  work_hours     INT          DEFAULT 0 COMMENT '累计服务工时',
  points         INT          DEFAULT 0 COMMENT '积分',
  level          INT          DEFAULT 1 COMMENT '等级',
  audit_status   TINYINT      DEFAULT 1 COMMENT '审核状态:1待审核2已通过3已拒绝',
  audit_opinion  VARCHAR(255) DEFAULT NULL COMMENT '审核意见',
  audit_admin_id INT          DEFAULT NULL COMMENT '审核管理员ID',
  apply_time     DATETIME     NOT NULL COMMENT '申请时间',
  audit_time     DATETIME     DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (volunteer_id),
  KEY idx_user_id (user_id),
  KEY idx_audit_status (audit_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='志愿者认证表';

-- -------------------------------------------------------------
-- 2b. 举报记录表 report_record (A组)
-- -------------------------------------------------------------
CREATE TABLE report_record (
  report_id     INT          NOT NULL AUTO_INCREMENT COMMENT '举报ID',
  reporter_id   INT          NOT NULL COMMENT '举报人ID',
  target_type   TINYINT      NOT NULL COMMENT '对象类型:1用户2宠物3求助4评论5活动',
  target_id     INT          NOT NULL COMMENT '被举报对象ID',
  reason        VARCHAR(255) NOT NULL COMMENT '举报原因',
  description   VARCHAR(500) DEFAULT NULL COMMENT '详细描述',
  evidence      VARCHAR(255) DEFAULT NULL COMMENT '证据图片路径',
  status        TINYINT      DEFAULT 1 COMMENT '处理状态:1待处理2已处理3已驳回',
  handle_result VARCHAR(255) DEFAULT NULL COMMENT '处理结果说明',
  admin_id      INT          DEFAULT NULL COMMENT '处理管理员ID',
  report_time   DATETIME     NOT NULL COMMENT '举报时间',
  handle_time   DATETIME     DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (report_id),
  KEY idx_reporter (reporter_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='举报记录表';

-- -------------------------------------------------------------
-- 2. 宠物表 pet
-- -------------------------------------------------------------
CREATE TABLE pet (
  pet_id         INT          NOT NULL AUTO_INCREMENT COMMENT '宠物ID',
  pet_no         VARCHAR(20)  NOT NULL COMMENT '宠物编号',
  pet_name       VARCHAR(50)  NOT NULL COMMENT '宠物名',
  species        TINYINT      NOT NULL DEFAULT 1 COMMENT '种类:1猫2狗',
  breed          VARCHAR(50)  DEFAULT NULL COMMENT '品种',
  gender         TINYINT      NOT NULL DEFAULT 0 COMMENT '性别:0未知1公2母',
  age_stage      TINYINT      DEFAULT 1 COMMENT '年龄段:1幼年2成年3老年',
  birthday       DATE         DEFAULT NULL COMMENT '生日',
  photo          VARCHAR(255) DEFAULT NULL COMMENT '封面照片路径',
  photos         TEXT         COMMENT '多图路径(逗号分隔)',
  description    TEXT         COMMENT '详细介绍',
  adopt_status   TINYINT      DEFAULT 1 COMMENT '领养状态:1待审核2待领养3审核中4已被领养5退养回流6暂停展示7已归档8已回归主人',
  is_neutered    TINYINT      DEFAULT 0 COMMENT '是否绝育:0否1是',
  is_vaccinated  TINYINT      DEFAULT 0 COMMENT '是否疫苗:0否1是',
  health_status  VARCHAR(1024) DEFAULT NULL COMMENT '健康状况描述',
  create_time    DATETIME     NOT NULL COMMENT '录入时间',
  update_time    DATETIME     NOT NULL COMMENT '更新时间',
  PRIMARY KEY (pet_id),
  UNIQUE KEY uk_pet_no (pet_no),
  KEY idx_adopt_status (adopt_status),
  KEY idx_species (species)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流浪猫狗信息表';

-- -------------------------------------------------------------
-- 3. 领养申请表 adoption
-- -------------------------------------------------------------
CREATE TABLE adoption (
  adopt_id         INT          NOT NULL AUTO_INCREMENT COMMENT '申请ID',
  user_id          INT          NOT NULL COMMENT '申请人ID',
  pet_id           INT          NOT NULL COMMENT '宠物ID',
  adopter_name     VARCHAR(20)  NOT NULL COMMENT '领养人姓名',
  phone            VARCHAR(11)  NOT NULL COMMENT '联系电话',
  economic_status  VARCHAR(50)  DEFAULT NULL COMMENT '经济状况',
  reason           VARCHAR(500) DEFAULT NULL COMMENT '申请理由',
  status           TINYINT      DEFAULT 1 COMMENT '状态:1待审核2同意3不同意4退养终止',
  apply_time       DATETIME     NOT NULL COMMENT '申请时间',
  audit_opinion    VARCHAR(500) DEFAULT NULL COMMENT '审核意见',
  audit_admin_id   INT          DEFAULT NULL COMMENT '审核管理员ID',
  audit_time       DATETIME     DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (adopt_id),
  KEY idx_user (user_id),
  KEY idx_pet (pet_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领养申请表';

-- -------------------------------------------------------------
-- 4. 回访记录表 revisit
-- -------------------------------------------------------------
CREATE TABLE revisit (
  revisit_id     INT          NOT NULL AUTO_INCREMENT COMMENT '回访ID',
  adopt_id       INT          NOT NULL COMMENT '领养记录ID',
  revisit_date   DATETIME     NOT NULL COMMENT '回访日期',
  photo          VARCHAR(255) DEFAULT NULL COMMENT '回访照片',
  health_desc    VARCHAR(1024) DEFAULT NULL COMMENT '健康状况描述',
  status         TINYINT      DEFAULT 1 COMMENT '回访状态:1待评估2正常3需关注4异常介入',
  admin_remark   VARCHAR(500) DEFAULT NULL COMMENT '管理员评估备注',
  PRIMARY KEY (revisit_id),
  KEY idx_adopt (adopt_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领养回访记录表';

-- -------------------------------------------------------------
-- 5. 求助信息表 help_request
-- -------------------------------------------------------------
CREATE TABLE help_request (
  help_id        INT          NOT NULL AUTO_INCREMENT COMMENT '求助ID',
  user_id        INT          NOT NULL COMMENT '求助者ID',
  title          VARCHAR(50)  NOT NULL COMMENT '求助标题',
  type           TINYINT      NOT NULL COMMENT '类型:1发现流浪动物2动物受伤3寻找失主4其他',
  content        TEXT         COMMENT '求助内容',
  location       VARCHAR(128) DEFAULT NULL COMMENT '位置信息',
  contact        VARCHAR(50)  DEFAULT NULL COMMENT '联系方式',
  photo          VARCHAR(255) DEFAULT NULL COMMENT '照片路径',
  publish_time   DATETIME     NOT NULL COMMENT '发布时间',
  audit_status   TINYINT      DEFAULT 1 COMMENT '审核状态:1待审核2已通过3已拒绝',
  handle_status   TINYINT      DEFAULT 1 COMMENT '处理状态:1待响应2已响应3处理中4已完成5已关闭',
  audit_opinion   VARCHAR(255) DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (help_id),
  KEY idx_user (user_id),
  KEY idx_audit (audit_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='求助信息表';

-- -------------------------------------------------------------
-- 6. 求助响应表 help_response
-- -------------------------------------------------------------
CREATE TABLE help_response (
  resp_id       INT          NOT NULL AUTO_INCREMENT COMMENT '响应ID',
  help_id       INT          NOT NULL COMMENT '求助ID',
  responder_id  INT          NOT NULL COMMENT '响应者ID',
  content       VARCHAR(500) NOT NULL COMMENT '响应内容',
  resp_time     DATETIME     NOT NULL COMMENT '响应时间',
  status        TINYINT      DEFAULT 1 COMMENT '状态:1待沟通2已接受3已完成',
  PRIMARY KEY (resp_id),
  KEY idx_help (help_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='求助响应表';

-- -------------------------------------------------------------
-- 7. 评论表 comment
-- -------------------------------------------------------------
CREATE TABLE comment (
  comment_id     INT          NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  user_id        INT          NOT NULL COMMENT '评论者ID',
  target_type     TINYINT      NOT NULL COMMENT '对象类型:1宠物2活动3知识4求助',
  target_id       INT          NOT NULL COMMENT '对象ID',
  content         VARCHAR(500) NOT NULL COMMENT '评论内容',
  comment_time    DATETIME     NOT NULL COMMENT '评论时间',
  status          TINYINT      DEFAULT 1 COMMENT '状态:1正常0隐藏',
  PRIMARY KEY (comment_id),
  KEY idx_target (target_type, target_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评论表';

-- -------------------------------------------------------------
-- 8. 活动表 activity
-- -------------------------------------------------------------
CREATE TABLE activity (
  activity_id    INT          NOT NULL AUTO_INCREMENT COMMENT '活动ID',
  title          VARCHAR(100) NOT NULL COMMENT '活动标题',
  content        TEXT         COMMENT '活动内容',
  location       VARCHAR(128) DEFAULT NULL COMMENT '活动地点',
  start_time     DATETIME     NOT NULL COMMENT '开始时间',
  end_time       DATETIME     NOT NULL COMMENT '结束时间',
  quota          INT          DEFAULT 0 COMMENT '人数上限(0不限)',
  signup_count   INT          DEFAULT 0 COMMENT '已报名人数',
  cover          VARCHAR(255) DEFAULT NULL COMMENT '封面图',
  status         TINYINT      DEFAULT 1 COMMENT '状态:1草稿2已发布3已结束4已下架',
  create_time    DATETIME     NOT NULL COMMENT '创建时间',
  PRIMARY KEY (activity_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='志愿活动表';

-- -------------------------------------------------------------
-- 9. 活动报名表 activity_signup (含志愿工时)
-- -------------------------------------------------------------
CREATE TABLE activity_signup (
  signup_id      INT          NOT NULL AUTO_INCREMENT COMMENT '报名ID',
  activity_id    INT          NOT NULL COMMENT '活动ID',
  user_id        INT          NOT NULL COMMENT '志愿者ID',
  signup_time    DATETIME     NOT NULL COMMENT '报名时间',
  status         TINYINT      DEFAULT 1 COMMENT '状态:1已报名2已参加3已缺席4已取消',
  checkin_time   DATETIME     DEFAULT NULL COMMENT '签到时间',
  checkout_time  DATETIME     DEFAULT NULL COMMENT '签退时间',
  work_hours     DECIMAL(4,1) DEFAULT 0 COMMENT '服务工时',
  PRIMARY KEY (signup_id),
  UNIQUE KEY uk_activity_user (activity_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动报名表/志愿工时表';

-- -------------------------------------------------------------
-- 10. 物资表 material
-- -------------------------------------------------------------
CREATE TABLE material (
  material_id    INT          NOT NULL AUTO_INCREMENT COMMENT '物资ID',
  name           VARCHAR(50)  NOT NULL COMMENT '物资名称',
  category       TINYINT      NOT NULL COMMENT '类别:1食物2药品3用品',
  quantity       INT          DEFAULT 0 COMMENT '库存数量',
  unit           VARCHAR(10)  DEFAULT '件' COMMENT '单位',
  warn_threshold INT          DEFAULT 5 COMMENT '预警阈值',
  donor          VARCHAR(50)  DEFAULT NULL COMMENT '捐赠人',
  create_time    DATETIME     NOT NULL COMMENT '入库时间',
  update_time    DATETIME     NOT NULL COMMENT '更新时间',
  PRIMARY KEY (material_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='物资库存表';

-- -------------------------------------------------------------
-- 11. 物资出入库流水 material_record
-- -------------------------------------------------------------
CREATE TABLE material_record (
  record_id      INT          NOT NULL AUTO_INCREMENT COMMENT '流水ID',
  material_id    INT          NOT NULL COMMENT '物资ID',
  type           TINYINT      NOT NULL COMMENT '类型:1入库2出库',
  quantity       INT          NOT NULL COMMENT '数量',
  usage_desc     VARCHAR(255) DEFAULT NULL COMMENT '出库用途',
  operator       VARCHAR(20)  DEFAULT NULL COMMENT '操作人',
  record_time    DATETIME     NOT NULL COMMENT '操作时间',
  PRIMARY KEY (record_id),
  KEY idx_material (material_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='物资出入库流水表';

-- -------------------------------------------------------------
-- 12. 举报表 report
-- -------------------------------------------------------------
CREATE TABLE report (
  report_id      INT          NOT NULL AUTO_INCREMENT COMMENT '举报ID',
  reporter_id    INT          NOT NULL COMMENT '举报人ID',
  target_type    TINYINT      NOT NULL COMMENT '被举报对象类型:1评论2求助3用户4活动',
  target_id      INT          NOT NULL COMMENT '被举报对象ID',
  reason         VARCHAR(255) NOT NULL COMMENT '举报原因',
  evidence       VARCHAR(255) DEFAULT NULL COMMENT '证据截图',
  status         TINYINT      DEFAULT 1 COMMENT '状态:1待处理2已成立3不成立',
  report_time    DATETIME     NOT NULL COMMENT '举报时间',
  handle_admin   INT          DEFAULT NULL COMMENT '处理管理员ID',
  handle_time    DATETIME     DEFAULT NULL COMMENT '处理时间',
  handle_opinion VARCHAR(500) DEFAULT NULL COMMENT '处理意见',
  PRIMARY KEY (report_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='举报记录表';

-- -------------------------------------------------------------
-- 13. 处罚表 punishment
-- -------------------------------------------------------------
CREATE TABLE punishment (
  punish_id      INT          NOT NULL AUTO_INCREMENT COMMENT '处罚ID',
  user_id        INT          NOT NULL COMMENT '被处罚用户ID',
  type           TINYINT      NOT NULL COMMENT '类型:1警告2禁言3封禁',
  reason         VARCHAR(255) NOT NULL COMMENT '处罚原因',
  start_time     DATETIME     NOT NULL COMMENT '开始时间',
  end_time       DATETIME     DEFAULT NULL COMMENT '结束时间(永久为NULL)',
  status         TINYINT      DEFAULT 1 COMMENT '状态:1生效中2已解除3已到期',
  admin_id       INT          NOT NULL COMMENT '操作管理员ID',
  appeal_status  TINYINT      DEFAULT 0 COMMENT '申诉状态:0未申诉1待复核2通过3驳回(A组)',
  appeal_reason  VARCHAR(500) DEFAULT NULL COMMENT '申诉理由(A组)',
  appeal_time    DATETIME     DEFAULT NULL COMMENT '申诉提交时间(A组)',
  appeal_result  VARCHAR(255) DEFAULT NULL COMMENT '申诉复核说明(A组)',
  PRIMARY KEY (punish_id),
  KEY idx_user (user_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='处罚记录表';

-- -------------------------------------------------------------
-- 14. 申诉表 appeal
-- -------------------------------------------------------------
CREATE TABLE appeal (
  appeal_id      INT          NOT NULL AUTO_INCREMENT COMMENT '申诉ID',
  punish_id      INT          NOT NULL COMMENT '关联处罚ID',
  user_id        INT          NOT NULL COMMENT '申诉人ID',
  content        VARCHAR(500) NOT NULL COMMENT '申诉说明',
  evidence       VARCHAR(255) DEFAULT NULL COMMENT '佐证材料',
  status         TINYINT      DEFAULT 1 COMMENT '状态:1待复核2维持3减轻4解除',
  appeal_time     DATETIME     NOT NULL COMMENT '申诉时间',
  review_admin    INT          DEFAULT NULL COMMENT '复核管理员ID',
  review_opinion VARCHAR(500) DEFAULT NULL COMMENT '复核意见',
  review_time    DATETIME     DEFAULT NULL COMMENT '复核时间',
  PRIMARY KEY (appeal_id),
  KEY idx_punish (punish_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='处罚申诉表';

-- -------------------------------------------------------------
-- 15. 消息表 message
-- -------------------------------------------------------------
CREATE TABLE message (
  message_id     INT          NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  receiver_id    INT          NOT NULL COMMENT '接收用户ID',
  sender_type    TINYINT      NOT NULL COMMENT '发送者类型:1系统2管理员',
  sender_id      INT          DEFAULT NULL COMMENT '发送管理员ID',
  title          VARCHAR(100) NOT NULL COMMENT '消息标题',
  content        TEXT         NOT NULL COMMENT '消息内容',
  send_time      DATETIME     NOT NULL COMMENT '发送时间',
  is_read        TINYINT      DEFAULT 0 COMMENT '已读:0未读1已读',
  PRIMARY KEY (message_id),
  KEY idx_receiver (receiver_id, is_read)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='站内消息表';

-- -------------------------------------------------------------
-- 16. 退养申请表 foster_return
-- -------------------------------------------------------------
CREATE TABLE foster_return (
  return_id      INT          NOT NULL AUTO_INCREMENT COMMENT '退养ID',
  adopt_id       INT          NOT NULL COMMENT '领养记录ID',
  user_id        INT          NOT NULL COMMENT '领养人ID',
  pet_id         INT          NOT NULL COMMENT '宠物ID',
  reason         VARCHAR(255) NOT NULL COMMENT '退养原因',
  description    VARCHAR(500) DEFAULT NULL COMMENT '现状描述',
  photo          VARCHAR(255) DEFAULT NULL COMMENT '现状照片',
  status         TINYINT      DEFAULT 1 COMMENT '状态:1待审核2同意3拒绝4已回流',
  apply_time     DATETIME     NOT NULL COMMENT '申请时间',
  audit_admin    INT          DEFAULT NULL COMMENT '审核管理员ID',
  audit_opinion  VARCHAR(500) DEFAULT NULL COMMENT '审核意见',
  audit_time     DATETIME     DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (return_id),
  KEY idx_pet (pet_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退养申请表';

-- -------------------------------------------------------------
-- 17. 寻宠启事表 lost_pet
-- -------------------------------------------------------------
CREATE TABLE lost_pet (
  lost_id        INT          NOT NULL AUTO_INCREMENT COMMENT '寻宠ID',
  user_id        INT          NOT NULL COMMENT '发布人ID',
  pet_name       VARCHAR(50)  DEFAULT NULL COMMENT '宠物名',
  species        TINYINT      DEFAULT NULL COMMENT '种类:1猫2狗',
  breed          VARCHAR(50)  DEFAULT NULL COMMENT '品种',
  gender         TINYINT      DEFAULT 0 COMMENT '性别',
  features       VARCHAR(500) DEFAULT NULL COMMENT '身体特征',
  photo          VARCHAR(255) DEFAULT NULL COMMENT '照片',
  lost_time      DATETIME     DEFAULT NULL COMMENT '走失时间',
  lost_location  VARCHAR(255) DEFAULT NULL COMMENT '走失地点',
  contact        VARCHAR(50)  NOT NULL COMMENT '联系方式',
  reward         DECIMAL(10,2) DEFAULT 0 COMMENT '悬赏金额',
  status         TINYINT      DEFAULT 1 COMMENT '状态:1待审核2发布中3已找回4已撤回5已下架',
  publish_time   DATETIME     NOT NULL COMMENT '发布时间',
  PRIMARY KEY (lost_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='寻宠启事表';

-- -------------------------------------------------------------
-- 18. 问题反馈表 problem_feedback
-- -------------------------------------------------------------
CREATE TABLE problem_feedback (
  feedback_id    INT          NOT NULL AUTO_INCREMENT COMMENT '反馈ID',
  user_id        INT          DEFAULT NULL COMMENT '反馈人ID(游客可空)',
  type           TINYINT      NOT NULL COMMENT '类型:1聚集2伤人风险3噪音4粪便污染5其他',
  location       VARCHAR(255) NOT NULL COMMENT '位置描述',
  description    VARCHAR(1000) NOT NULL COMMENT '问题描述',
  photo          VARCHAR(255) DEFAULT NULL COMMENT '现场照片',
  contact        VARCHAR(50)  DEFAULT NULL COMMENT '联系方式',
  status         TINYINT      DEFAULT 1 COMMENT '状态:1待处理2处理中3已完成',
  feedback_time  DATETIME     NOT NULL COMMENT '反馈时间',
  handle_admin   INT          DEFAULT NULL COMMENT '处理管理员ID',
  handle_opinion VARCHAR(500) DEFAULT NULL COMMENT '处理结果',
  handle_time    DATETIME     DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (feedback_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流浪动物问题反馈表';

-- -------------------------------------------------------------
-- 19. 知识分类表 knowledge_category
-- -------------------------------------------------------------
CREATE TABLE knowledge_category (
  cat_id        INT          NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  cat_name      VARCHAR(50)  NOT NULL COMMENT '分类名称',
  icon          VARCHAR(100) DEFAULT NULL COMMENT '分类图标',
  sort_order    INT          DEFAULT 0 COMMENT '排序',
  status        TINYINT      DEFAULT 1 COMMENT '状态:1启用0停用',
  PRIMARY KEY (cat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='知识分类表';

-- -------------------------------------------------------------
-- 20. 知识文章表 knowledge
-- -------------------------------------------------------------
CREATE TABLE knowledge (
  know_id       INT          NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  cat_id        INT          NOT NULL COMMENT '分类ID',
  title         VARCHAR(100) NOT NULL COMMENT '标题',
  content       TEXT         NOT NULL COMMENT '正文',
  cover         VARCHAR(255) DEFAULT NULL COMMENT '配图',
  view_count    INT          DEFAULT 0 COMMENT '浏览次数',
  sort_order    INT          DEFAULT 0 COMMENT '排序权重',
  status        TINYINT      DEFAULT 1 COMMENT '状态:1草稿2已发布3已下架',
  author_id     INT          DEFAULT NULL COMMENT '发布管理员ID',
  create_time   DATETIME     NOT NULL COMMENT '创建时间',
  update_time   DATETIME     NOT NULL COMMENT '更新时间',
  PRIMARY KEY (know_id),
  KEY idx_cat (cat_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='科普知识文章表';

-- -------------------------------------------------------------
-- 21. 志愿者认证表 volunteer_cert
-- -------------------------------------------------------------
CREATE TABLE volunteer_cert (
  cert_id       INT          NOT NULL AUTO_INCREMENT COMMENT '认证ID',
  user_id        INT          NOT NULL COMMENT '用户ID',
  real_name      VARCHAR(20)  NOT NULL COMMENT '真实姓名',
  id_card        VARCHAR(20)  NOT NULL COMMENT '身份证号',
  phone          VARCHAR(11)  NOT NULL COMMENT '联系电话',
  emergency_contact VARCHAR(20) DEFAULT NULL COMMENT '紧急联系人',
  service_area   VARCHAR(100) DEFAULT NULL COMMENT '可服务区域',
  skill_tags     VARCHAR(100) DEFAULT NULL COMMENT '技能标签',
  status         TINYINT      DEFAULT 1 COMMENT '状态:1待认证2已认证3已驳回4已撤销',
  apply_time     DATETIME     NOT NULL COMMENT '申请时间',
  expire_time    DATE         DEFAULT NULL COMMENT '认证到期日',
  audit_admin    INT          DEFAULT NULL COMMENT '审核管理员ID',
  audit_opinion  VARCHAR(255) DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (cert_id),
  UNIQUE KEY uk_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='志愿者认证表';

-- -------------------------------------------------------------
-- 22. 团队认证表 team_cert
-- -------------------------------------------------------------
CREATE TABLE team_cert (
  team_id       INT          NOT NULL AUTO_INCREMENT COMMENT '团队ID',
  leader_id     INT          NOT NULL COMMENT '负责人用户ID',
  team_name     VARCHAR(100) NOT NULL COMMENT '机构名称',
  credit_code   VARCHAR(50)  DEFAULT NULL COMMENT '统一社会信用代码',
  leader_name   VARCHAR(20)  NOT NULL COMMENT '负责人姓名',
  description   VARCHAR(1000) DEFAULT NULL COMMENT '机构简介',
  service_scope  VARCHAR(255) DEFAULT NULL COMMENT '服务范围',
  status         TINYINT      DEFAULT 1 COMMENT '状态:1待认证2已认证3已驳回4已撤销',
  apply_time     DATETIME     NOT NULL COMMENT '申请时间',
  audit_admin    INT          DEFAULT NULL COMMENT '审核管理员ID',
  PRIMARY KEY (team_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='团队认证表';

-- -------------------------------------------------------------
-- 23. 宠物状态变更日志表 pet_status_log
-- -------------------------------------------------------------
CREATE TABLE pet_status_log (
  log_id        INT          NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  pet_id        INT          NOT NULL COMMENT '宠物ID',
  from_status   TINYINT      NOT NULL COMMENT '原状态',
  to_status     TINYINT      NOT NULL COMMENT '新状态',
  reason        VARCHAR(255) DEFAULT NULL COMMENT '变更原因',
  operator_id   INT          DEFAULT NULL COMMENT '操作人ID(管理员/用户)',
  operator_type TINYINT      DEFAULT 1 COMMENT '操作人类型:1管理员2领养用户',
  create_time   DATETIME     NOT NULL COMMENT '变更时间',
  PRIMARY KEY (log_id),
  KEY idx_pet (pet_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='宠物状态变更日志表';

-- -------------------------------------------------------------
-- 24. 操作日志表 operation_log
-- -------------------------------------------------------------
CREATE TABLE operation_log (
  log_id        INT          NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  admin_id      INT          NOT NULL COMMENT '操作管理员ID',
  module        VARCHAR(50)  NOT NULL COMMENT '操作模块',
  action        VARCHAR(100) NOT NULL COMMENT '操作内容',
  ip            VARCHAR(50)  DEFAULT NULL COMMENT '操作IP',
  log_time      DATETIME     NOT NULL COMMENT '操作时间',
  PRIMARY KEY (log_id),
  KEY idx_admin (admin_id),
  KEY idx_time (log_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员操作日志表';

-- =============================================================
-- 初始化数据
-- =============================================================

-- 默认 root 管理员 (密码: admin123 的 MD5 = 0192023a7bbd73250516f069df18b500)
INSERT INTO user (username, password, nickname, role, status, register_time)
VALUES ('admin', '0192023a7bbd73250516f069df18b500', '超级管理员', 9, 1, NOW());

-- 普通管理员 (密码: 123456 的 MD5 = e10adc3949ba59abbe56e057f20f883e)
INSERT INTO user (username, password, nickname, role, status, register_time)
VALUES ('manager', 'e10adc3949ba59abbe56e057f20f883e', '平台管理员', 3, 1, NOW());

-- 测试普通用户 (密码: 123456)
INSERT INTO user (username, password, nickname, role, status, register_time)
VALUES ('testuser', 'e10adc3949ba59abbe56e057f20f883e', '测试用户', 1, 1, NOW());

-- 知识分类
INSERT INTO knowledge_category (cat_name, sort_order) VALUES
('健康关怀', 1), ('美容护理', 2), ('喂养食物', 3), ('行为心理', 4);

-- 示例宠物
INSERT INTO pet (pet_no, pet_name, species, breed, gender, age_stage, description, adopt_status, is_neutered, is_vaccinated, health_status, create_time, update_time)
VALUES
('PET-2026-001', '橘座', 1, '中华田园猫', 1, 2, '亲人粘人，已断奶，会用猫砂', 2, 1, 1, '健康，已驱虫', NOW(), NOW()),
('PET-2026-002', '旺财', 2, '柯基', 1, 1, '活泼好动，适合有院子的家庭', 2, 0, 1, '健康', NOW(), NOW()),
('PET-2026-003', '奶糖', 1, '加菲猫', 2, 3, '安静温顺，年纪较大', 5, 1, 1, '轻微牙结石', NOW(), NOW());
