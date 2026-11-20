<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>管理员管理 - 流浪猫狗救助系统后台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">救助系统后台</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="${pageContext.request.contextPath}/">返回前台</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">退出</a></li>
        </ul>
    </div>
</nav>

<div class="container-fluid" style="margin-top:20px;">
    <div class="row">
        <div class="col-sm-2">
            <ul class="list-group">
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/dashboard">数据看板</a></li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/user/list">用户管理</a></li>
                <li class="list-group-item active">管理员管理</li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/volunteer/list">志愿审核</a></li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/report/list">举报处理</a></li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/punishment/list">处罚管理</a></li>
            </ul>
        </div>
        <div class="col-sm-10">
            <h3>管理员管理</h3>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not isRoot}">
                <div class="alert alert-warning">只有超级管理员(root)才能管理管理员账号。</div>
            </c:if>

            <c:if test="${isRoot}">
                <button class="btn btn-primary" data-toggle="modal" data-target="#addModal" style="margin-bottom:15px;">新增管理员</button>
            </c:if>

            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>用户名</th>
                    <th>昵称</th>
                    <th>真实姓名</th>
                    <th>角色</th>
                    <th>状态</th>
                    <th>注册时间</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="a" items="${admins}">
                    <tr>
                        <td>${a.userId}</td>
                        <td>${a.username}</td>
                        <td>${a.nickname}</td>
                        <td>${a.realName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${a.role == 9}"><span class="label label-danger">超级管理员</span></c:when>
                                <c:otherwise><span class="label label-primary">管理员</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${a.status == 1}">正常</c:when>
                                <c:otherwise>禁用</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${a.registerTime}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <c:if test="${isRoot}">
                <div class="modal fade" id="addModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/admin/user/admin/add" method="post">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">新增管理员</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label>用户名</label>
                                        <input type="text" name="username" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>密码</label>
                                        <input type="password" name="password" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>昵称</label>
                                        <input type="text" name="nickname" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>真实姓名</label>
                                        <input type="text" name="realName" class="form-control">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-primary">添加</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>
