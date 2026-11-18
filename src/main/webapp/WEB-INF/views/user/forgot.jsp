<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>找回密码 - 流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="${pageContext.request.contextPath}/login">登录</a></li>
            <li><a href="${pageContext.request.contextPath}/register">注册</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="panel panel-default" style="margin-top:40px;">
                <div class="panel-heading"><h3 class="panel-title">找回密码</h3></div>
                <div class="panel-body">
                    <p class="text-muted">请输入注册时使用的用户名和绑定邮箱，验证通过后重置密码。</p>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <form action="${pageContext.request.contextPath}/forgot/reset" method="post">
                        <div class="form-group">
                            <label>用户名</label>
                            <input type="text" name="username" class="form-control" value="${username}" required>
                        </div>
                        <div class="form-group">
                            <label>绑定邮箱</label>
                            <input type="email" name="email" class="form-control" value="${email}" required>
                        </div>
                        <div class="form-group">
                            <label>新密码</label>
                            <input type="password" name="newPassword" class="form-control" placeholder="6-20位，含字母和数字" required>
                        </div>
                        <div class="form-group">
                            <label>确认新密码</label>
                            <input type="password" name="confirmPassword" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">重置密码</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
