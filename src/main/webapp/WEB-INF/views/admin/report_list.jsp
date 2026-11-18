<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>举报处理 - 流浪猫狗救助系统后台</title>
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
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/user/admins">管理员管理</a></li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/volunteer/list">志愿审核</a></li>
                <li class="list-group-item active">举报处理 <span class="badge">${pendingCount}</span></li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/punishment/list">处罚管理</a></li>
            </ul>
        </div>
        <div class="col-sm-10">
            <h3>举报处理</h3>
            <form class="form-inline" action="${pageContext.request.contextPath}/admin/report/list" method="get" style="margin-bottom:15px;">
                <div class="form-group">
                    <select name="status" class="form-control">
                        <option value="">全部状态</option>
                        <option value="1" ${status == 1 ? 'selected' : ''}>待处理</option>
                        <option value="2" ${status == 2 ? 'selected' : ''}>已处理</option>
                        <option value="3" ${status == 3 ? 'selected' : ''}>已驳回</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">筛选</button>
            </form>

            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>举报人</th>
                    <th>对象</th>
                    <th>原因</th>
                    <th>描述</th>
                    <th>时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="r" items="${reports}">
                    <tr>
                        <td>${r.reportId}</td>
                        <td>${r.reporterName}</td>
                        <td>${r.targetTypeName}(${r.targetId})</td>
                        <td>${r.reason}</td>
                        <td>${r.description}</td>
                        <td>${r.reportTime}</td>
                        <td>
                            <c:choose>
                                <c:when test="${r.status == 1}"><span class="label label-warning">待处理</span></c:when>
                                <c:when test="${r.status == 2}"><span class="label label-success">已处理</span></c:when>
                                <c:otherwise><span class="label label-default">已驳回</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${r.status == 1}">
                                <button class="btn btn-xs btn-primary" data-toggle="modal" data-target="#handleModal${r.reportId}">处理</button>
                            </c:if>
                            <c:if test="${r.status != 1}">${r.handleResult}</c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <c:forEach var="r" items="${reports}">
                <c:if test="${r.status == 1}">
                    <div class="modal fade" id="handleModal${r.reportId}" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="${pageContext.request.contextPath}/admin/report/handle" method="post">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">处理举报 #${r.reportId}</h4>
                                    </div>
                                    <div class="modal-body">
                                        <p><b>原因：</b>${r.reason}</p>
                                        <p><b>描述：</b>${r.description}</p>
                                        <input type="hidden" name="reportId" value="${r.reportId}">
                                        <div class="form-group">
                                            <label>处理结果</label>
                                            <select name="status" class="form-control">
                                                <option value="2">已处理（举报属实）</option>
                                                <option value="3">已驳回（举报不属实）</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>处理说明</label>
                                            <textarea name="handleResult" class="form-control" rows="3"></textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                        <button type="submit" class="btn btn-primary">提交</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>
