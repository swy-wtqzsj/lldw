<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的求助</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/">流浪猫狗救助系统</a>
    </div>
</nav>

<div class="container mt-4">
    <h3>我的求助</h3>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>标题</th>
                <th>类型</th>
                <th>审核状态</th>
                <th>处理状态</th>
                <th>发布时间</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.title}</td>
                    <td>${item.typeText}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.auditStatus == 1}">
                                <span class="badge bg-warning">待审核</span>
                            </c:when>
                            <c:when test="${item.auditStatus == 2}">
                                <span class="badge bg-success">已通过</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">已拒绝</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.handleStatusText}</td>
                    <td>${item.publishTime}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="5" class="text-center text-muted">暂无求助记录</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
