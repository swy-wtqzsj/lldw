<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>后台管理 - 流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: #fef9f5;
            margin: 0;
        }
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            width: 250px;
            background: linear-gradient(180deg, #b08968 0%, #9c7a5b 100%);
            color: #fff;
            z-index: 100;
            overflow-y: auto;
        }
        .sidebar .brand {
            padding: 20px 15px;
            font-size: 18px;
            font-weight: bold;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }
        .sidebar .nav-item {
            padding: 12px 20px;
            color: rgba(255,255,255,0.8);
            display: block;
            text-decoration: none;
            transition: all 0.3s;
        }
        .sidebar .nav-item:hover, .sidebar .nav-item.active {
            color: #fff;
            background: rgba(255,255,255,0.15);
            border-left: 3px solid #ffb07c;
        }
        .sidebar .nav-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        .main {
            margin-left: 250px;
            padding: 20px;
        }
        .topbar {
            background: #fff;
            padding: 15px 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(176, 137, 104, 0.1);
            margin-bottom: 20px;
        }
        .stat-card {
            background: #fff;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(176, 137, 104, 0.1);
            margin-bottom: 20px;
        }
        .stat-card .icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: #fff;
            float: left;
            margin-right: 15px;
        }
        .stat-card .info h3 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
            color: #6b4e3d;
        }
        .stat-card .info p {
            margin: 0;
            color: #b0a090;
            font-size: 14px;
        }
        .bg-warm1 { background: #f4a261; }
        .bg-warm2 { background: #e9c46a; }
        .bg-warm3 { background: #e76f51; }
        .bg-warm4 { background: #b08968; }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>

<!-- 左侧菜单 -->
<div class="sidebar">
    <div class="brand">
        <i class="fa fa-paw"></i> 救助系统后台
    </div>
    <a class="nav-item active" href="${pageContext.request.contextPath}/admin/dashboard">
        <i class="fa fa-dashboard"></i> 数据看板
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/pet/list">
        <i class="fa fa-paw"></i> 宠物管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/pet/adoption_list">
        <i class="fa fa-check-square"></i> 领养审核
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/user/list">
        <i class="fa fa-users"></i> 用户管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/user/admins">
        <i class="fa fa-user-cog"></i> 管理员管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/volunteer/list">
        <i class="fa fa-heart"></i> 志愿审核
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/pet/revisit_list">
        <i class="fa fa-heart"></i> 回访管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/pet/return_list">
        <i class="fa fa-reply"></i> 退养管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/help/list">
        <i class="fa fa-bell"></i> 求助管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/help/comments">
        <i class="fa fa-comments"></i> 评论管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/activity/list">
        <i class="fa fa-calendar"></i> 活动管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/knowledge/list">
        <i class="fa fa-book"></i> 知识管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/material/list">
        <i class="fa fa-cubes"></i> 物资管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/punishment/list">
        <i class="fa fa-gavel"></i> 处罚管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/report/list">
        <i class="fa fa-flag"></i> 举报管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/cert/list">
        <i class="fa fa-id-card"></i> 证书管理
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/help-response/list">
        <i class="fa fa-handshake-o"></i> 求助响应
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/lost/list">
        <i class="fa fa-search"></i> 寻宠启事
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/admin/appeal/list">
        <i class="fa fa-balance-scale"></i> 处罚申诉
    </a>
    <hr style="border-color: rgba(255,255,255,0.1); margin: 15px;">
    <a class="nav-item" href="${pageContext.request.contextPath}/">
        <i class="fa fa-home"></i> 返回前台
    </a>
    <a class="nav-item" href="${pageContext.request.contextPath}/logout">
        <i class="fa fa-sign-out"></i> 退出登录
    </a>
</div>

<!-- 主内容区 -->
<div class="main">
    <div class="topbar">
        <h4 class="mb-0">数据看板</h4>
    </div>

    <div class="row">
        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon bg-warm1">
                    <i class="fa fa-paw"></i>
                </div>
                <div class="info">
                    <h3>${stats.pet_total}</h3>
                    <p>在库宠物</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon bg-warm2">
                    <i class="fa fa-check"></i>
                </div>
                <div class="info">
                    <h3>${stats.adopted_total}</h3>
                    <p>已领养</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon bg-warm3">
                    <i class="fa fa-clock-o"></i>
                </div>
                <div class="info">
                    <h3>${stats.adoption_pending}</h3>
                    <p>待审核领养</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon bg-warm4">
                    <i class="fa fa-users"></i>
                </div>
                <div class="info">
                    <h3>${stats.user_total}</h3>
                    <p>注册用户</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="stat-card">
                <h5>内容概览</h5>
                <hr>
                <p class="text-muted mb-1">志愿活动：${stats.activity_total} 个</p>
                <p class="text-muted mb-0">知识文章：${stats.knowledge_total} 篇</p>
                <hr>
                <p class="text-muted mb-1">物资种类：${stats.material_total} 种</p>
                <p class="text-muted mb-0">
                    库存预警：
                    <span class="${stats.material_low > 0 ? 'text-danger' : 'text-muted'}">${stats.material_low} 种</span>
                </p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="stat-card">
                <h5>待办事项</h5>
                <hr>
                <p class="text-muted mb-1">待审核领养：${stats.adoption_pending} 条</p>
                <p class="text-muted mb-1">待审核求助：${stats.help_pending} 条</p>
                <p class="text-muted mb-1">待审核退养：${stats.return_pending} 条</p>
                <p class="text-muted mb-1">待处理举报：${stats.report_pending} 条</p>
                <p class="text-muted mb-1">待认证证书：${stats.cert_pending} 条</p>
                <p class="text-muted mb-1">待审核寻宠：${stats.lost_pending} 条</p>
                <p class="text-muted mb-0">待复核申诉：${stats.appeal_pending} 条</p>
            </div>
        </div>
    </div>
</div>

</body>
</html>
