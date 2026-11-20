<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>志愿审核 - 流浪猫狗救助系统后台</title>
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
                <li class="list-group-item active">志愿审核 <span class="badge">${pendingCount}</span></li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/report/list">举报处理</a></li>
                <li class="list-group-item"><a href="${pageContext.request.contextPath}/admin/punishment/list">处罚管理</a></li>
            </ul>
        </div>
        <div class="col-sm-10">
            <h3>志愿者认证审核</h3>
            <form class="form-inline" action="${pageContext.request.contextPath}/admin/volunteer/list" method="get" style="margin-bottom:15px;">
                <div class="form-group">
                    <input type="text" name="keyword" class="form-control" placeholder="姓名/用户名" value="${keyword}">
                </div>
                <div class="form-group">
                    <select name="status" class="form-control">
                        <option value="">全部状态</option>
                        <option value="1" ${status == 1 ? 'selected' : ''}>待审核</option>
                        <option value="2" ${status == 2 ? 'selected' : ''}>已通过</option>
                        <option value="3" ${status == 3 ? 'selected' : ''}>已拒绝</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">搜索</button>
            </form>

            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>用户名</th>
                    <th>姓名</th>
                    <th>类型</th>
                    <th>身份证</th>
                    <th>团队/机构</th>
                    <th>申请时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="v" items="${list}">
                    <tr>
                        <td>${v.volunteerId}</td>
                        <td>${v.username}</td>
                        <td>${v.realName}</td>
                        <td>${v.certType == 2 ? '团队/机构' : '个人实名'}</td>
                        <td>${v.idCard}</td>
                        <td>${v.orgName}</td>
                        <td>${v.applyTime}</td>
                        <td>
                            <c:choose>
                                <c:when test="${v.auditStatus == 1}"><span class="label label-warning">待审核</span></c:when>
                                <c:when test="${v.auditStatus == 2}"><span class="label label-success">已通过</span></c:when>
                                <c:otherwise><span class="label label-danger">已拒绝</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${v.auditStatus == 1}">
                                <button class="btn btn-xs btn-success" data-toggle="modal" data-target="#auditModal${v.volunteerId}">审核</button>
                            </c:if>
                            <button class="btn btn-xs btn-default" data-toggle="modal" data-target="#scoreModal${v.volunteerId}">工时/积分</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <c:forEach var="v" items="${list}">
                <%-- 审核弹窗 --%>
                <div class="modal fade" id="auditModal${v.volunteerId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/admin/volunteer/audit" method="post">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">审核 ${v.realName} 的认证申请</h4>
                                </div>
                                <div class="modal-body">
                                    <p><b>简介：</b>${v.intro}</p>
                                    <input type="hidden" name="volunteerId" value="${v.volunteerId}">
                                    <div class="form-group">
                                        <label>审核结果</label>
                                        <select name="auditStatus" class="form-control">
                                            <option value="2">通过</option>
                                            <option value="3">拒绝</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>审核意见</label>
                                        <textarea name="auditOpinion" class="form-control" rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-primary">提交审核</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <%-- 工时/积分弹窗 --%>
                <div class="modal fade" id="scoreModal${v.volunteerId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/admin/volunteer/score" method="post">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">设置 ${v.realName} 的工时与积分</h4>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="volunteerId" value="${v.volunteerId}">
                                    <div class="form-group">
                                        <label>累计工时</label>
                                        <input type="number" name="workHours" class="form-control" value="${v.workHours}">
                                    </div>
                                    <div class="form-group">
                                        <label>积分</label>
                                        <input type="number" name="points" class="form-control" value="${v.points}">
                                    </div>
                                    <div class="form-group">
                                        <label>等级</label>
                                        <input type="number" name="level" class="form-control" value="${v.level}">
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
