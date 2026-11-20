-- ============================================================
-- 流浪猫狗救助系统 数据库脚本
-- 数据库: pet_adoption   MySQL 5.7+ / 8.0
-- 说明:
--   1) 本脚本包含框架全部基础表 + A组(用户/志愿者/举报处罚)新增表
--   2) A组新增/扩展的表: user(扩展字段)、volunteer、report_record、
--      punishment(含申诉字段)、message
--   3) 重复执行会先 DROP 旧表，请在空库或有备份时执行
-- ============================================================

DROP DATABASE IF EXISTS pet_adoption;
CREATE DATABASE pet_adoption DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE pet_adoption;

-- ----------------------------
-- 1. 用户信息表 (A组 - 扩展)
-- ----------------------------
DROP TABLE IF EXISTS user;
CREATE TABLE user (
    user_id       INT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID',
    username      VARCHAR(20)  NOT NULL UNIQUE COMMENT '用户名/登录账号',
    password      VARCHAR(32)  NOT NULL COMMENT '密码(MD5)',
    phone         VARCHAR(11)  COMMENT '手机号',
    email         VARCHAR(50)  COMMENT '邮箱',
    nickname      VARCHAR(20)  COMMENT '昵称',
    avatar        VARCHAR(255) COMMENT '头像路径',
    gender        TINYINT      DEFAULT 0 COMMENT '性别:0未知1男2女',
    birthday      DATE         COMMENT '生日',
    address       VARCHAR(50)  COMMENT '住址',
    role          TINYINT      DEFAULT 1 COMMENT '角色:1普通用户 2志愿者 3管理员 9root',
    status        TINYINT      DEFAULT 1 COMMENT '状态:1正常 0禁用',
    adopt_status  TINYINT      DEFAULT 1 COMMENT '领养资格:1正常 2暂停 3永久禁止',
    credit_score  INT          DEFAULT 100 COMMENT '信用分',
    real_name     VARCHAR(20)  COMMENT '真实姓名(实名认证)',
    id_card       VARCHAR(18)  COMMENT '身份证号(实名认证)',
    register_time DATETIME     NOT NULL COMMENT '注册时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ----------------------------
-- 2. 志愿者认证表 (A组 - 新增)
--    对应 PET-1.11 / PET-2.9 / 6.3.7
-- ----------------------------
DROP TABLE IF EXISTS volunteer;
CREATE TABLE volunteer (
    volunteer_id  INT AUTO_INCREMENT PRIMARY KEY COMMENT '志愿者记录ID',
    user_id       INT NOT NULL COMMENT '申请用户ID',
    real_name     VARCHAR(20)  NOT NULL COMMENT '真实姓名',
    id_card       VARCHAR(18)  NOT NULL COMMENT '身份证号',
    phone         VARCHAR(11)  COMMENT '联系电话',
    org_name      VARCHAR(100) COMMENT '团队/机构名称(团队认证时填)',
    cert_type     TINYINT      DEFAULT 1 COMMENT '认证类型:1个人实名 2团队/机构',
    cert_file     VARCHAR(255) COMMENT '资质证明材料路径',
    intro         VARCHAR(500) COMMENT '个人/团队简介',
    work_hours    INT          DEFAULT 0 COMMENT '累计服务工时',
    points        INT          DEFAULT 0 COMMENT '积分',
    level         INT          DEFAULT 1 COMMENT '等级',
    audit_status  TINYINT      DEFAULT 1 COMMENT '审核状态:1待审核 2已通过 3已拒绝',
    audit_opinion VARCHAR(255) COMMENT '审核意见',
    audit_admin_id INT         COMMENT '审核管理员ID',
    apply_time    DATETIME     NOT NULL COMMENT '申请时间',
    audit_time    DATETIME     COMMENT '审核时间',
    KEY idx_user_id (user_id),
    KEY idx_audit_status (audit_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='志愿者认证表';

-- ----------------------------
-- 3. 举报记录表 (A组 - 新增)
--    对应 PET-1.9 / PET-2.11 / 6.3.9
-- ----------------------------
DROP TABLE IF EXISTS report_record;
CREATE TABLE report_record (
    report_id     INT AUTO_INCREMENT PRIMARY KEY COMMENT '举报ID',
    reporter_id   INT NOT NULL COMMENT '举报人ID',
    target_type   TINYINT      NOT NULL COMMENT '举报对象类型:1用户 2宠物 3求助 4评论 5活动',
    target_id     INT          NOT NULL COMMENT '被举报对象ID',
    reason        VARCHAR(255) NOT NULL COMMENT '举报原因',
    description   VARCHAR(500) COMMENT '详细描述',
    evidence      VARCHAR(255) COMMENT '证据图片路径',
    status        TINYINT      DEFAULT 1 COMMENT '处理状态:1待处理 2已处理 3已驳回',
    handle_result VARCHAR(255) COMMENT '处理结果说明',
    admin_id      INT          COMMENT '处理管理员ID',
    report_time   DATETIME     NOT NULL COMMENT '举报时间',
    handle_time   DATETIME     COMMENT '处理时间',
    KEY idx_reporter (reporter_id),
    KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='举报记录表';

-- ----------------------------
-- 4. 处罚记录表 (A组 - 含申诉字段)
--    对应 PET-1.15 / PET-2.12 / 7.1.6
-- ----------------------------
DROP TABLE IF EXISTS punishment;
CREATE TABLE punishment (
    punish_id      INT AUTO_INCREMENT PRIMARY KEY COMMENT '处罚ID',
    user_id        INT NOT NULL COMMENT '被处罚用户ID',
    type           TINYINT NOT NULL COMMENT '类型:1警告 2禁言 3封禁',
    reason         VARCHAR(255) NOT NULL COMMENT '处罚原因',
    start_time     DATETIME NOT NULL COMMENT '开始时间',
    end_time       DATETIME COMMENT '结束时间(永久封禁为空)',
    status         TINYINT DEFAULT 1 COMMENT '状态:1生效中 2已解除 3已到期',
    admin_id       INT COMMENT '操作管理员ID',
    -- 申诉相关(A组扩展)
    appeal_status  TINYINT DEFAULT 0 COMMENT '申诉状态:0未申诉 1待复核 2申诉通过 3申诉驳回',
    appeal_reason  VARCHAR(500) COMMENT '申诉理由',
    appeal_time    DATETIME COMMENT '申诉提交时间',
    appeal_result  VARCHAR(255) COMMENT '申诉复核说明',
    KEY idx_user_id (user_id),
    KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='处罚记录表';

-- ----------------------------
-- 5. 消息表 (A组 - PET-1.14 消息中心)
-- ----------------------------
DROP TABLE IF EXISTS message;
CREATE TABLE message (
    message_id   INT AUTO_INCREMENT PRIMARY KEY COMMENT '消息ID',
    receiver_id  INT NOT NULL COMMENT '接收用户ID',
    sender_type  TINYINT NOT NULL COMMENT '发送者类型:1系统 2管理员',
    sender_id    INT COMMENT '发送者ID(管理员)',
    title        VARCHAR(100) NOT NULL COMMENT '消息标题',
    content      TEXT NOT NULL COMMENT '消息内容',
    send_time    DATETIME NOT NULL COMMENT '发送时间',
    is_read      TINYINT DEFAULT 0 COMMENT '已读:0未读 1已读',
    KEY idx_receiver (receiver_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='消息表';

-- ----------------------------
-- 6. 宠物信息表
-- ----------------------------
DROP TABLE IF EXISTS pet;
CREATE TABLE pet (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    pet_no VARCHAR(20) UNIQUE,
    pet_name VARCHAR(50) NOT NULL,
    species TINYINT NOT NULL COMMENT '1猫2狗',
    breed VARCHAR(50),
    gender TINYINT DEFAULT 0,
    age_stage TINYINT,
    birthday DATE,
    photo VARCHAR(255),
    photos VARCHAR(1024),
    description TEXT,
    adopt_status TINYINT DEFAULT 2,
    is_neutered TINYINT DEFAULT 0,
    is_vaccinated TINYINT DEFAULT 0,
    health_status VARCHAR(1024),
    create_time DATETIME NOT NULL,
    update_time DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='宠物信息表';

-- ----------------------------
-- 7. 领养申请表
-- ----------------------------
DROP TABLE IF EXISTS adoption;
CREATE TABLE adoption (
    adopt_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    pet_id INT NOT NULL,
    adopter_name VARCHAR(20),
    phone VARCHAR(11),
    economic_status VARCHAR(50),
    reason VARCHAR(500),
    status TINYINT DEFAULT 1 COMMENT '1待审核2同意3不同意',
    apply_time DATETIME NOT NULL,
    audit_opinion VARCHAR(255),
    audit_admin_id INT,
    audit_time DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领养申请表';

-- ----------------------------
-- 8. 求助信息表
-- ----------------------------
DROP TABLE IF EXISTS help_request;
CREATE TABLE help_request (
    help_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    type TINYINT DEFAULT 1,
    content TEXT,
    location VARCHAR(128),
    contact VARCHAR(50),
    photo VARCHAR(255),
    publish_time DATETIME NOT NULL,
    audit_status TINYINT DEFAULT 1 COMMENT '1待审核2已通过3已拒绝',
    handle_status TINYINT DEFAULT 1 COMMENT '1待响应2已响应3处理中4已完成5已关闭',
    audit_opinion VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='求助信息表';

-- ----------------------------
-- 9. 评论表
-- ----------------------------
DROP TABLE IF EXISTS comment;
CREATE TABLE comment (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    target_type TINYINT DEFAULT 1 COMMENT '1宠物2活动3知识4求助',
    target_id INT NOT NULL,
    content VARCHAR(500) NOT NULL,
    comment_time DATETIME NOT NULL,
    status TINYINT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评论表';

-- ----------------------------
-- 10. 活动表 + 报名表
-- ----------------------------
DROP TABLE IF EXISTS activity;
CREATE TABLE activity (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content TEXT,
    start_time DATETIME,
    end_time DATETIME,
    location VARCHAR(128),
    max_people INT DEFAULT 0,
    cover_image VARCHAR(255),
    status TINYINT DEFAULT 2 COMMENT '1草稿2发布中3已结束',
    create_time DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动表';

DROP TABLE IF EXISTS activity_signup;
CREATE TABLE activity_signup (
    signup_id INT AUTO_INCREMENT PRIMARY KEY,
    activity_id INT NOT NULL,
    user_id INT NOT NULL,
    signup_time DATETIME NOT NULL,
    checkin_time DATETIME,
    checkout_time DATETIME,
    status TINYINT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动报名表';

-- ----------------------------
-- 11. 知识分类 + 知识文章
-- ----------------------------
DROP TABLE IF EXISTS knowledge_category;
CREATE TABLE knowledge_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    icon VARCHAR(100),
    sort_order INT DEFAULT 0,
    status TINYINT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='知识分类表';

DROP TABLE IF EXISTS knowledge;
CREATE TABLE knowledge (
    article_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    content TEXT,
    cover_image VARCHAR(255),
    status TINYINT DEFAULT 2,
    view_count INT DEFAULT 0,
    publish_time DATETIME,
    update_time DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='知识文章表';

-- ============================================================
-- 测试数据
-- ============================================================
-- 密码均为 123456 的 MD5: e10adc3949ba59abbe56e057f20f883e
INSERT INTO user (username, password, nickname, role, status, adopt_status, credit_score, real_name, register_time) VALUES
('admin',    'e10adc3949ba59abbe56e057f20f883e', '管理员',   3, 1, 1, 100, '系统管理员', NOW()),
('root',     'e10adc3949ba59abbe56e057f20f883e', '超级管理员', 9, 1, 1, 100, '超级管理员', NOW()),
('testuser', 'e10adc3949ba59abbe56e057f20f883e', '测试用户',  1, 1, 1, 100, NULL, NOW()),
('volunteer1','e10adc3949ba59abbe56e057f20f883e','爱心志愿者', 2, 1, 1, 120, '张三', NOW());

-- 志愿者认证示例
INSERT INTO volunteer (user_id, real_name, id_card, phone, cert_type, intro, work_hours, points, audit_status, apply_time) VALUES
(4, '张三', '110101199001011234', '13800138000', 1, '热爱动物，有多年救助经验', 48, 120, 2, NOW());

-- 消息示例
INSERT INTO message (receiver_id, sender_type, title, content, send_time, is_read) VALUES
(3, 1, '欢迎注册', '欢迎加入流浪猫狗救助系统！', NOW(), 0);

-- 处罚示例(已解除，便于演示状态)
INSERT INTO punishment (user_id, type, reason, start_time, end_time, status, admin_id, appeal_status) VALUES
(3, 1, '评论不当言论', NOW(), NULL, 2, 1, 0);
