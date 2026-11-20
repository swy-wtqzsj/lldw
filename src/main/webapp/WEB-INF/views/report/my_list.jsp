<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>我的举报 - 流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="${pageContext.request.contextPath}/report/submit">提交举报</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">退出</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <h2>我的举报记录</h2>
    <c:choose>
        <c:when test="${empty reports}">
            <div class="alert alert-info">您还没有提交过举报。</div>
        </c:when>
        <c:otherwise>
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>举报对象</th>
                    <th>原因</th>
                    <th>状态</th>
                    <th>提交时间</th>
                    <th>处理结果</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="r" items="${reports}">
                    <tr>
                        <td>${r.reportId}</td>
                        <td>${r.targetTypeName} (ID:${r.targetId})</td>
                        <td>${r.reason}</td>
                        <td>
                            <c:choose>
                                <c:when test="${r.status == 1}"><span class="label label-warning">待处理</span></c:when>
                                <c:when test="${r.status == 2}"><span class="label label-success">已处理</span></c:when>
                                <c:otherwise><span class="label label-default">已驳回</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>${r.reportTime}</td>
                        <td>${r.handleResult}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
