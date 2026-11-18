<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>志愿者认证 - 流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助</a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="${pageContext.request.contextPath}/profile">个人中心</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="${pageContext.request.contextPath}/logout">退出</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <h2>志愿者 / 团队认证申请</h2>
            <p class="text-muted">提交实名或机构资质，审核通过后即可参与志愿服务。</p>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty msg}">
                <div class="alert alert-success">${msg}</div>
            </c:if>

            <%-- 已提交申请：展示状态 --%>
            <c:if test="${not empty volunteer && volunteer.volunteerId != null}">
                <div class="panel panel-info">
                    <div class="panel-heading"><h4>我的认证状态</h4></div>
                    <div class="panel-body">
                        <p>姓名：${volunteer.realName}　类型：${volunteer.certType == 2 ? '团队/机构' : '个人实名'}</p>
                        <p>审核状态：
                            <c:choose>
                                <c:when test="${volunteer.auditStatus == 1}"><span class="label label-warning">待审核</span></c:when>
                                <c:when test="${volunteer.auditStatus == 2}"><span class="label label-success">已通过</span></c:when>
                                <c:otherwise><span class="label label-danger">已拒绝</span></c:otherwise>
                            </c:choose>
                        </p>
                        <p>累计工时：${volunteer.workHours == null ? 0 : volunteer.workHours} 小时　积分：${volunteer.points == null ? 0 : volunteer.points}</p>
                        <c:if test="${not empty volunteer.auditOpinion}">
                            <p>审核意见：${volunteer.auditOpinion}</p>
                        </c:if>
                    </div>
                </div>
            </c:if>

            <%-- 申请表单 --%>
            <div class="panel panel-default">
                <div class="panel-heading"><h4>${volunteer.volunteerId != null ? '重新提交申请' : '填写申请资料'}</h4></div>
                <div class="panel-body">
                    <form action="${pageContext.request.contextPath}/volunteer/apply" method="post">
                        <div class="form-group">
                            <label>认证类型</label>
                            <select name="certType" class="form-control">
                                <option value="1" ${volunteer.certType == 1 ? 'selected' : ''}>个人实名认证</option>
                                <option value="2" ${volunteer.certType == 2 ? 'selected' : ''}>团队/机构认证</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>真实姓名</label>
                            <input type="text" name="realName" class="form-control" value="${volunteer.realName}" required>
                        </div>
                        <div class="form-group">
                            <label>身份证号</label>
                            <input type="text" name="idCard" class="form-control" value="${volunteer.idCard}" required>
                        </div>
                        <div class="form-group">
                            <label>联系电话</label>
                            <input type="text" name="phone" class="form-control" value="${volunteer.phone}">
                        </div>
                        <div class="form-group">
                            <label>团队/机构名称（团队认证填写）</label>
                            <input type="text" name="orgName" class="form-control" value="${volunteer.orgName}">
                        </div>
                        <div class="form-group">
                            <label>简介</label>
                            <textarea name="intro" class="form-control" rows="3">${volunteer.intro}</textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">提交申请</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
