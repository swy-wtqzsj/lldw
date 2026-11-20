<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理 - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">后台管理</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/pet/list">宠物管理</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/pet/adoption_list">领养审核</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/user/list">用户管理</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/user/admins">管理员管理</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/volunteer/list">志愿审核</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/report_record/list">A组举报</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help/list">求助管理</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/activity/list">活动管理</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/knowledge/list">知识管理</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">用户管理</h3>
        <form action="${pageContext.request.contextPath}/admin/user/list" method="get" class="d-flex gap-2">
            <input type="text" name="keyword" class="form-control" placeholder="用户名/昵称/手机号" value="${keyword}">
            <select name="role" class="form-select" style="width:auto;">
                <option value="">全部角色</option>
                <option value="1" ${role == 1 ? 'selected' : ''}>普通用户</option>
                <option value="2" ${role == 2 ? 'selected' : ''}>志愿者</option>
                <option value="3" ${role == 3 ? 'selected' : ''}>管理员</option>
                <option value="9" ${role == 9 ? 'selected' : ''}>超级管理员</option>
            </select>
            <button type="submit" class="btn btn-primary">搜索</button>
            <a href="${pageContext.request.contextPath}/admin/user/list" class="btn btn-outline-secondary">重置</a>
        </form>
    </div>

    <c:if test="${not empty param.error}">
        <div class="alert alert-danger">${param.error}</div>
    </c:if>

    <c:if test="${not empty sessionScope.adminUserMsg}">
        <div class="alert alert-warning">${sessionScope.adminUserMsg}</div>
        <c:remove var="adminUserMsg" scope="session"/>
    </c:if>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>用户名</th>
                <th>昵称</th>
                <th>手机号</th>
                <th>角色</th>
                <th>信用分</th>
                <th>注册时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.userId}</td>
                    <td>${item.username}</td>
                    <td>${item.nickname}</td>
                    <td>${item.phone}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.role == 9}">超级管理员</c:when>
                            <c:when test="${item.role == 3}">管理员</c:when>
                            <c:when test="${item.role == 2}">志愿者</c:when>
                            <c:otherwise>普通用户</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.creditScore}</td>
                    <td><fmt:formatDate value="${item.registerTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <span class="badge ${item.status == 1 ? 'bg-success' : 'bg-secondary'}">
                            ${item.status == 1 ? '正常' : '已禁用'}
                        </span>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/admin/user/status" method="post">
                            <input type="hidden" name="userId" value="${item.userId}">
                            <input type="hidden" name="keyword" value="${keyword}">
                            <c:choose>
                                <c:when test="${item.status == 1}">
                                    <input type="hidden" name="status" value="0">
                                    <button type="submit" class="btn btn-sm btn-outline-danger">禁用</button>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="status" value="1">
                                    <button type="submit" class="btn btn-sm btn-outline-success">启用</button>
                                </c:otherwise>
                            </c:choose>
                        </form>
                        <div class="d-flex gap-1 mt-1">
                            <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editModal${item.userId}">编辑</button>
                            <c:if test="${item.role != 9}">
                                <a href="${pageContext.request.contextPath}/admin/user/delete/${item.userId}" class="btn btn-sm btn-outline-danger" onclick="return confirm('确认删除该用户？')">删除</a>
                            </c:if>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="9" class="text-center text-muted">暂无匹配用户</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <c:forEach var="item" items="${list}">
        <div class="modal fade" id="editModal${item.userId}" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/admin/user/update" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title">编辑用户：${item.username}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="userId" value="${item.userId}">
                            <div class="mb-3">
                                <label class="form-label">角色</label>
                                <select name="role" class="form-select">
                                    <option value="1" ${item.role == 1 ? 'selected' : ''}>普通用户</option>
                                    <option value="2" ${item.role == 2 ? 'selected' : ''}>志愿者</option>
                                    <option value="3" ${item.role == 3 ? 'selected' : ''}>管理员</option>
                                    <option value="9" ${item.role == 9 ? 'selected' : ''}>超级管理员</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">状态</label>
                                <select name="status" class="form-select">
                                    <option value="1" ${item.status == 1 ? 'selected' : ''}>正常</option>
                                    <option value="0" ${item.status == 0 ? 'selected' : ''}>禁用</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">领养资格</label>
                                <select name="adoptStatus" class="form-select">
                                    <option value="1" ${item.adoptStatus == 1 ? 'selected' : ''}>正常</option>
                                    <option value="2" ${item.adoptStatus == 2 ? 'selected' : ''}>暂停</option>
                                    <option value="3" ${item.adoptStatus == 3 ? 'selected' : ''}>永久禁止</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">信用分</label>
                                <input type="number" name="creditScore" class="form-control" value="${item.creditScore}">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-primary">保存</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
