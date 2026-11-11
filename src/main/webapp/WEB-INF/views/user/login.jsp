<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>登录 - 流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding-top: 80px; }
        .login-box { max-width: 400px; margin: 0 auto; background: #fff; border-radius: 10px; padding: 40px; box-shadow: 0 10px 40px rgba(0,0,0,.2); }
        .login-box h2 { text-align: center; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        .btn-login { width: 100%; }
    </style>
</head>
<body>
<div class="container">
    <div class="login-box">
        <h2>流浪猫狗救助系统</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <input type="text" name="username" class="form-control input-lg" placeholder="用户名" required value="${username}">
            </div>
            <div class="form-group">
                <input type="password" name="password" class="form-control input-lg" placeholder="密码" required>
            </div>
            <button type="submit" class="btn btn-primary btn-lg btn-login">登 录</button>
        </form>
        <div style="text-align:center; margin-top:20px;">
            还没有账号？<a href="${pageContext.request.contextPath}/register">立即注册</a>
        </div>
    </div>
</div>
</body>
</html>
