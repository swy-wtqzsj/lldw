<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>注册 - 流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f5f5f5; padding-top: 50px; }
        .register-box { max-width: 450px; margin: 0 auto; background: #fff; border-radius: 8px; padding: 40px; box-shadow: 0 2px 10px rgba(0,0,0,.1); }
        .register-box h2 { text-align: center; margin-bottom: 30px; }
    </style>
</head>
<body>
<div class="container">
    <div class="register-box">
        <h2>用户注册</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <input type="text" name="username" class="form-control" placeholder="用户名（4-20位）" required value="${username}">
            </div>
            <div class="form-group">
                <input type="password" name="password" class="form-control" placeholder="密码（6-20位，含字母和数字）" required>
            </div>
            <div class="form-group">
                <input type="password" name="confirmPassword" class="form-control" placeholder="确认密码" required>
            </div>
            <div class="form-group">
                <input type="text" name="phone" class="form-control" placeholder="手机号（选填）" value="${phone}">
            </div>
            <button type="submit" class="btn btn-success btn-lg btn-block">注 册</button>
        </form>
        <div style="text-align:center; margin-top:15px;">
            已有账号？<a href="${pageContext.request.contextPath}/login">返回登录</a>
        </div>
    </div>
</div>
</body>
</html>
