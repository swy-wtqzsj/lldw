<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>处罚查看与申诉 - 流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="${pageContext.request.contextPath}/logout">退出</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <h2>账号处罚状态</h2>
    <p class="text-muted">如对处罚有异议，可在下方提交申诉，管理员会进行复核。</p>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${empty punishments}">
            <div class="alert alert-success">您的账号目前没有任何处罚记录，请继续保持良好的使用行为。</div>
        </c:when>
        <c:otherwise>
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>处罚类型</th>
                    <th>原因</th>
                    <th>状态</th>
                    <th>开始时间</th>
                    <th>申诉状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${punishments}">
                    <tr>
                        <td>${p.punishId}</td>
                        <td><span class="label label-danger">${p.typeName}</span></td>
                        <td>${p.reason}</td>
                        <td>${p.statusName}</td>
                        <td>${p.startTime}</td>
                        <td>
                            <c:choose>
                                <c:when test="${p.appealStatus == 0}"><span class="label label-default">未申诉</span></c:when>
                                <c:when test="${p.appealStatus == 1}"><span class="label label-warning">待复核</span></c:when>
                                <c:when test="${p.appealStatus == 2}"><span class="label label-success">申诉通过</span></c:when>
                                <c:otherwise><span class="label label-info">申诉驳回</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${p.appealStatus == 0 || p.appealStatus == 3}">
                                <button class="btn btn-xs btn-primary" data-toggle="modal" data-target="#appealModal${p.punishId}">申诉</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <%-- 每个处罚一个申诉弹窗 --%>
            <c:forEach var="p" items="${punishments}">
                <div class="modal fade" id="appealModal${p.punishId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/punishment/appeal" method="post">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">申诉处罚 #${p.punishId}</h4>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="punishId" value="${p.punishId}">
                                    <div class="form-group">
                                        <label>申诉理由</label>
                                        <textarea name="appealReason" class="form-control" rows="4" required
                                                  placeholder="请说明您申诉的理由..."></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-primary">提交申诉</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>
