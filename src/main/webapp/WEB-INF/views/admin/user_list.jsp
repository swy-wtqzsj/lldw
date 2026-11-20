<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户管理 - 流浪猫狗救助系统后台</title>
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
                <li class="list-group-item active">用户管理</li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/user/admins">管理员管理</a></li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/volunteer/list">志愿审核</a></li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/report/list">举报处理</a></li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/punishment/list">处罚管理</a></li>
            </ul>
        </div>
        <div class="col-sm-10">
            <h3>用户管理</h3>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger">${param.error}</div>
            </c:if>

            <%-- 搜索栏 --%>
            <form class="form-inline" action="${pageContext.request.contextPath}/admin/user/list" method="get" style="margin-bottom:15px;">
                <div class="form-group">
                    <input type="text" name="keyword" class="form-control" placeholder="用户名/昵称/手机号" value="${keyword}">
                </div>
                <div class="form-group">
                    <select name="role" class="form-control">
                        <option value="">全部角色</option>
                        <option value="1" ${role == 1 ? 'selected' : ''}>普通用户</option>
                        <option value="2" ${role == 2 ? 'selected' : ''}>志愿者</option>
                        <option value="3" ${role == 3 ? 'selected' : ''}>管理员</option>
                        <option value="9" ${role == 9 ? 'selected' : ''}>超级管理员</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">搜索</button>
            </form>

            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>用户名</th>
                    <th>昵称</th>
                    <th>手机号</th>
                    <th>角色</th>
                    <th>状态</th>
                    <th>信用分</th>
                    <th>注册时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="u" items="${users}">
                    <tr>
                        <td>${u.userId}</td>
                        <td>${u.username}</td>
                        <td>${u.nickname}</td>
                        <td>${u.phone}</td>
                        <td>
                            <c:choose>
                                <c:when test="${u.role == 9}">超级管理员</c:when>
                                <c:when test="${u.role == 3}">管理员</c:when>
                                <c:when test="${u.role == 2}">志愿者</c:when>
                                <c:otherwise>普通用户</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${u.status == 1}"><span class="label label-success">正常</span></c:when>
                                <c:otherwise><span class="label label-danger">禁用</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>${u.creditScore}</td>
                        <td>${u.registerTime}</td>
                        <td>
                            <button class="btn btn-xs btn-primary" data-toggle="modal" data-target="#editModal${u.userId}">编辑</button>
                            <c:if test="${u.role != 9}">
                                <a href="${pageContext.request.contextPath}/admin/user/delete/${u.userId}"
                                   class="btn btn-xs btn-danger" onclick="return confirm('确认删除该用户？')">删除</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <%-- 编辑弹窗 --%>
            <c:forEach var="u" items="${users}">
                <div class="modal fade" id="editModal${u.userId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/admin/user/update" method="post">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">编辑用户：${u.username}</h4>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="userId" value="${u.userId}">
                                    <div class="form-group">
                                        <label>角色</label>
                                        <select name="role" class="form-control">
                                            <option value="1" ${u.role == 1 ? 'selected' : ''}>普通用户</option>
                                            <option value="2" ${u.role == 2 ? 'selected' : ''}>志愿者</option>
                                            <option value="3" ${u.role == 3 ? 'selected' : ''}>管理员</option>
                                            <option value="9" ${u.role == 9 ? 'selected' : ''}>超级管理员</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>状态</label>
                                        <select name="status" class="form-control">
                                            <option value="1" ${u.status == 1 ? 'selected' : ''}>正常</option>
                                            <option value="0" ${u.status == 0 ? 'selected' : ''}>禁用</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>领养资格</label>
                                        <select name="adoptStatus" class="form-control">
                                            <option value="1" ${u.adoptStatus == 1 ? 'selected' : ''}>正常</option>
                                            <option value="2" ${u.adoptStatus == 2 ? 'selected' : ''}>暂停</option>
                                            <option value="3" ${u.adoptStatus == 3 ? 'selected' : ''}>永久禁止</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>信用分</label>
                                        <input type="number" name="creditScore" class="form-control" value="${u.creditScore}">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-primary">保存</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>
