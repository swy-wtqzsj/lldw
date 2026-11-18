<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>证书管理 - 后台</title>
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help/comments">评论</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/activity/list">活动</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/knowledge/list">知识</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/material/list">物资</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/punishment/list">处罚</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/report/list">举报</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/cert/list">证书</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 mt-4">
    <h3 class="mb-3">证书管理</h3>

    <c:if test="${not empty sessionScope.adminCertMsg}">
        <div class="alert alert-info">${sessionScope.adminCertMsg}</div>
        <c:remove var="adminCertMsg" scope="session"/>
    </c:if>

    <!-- 团队认证 -->
    <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <strong>团队认证</strong>
            <div>
                <a href="${pageContext.request.contextPath}/admin/cert/list${empty volunteerStatus ? '' : '?volunteerStatus='}${volunteerStatus}" class="btn btn-sm ${empty teamStatus ? 'btn-primary' : 'btn-outline-primary'}">全部</a>
                <a href="${pageContext.request.contextPath}/admin/cert/list?teamStatus=1${empty volunteerStatus ? '' : '&volunteerStatus='}${volunteerStatus}" class="btn btn-sm ${teamStatus == 1 ? 'btn-warning' : 'btn-outline-warning'}">待认证</a>
                <a href="${pageContext.request.contextPath}/admin/cert/list?teamStatus=2${empty volunteerStatus ? '' : '&volunteerStatus='}${volunteerStatus}" class="btn btn-sm ${teamStatus == 2 ? 'btn-success' : 'btn-outline-success'}">已认证</a>
                <a href="${pageContext.request.contextPath}/admin/cert/list?teamStatus=3${empty volunteerStatus ? '' : '&volunteerStatus='}${volunteerStatus}" class="btn btn-sm ${teamStatus == 3 ? 'btn-danger' : 'btn-outline-danger'}">已驳回</a>
            </div>
        </div>
        <div class="card-body p-0">
            <table class="table table-striped align-middle mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>机构名称</th>
                        <th>信用代码</th>
                        <th>负责人</th>
                        <th>服务范围</th>
                        <th>申请人</th>
                        <th>申请时间</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${teamList}">
                        <tr>
                            <td>${item.teamId}</td>
                            <td>
                                ${item.teamName}
                                <c:if test="${not empty item.description}">
                                    <div class="text-muted small">${item.description}</div>
                                </c:if>
                            </td>
                            <td>${item.creditCode}</td>
                            <td>${item.leaderName}</td>
                            <td>${item.serviceScope}</td>
                            <td>${item.username}</td>
                            <td><fmt:formatDate value="${item.applyTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <span class="badge ${item.status == 1 ? 'bg-warning text-dark' : (item.status == 2 ? 'bg-success' : 'bg-secondary')}">${item.statusText}</span>
                            </td>
                            <td>
                                <c:if test="${item.status == 1}">
                                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#teamModal${item.teamId}">审核</button>
                                </c:if>
                            </td>
                        </tr>

                        <div class="modal fade" id="teamModal${item.teamId}" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">团队认证审核 - ${item.teamName}</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/admin/cert/team/audit" method="post">
                                        <div class="modal-body">
                                            <input type="hidden" name="teamId" value="${item.teamId}">
                                            <div class="mb-3">
                                                <label class="form-label">审核结果</label>
                                                <select name="status" class="form-select" required>
                                                    <option value="2">认证通过</option>
                                                    <option value="3">驳回</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                                            <button type="submit" class="btn btn-primary">提交</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty teamList}">
                        <tr>
                            <td colspan="9" class="text-center text-muted">暂无团队认证记录</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 志愿者认证 -->
    <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <strong>志愿者认证</strong>
            <div>
                <c:set var="teamParam"><c:if test="${not empty teamStatus}">&teamStatus=${teamStatus}</c:if></c:set>
                <a href="${pageContext.request.contextPath}/admin/cert/list${empty teamStatus ? '' : '?teamStatus='}${teamStatus}" class="btn btn-sm ${empty volunteerStatus ? 'btn-primary' : 'btn-outline-primary'}">全部</a>
                <a href="${pageContext.request.contextPath}/admin/cert/list?volunteerStatus=1${teamParam}" class="btn btn-sm ${volunteerStatus == 1 ? 'btn-warning' : 'btn-outline-warning'}">待认证</a>
                <a href="${pageContext.request.contextPath}/admin/cert/list?volunteerStatus=2${teamParam}" class="btn btn-sm ${volunteerStatus == 2 ? 'btn-success' : 'btn-outline-success'}">已认证</a>
                <a href="${pageContext.request.contextPath}/admin/cert/list?volunteerStatus=3${teamParam}" class="btn btn-sm ${volunteerStatus == 3 ? 'btn-danger' : 'btn-outline-danger'}">已驳回</a>
            </div>
        </div>
        <div class="card-body p-0">
            <table class="table table-striped align-middle mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>申请人</th>
                        <th>真实姓名</th>
                        <th>身份证号</th>
                        <th>联系电话</th>
                        <th>服务区域</th>
                        <th>技能标签</th>
                        <th>申请时间</th>
                        <th>状态</th>
                        <th>审核意见</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${volunteerList}">
                        <tr>
                            <td>${item.certId}</td>
                            <td>${item.username}</td>
                            <td>${item.realName}</td>
                            <td>${item.idCard}</td>
                            <td>${item.phone}</td>
                            <td>${item.serviceArea}</td>
                            <td>${item.skillTags}</td>
                            <td><fmt:formatDate value="${item.applyTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <span class="badge ${item.status == 1 ? 'bg-warning text-dark' : (item.status == 2 ? 'bg-success' : 'bg-secondary')}">${item.statusText}</span>
                            </td>
                            <td class="text-muted small">${item.auditOpinion}</td>
                            <td>
                                <c:if test="${item.status == 1}">
                                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#volModal${item.certId}">审核</button>
                                </c:if>
                            </td>
                        </tr>

                        <div class="modal fade" id="volModal${item.certId}" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">志愿者认证审核 - ${item.realName}</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/admin/cert/volunteer/audit" method="post">
                                        <div class="modal-body">
                                            <input type="hidden" name="certId" value="${item.certId}">
                                            <div class="mb-3">
                                                <label class="form-label">审核结果</label>
                                                <select name="status" class="form-select" required>
                                                    <option value="2">认证通过</option>
                                                    <option value="3">驳回</option>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">审核意见</label>
                                                <textarea name="auditOpinion" class="form-control" rows="3" maxlength="255"></textarea>
                                            </div>
                                            <div class="form-text">认证通过后，该用户角色将升级为志愿者</div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                                            <button type="submit" class="btn btn-primary">提交</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty volunteerList}">
                        <tr>
                            <td colspan="11" class="text-center text-muted">暂无志愿者认证记录</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
