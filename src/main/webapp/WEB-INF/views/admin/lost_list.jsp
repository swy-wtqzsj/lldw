<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>寻宠启事管理 - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark admin-nav">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">后台管理</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">看板</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/pet/list">宠物</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/pet/adoption_list">领养审核</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/user/list">用户</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help/list">求助</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help-response/list">求助响应</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help/comments">评论</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/activity/list">活动</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/knowledge/list">知识</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/material/list">物资</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/punishment/list">处罚</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/report/list">举报</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/cert/list">证书</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/lost/list">寻宠启事</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/appeal/list">处罚申诉</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 mt-4">
    <h3 class="mb-3">寻宠启事管理</h3>

    <c:if test="${not empty sessionScope.adminLostMsg}">
        <div class="alert alert-info">${sessionScope.adminLostMsg}</div>
        <c:remove var="adminLostMsg" scope="session"/>
    </c:if>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/admin/lost/list" class="btn btn-sm ${empty status ? 'btn-primary' : 'btn-outline-primary'}">全部状态</a>
        <a href="${pageContext.request.contextPath}/admin/lost/list?status=1" class="btn btn-sm ${status == 1 ? 'btn-warning' : 'btn-outline-warning'}">待审核</a>
        <a href="${pageContext.request.contextPath}/admin/lost/list?status=2" class="btn btn-sm ${status == 2 ? 'btn-success' : 'btn-outline-success'}">发布中</a>
        <a href="${pageContext.request.contextPath}/admin/lost/list?status=3" class="btn btn-sm ${status == 3 ? 'btn-info' : 'btn-outline-info'}">已找回</a>
        <a href="${pageContext.request.contextPath}/admin/lost/list?status=4" class="btn btn-sm ${status == 4 ? 'btn-secondary' : 'btn-outline-secondary'}">已撤回</a>
        <a href="${pageContext.request.contextPath}/admin/lost/list?status=5" class="btn btn-sm ${status == 5 ? 'btn-danger' : 'btn-outline-danger'}">已下架</a>
    </div>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>照片</th>
                <th>宠物</th>
                <th>走失信息</th>
                <th>联系方式</th>
                <th>悬赏</th>
                <th>发布人</th>
                <th>发布时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.lostId}</td>
                    <td>
                        <c:if test="${not empty item.photo}">
                            <img src="${pageContext.request.contextPath}${item.photo}" alt="照片"
                                 style="width: 64px; height: 64px; object-fit: cover;" class="rounded">
                        </c:if>
                    </td>
                    <td>
                        <div>${item.petName}</div>
                        <div class="text-muted small">${item.speciesText} ${item.breed} ${item.genderText}</div>
                    </td>
                    <td>
                        <div class="small">
                            <c:if test="${not empty item.lostTime}">
                                <fmt:formatDate value="${item.lostTime}" pattern="yyyy-MM-dd HH:mm"/>
                            </c:if>
                        </div>
                        <div class="text-muted small">${item.lostLocation}</div>
                        <div class="text-muted small">${item.features}</div>
                    </td>
                    <td>${item.contact}</td>
                    <td>￥${item.reward}</td>
                    <td>${item.username}</td>
                    <td><fmt:formatDate value="${item.publishTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == 1}"><span class="badge bg-warning text-dark">待审核</span></c:when>
                            <c:when test="${item.status == 2}"><span class="badge bg-success">发布中</span></c:when>
                            <c:when test="${item.status == 3}"><span class="badge bg-info">已找回</span></c:when>
                            <c:when test="${item.status == 4}"><span class="badge bg-secondary">已撤回</span></c:when>
                            <c:otherwise><span class="badge bg-danger">已下架</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${item.status != 4}">
                            <form action="${pageContext.request.contextPath}/admin/lost/status" method="post" class="d-flex gap-1">
                                <input type="hidden" name="lostId" value="${item.lostId}">
                                <select name="status" class="form-select form-select-sm" style="width: 110px;">
                                    <option value="1" ${item.status == 1 ? 'selected' : ''}>待审核</option>
                                    <option value="2" ${item.status == 2 ? 'selected' : ''}>发布中</option>
                                    <option value="3" ${item.status == 3 ? 'selected' : ''}>已找回</option>
                                    <option value="5" ${item.status == 5 ? 'selected' : ''}>下架</option>
                                </select>
                                <button type="submit" class="btn btn-sm btn-outline-primary">更新</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="10" class="text-center text-muted">暂无寻宠启事</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
