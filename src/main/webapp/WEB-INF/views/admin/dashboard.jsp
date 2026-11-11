<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>后台管理 - 流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">救助系统后台</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="${pageContext.request.contextPath}/">返回前台</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">退出</a></li>
        </ul>
    </div>
</nav>

<div class="container-fluid" style="margin-top:20px;">
    <div class="row">
        <div class="col-sm-2">
            <ul class="list-group">
                <li class="list-group-item active">数据看板</li>
                <li class="list-group-item"><a href="#">宠物管理</a></li>
                <li class="list-group-item"><a href="#">领养审核</a></li>
                <li class="list-group-item"><a href="#">用户管理</a></li>
                <li class="list-group-item"><a href="#">求助管理</a></li>
                <li class="list-group-item"><a href="#">评论管理</a></li>
                <li class="list-group-item"><a href="#">活动管理</a></li>
                <li class="list-group-item"><a href="#">物资管理</a></li>
                <li class="list-group-item"><a href="#">处罚管理</a></li>
            </ul>
        </div>
        <div class="col-sm-10">
            <div class="jumbotron">
                <h2>欢迎，${sessionScope.loginUser.nickname}</h2>
                <p>SSM 骨架已跑通，接下来逐个模块开发。</p>
            </div>
            <div class="row">
                <div class="col-sm-3">
                    <div class="panel panel-primary">
                        <div class="panel-heading"><h4>在库宠物</h4></div>
                        <div class="panel-body" style="font-size:28px; text-align:center;">--</div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="panel panel-success">
                        <div class="panel-heading"><h4>累计领养</h4></div>
                        <div class="panel-body" style="font-size:28px; text-align:center;">--</div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="panel panel-info">
                        <div class="panel-heading"><h4>注册用户</h4></div>
                        <div class="panel-body" style="font-size:28px; text-align:center;">--</div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="panel panel-warning">
                        <div class="panel-heading"><h4>待审核</h4></div>
                        <div class="panel-body" style="font-size:28px; text-align:center;">--</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
