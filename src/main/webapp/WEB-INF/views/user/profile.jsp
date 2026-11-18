<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>个人中心 - 流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="${pageContext.request.contextPath}/message/list">消息中心</a></li>
            <li><a href="${pageContext.request.contextPath}/profile">个人中心</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">退出</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">个人信息</h3>
                </div>
                <div class="panel-body">
                    <c:if test="${not empty msg}">
                        <div class="alert alert-success">${msg}</div>
                    </c:if>
                    <form action="${pageContext.request.contextPath}/profile/update" method="post" class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">用户名</label>
                            <div class="col-sm-6">
                                <p class="form-control-static">${user.username}</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">昵称</label>
                            <div class="col-sm-6">
                                <input type="text" name="nickname" class="form-control" value="${user.nickname}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">手机号</label>
                            <div class="col-sm-6">
                                <input type="text" name="phone" class="form-control" value="${user.phone}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">邮箱</label>
                            <div class="col-sm-6">
                                <input type="email" name="email" class="form-control" value="${user.email}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">住址</label>
                            <div class="col-sm-6">
                                <input type="text" name="address" class="form-control" value="${user.address}">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-6">
                                <button type="submit" class="btn btn-primary">保存修改</button>
                                <a href="${pageContext.request.contextPath}/password" class="btn btn-default">修改密码</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <%-- A组：账号相关功能入口 --%>
            <div class="panel panel-default">
                <div class="panel-heading"><h3 class="panel-title">账号安全与服务</h3></div>
                <div class="panel-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/forgot" class="btn btn-default">找回密码</a>
                    <a href="${pageContext.request.contextPath}/volunteer/apply" class="btn btn-default">志愿者认证</a>
                    <a href="${pageContext.request.contextPath}/punishment/my" class="btn btn-default">处罚查询与申诉</a>
                    <a href="${pageContext.request.contextPath}/message/list" class="btn btn-default">我的消息</a>
                    <button class="btn btn-danger pull-right" data-toggle="modal" data-target="#cancelModal">注销账号</button>
                </div>
            </div>

            <%-- 注销账号弹窗 --%>
            <div class="modal fade" id="cancelModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/profile/cancel" method="post">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title" style="color:red;">注销账号</h4>
                            </div>
                            <div class="modal-body">
                                <div class="alert alert-warning">注销后账号将被禁用并永久失去领养资格，此操作不可撤销！</div>
                                <div class="form-group">
                                    <label>请输入密码确认身份</label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                <button type="submit" class="btn btn-danger">确认注销</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>
