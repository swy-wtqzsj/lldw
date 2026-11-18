<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>处罚管理 - 流浪猫狗救助系统后台</title>
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
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/report/list">举报处理</a></li>
                <li class="list-group-item active">处罚管理 <span class="badge">${appealCount}</span></li>
            </ul>
        </div>
        <div class="col-sm-10">
            <h3>账号处罚管理</h3>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div style="margin-bottom:15px;">
                <button class="btn btn-primary" data-toggle="modal" data-target="#addModal">新增处罚</button>
                <form class="form-inline pull-right" action="${pageContext.request.contextPath}/admin/punishment/list" method="get">
                    <div class="form-group">
                        <input type="text" name="username" class="form-control" placeholder="用户名" value="${username}">
                    </div>
                    <div class="form-group">
                        <select name="status" class="form-control">
                            <option value="">全部状态</option>
                            <option value="1" ${status == 1 ? 'selected' : ''}>生效中</option>
                            <option value="2" ${status == 2 ? 'selected' : ''}>已解除</option>
                            <option value="3" ${status == 3 ? 'selected' : ''}>已到期</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-default">筛选</button>
                </form>
            </div>

            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>用户</th>
                    <th>类型</th>
                    <th>原因</th>
                    <th>开始</th>
                    <th>结束</th>
                    <th>状态</th>
                    <th>申诉</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${punishments}">
                    <tr>
                        <td>${p.punishId}</td>
                        <td>${p.username}(${p.userId})</td>
                        <td><span class="label label-danger">${p.typeName}</span></td>
                        <td>${p.reason}</td>
                        <td>${p.startTime}</td>
                        <td>${p.endTime}</td>
                        <td>${p.statusName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${p.appealStatus == 1}"><span class="label label-warning">待复核</span></c:when>
                                <c:when test="${p.appealStatus == 2}"><span class="label label-success">通过</span></c:when>
                                <c:when test="${p.appealStatus == 3}"><span class="label label-info">驳回</span></c:when>
                                <c:otherwise>未申诉</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${p.status == 1}">
                                <a href="${pageContext.request.contextPath}/admin/punishment/release/${p.punishId}"
                                   class="btn btn-xs btn-default" onclick="return confirm('确认解除处罚？')">解除</a>
                            </c:if>
                            <c:if test="${p.appealStatus == 1}">
                                <button class="btn btn-xs btn-primary" data-toggle="modal" data-target="#appealModal${p.punishId}">复核</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <%-- 新增处罚弹窗 --%>
            <div class="modal fade" id="addModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/admin/punishment/add" method="post">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">新增处罚</h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label>用户ID</label>
                                    <input type="number" name="userId" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>处罚类型</label>
                                    <select name="type" class="form-control">
                                        <option value="1">警告</option>
                                        <option value="2">禁言</option>
                                        <option value="3">封禁</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>处罚原因</label>
                                    <input type="text" name="reason" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>结束时间（留空为永久）</label>
                                    <input type="datetime-local" name="endTime" class="form-control">
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

            <%-- 申诉复核弹窗 --%>
            <c:forEach var="p" items="${punishments}">
                <c:if test="${p.appealStatus == 1}">
                    <div class="modal fade" id="appealModal${p.punishId}" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="${pageContext.request.contextPath}/admin/punishment/appeal" method="post">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">复核申诉 #${p.punishId}</h4>
                                    </div>
                                    <div class="modal-body">
                                        <p><b>申诉理由：</b>${p.appealReason}</p>
                                        <input type="hidden" name="punishId" value="${p.punishId}">
                                        <div class="form-group">
                                            <label>复核结果</label>
                                            <select name="appealStatus" class="form-control">
                                                <option value="2">通过（解除处罚）</option>
                                                <option value="3">驳回（维持处罚）</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>复核说明</label>
                                            <textarea name="appealResult" class="form-control" rows="3"></textarea>
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
