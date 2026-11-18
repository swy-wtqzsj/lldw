<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>提交举报 - 流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="${pageContext.request.contextPath}/report/my">我的举报</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">退出</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h2>提交举报</h2>
            <p class="text-muted">举报虚假信息或违规内容，管理员会尽快处理。</p>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form action="${pageContext.request.contextPath}/report/submit" method="post">
                        <div class="form-group">
                            <label>举报对象类型</label>
                            <select name="targetType" class="form-control" id="targetType">
                                <option value="1" ${targetType == 1 ? 'selected' : ''}>用户</option>
                                <option value="2" ${targetType == 2 ? 'selected' : ''}>宠物</option>
                                <option value="3" ${targetType == 3 ? 'selected' : ''}>求助</option>
                                <option value="4" ${targetType == 4 ? 'selected' : ''}>评论</option>
                                <option value="5" ${targetType == 5 ? 'selected' : ''}>活动</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>对象ID</label>
                            <input type="number" name="targetId" class="form-control" value="${targetId}" placeholder="如用户ID、宠物ID" required>
                            <p class="help-block">可从对应详情页的地址栏或编号获取</p>
                        </div>
                        <div class="form-group">
                            <label>举报原因</label>
                            <input type="text" name="reason" class="form-control" placeholder="如：虚假信息、违规内容" required>
                        </div>
                        <div class="form-group">
                            <label>详细描述</label>
                            <textarea name="description" class="form-control" rows="4"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">提交举报</button>
                        <a href="${pageContext.request.contextPath}/report/my" class="btn btn-default">查看我的举报</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
