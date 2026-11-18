<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>认证申请</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/cert/apply">认证申请</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/report/my">我的举报</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/profile">个人中心</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3 class="mb-3">认证申请</h3>

    <c:if test="${not empty sessionScope.certMsg}">
        <div class="alert alert-info">${sessionScope.certMsg}</div>
        <c:remove var="certMsg" scope="session"/>
    </c:if>

    <div class="row">
        <!-- 志愿者认证 -->
        <div class="col-lg-6 mb-4">
            <div class="card h-100">
                <div class="card-header"><strong>志愿者认证</strong></div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty volunteerCert or volunteerCert.status == 3 or volunteerCert.status == 4}">
                            <c:if test="${not empty volunteerCert}">
                                <p class="text-muted">
                                    上次申请结果：
                                    <span class="badge ${volunteerCert.status == 3 ? 'bg-danger' : 'bg-secondary'}">${volunteerCert.statusText}</span>
                                    <c:if test="${not empty volunteerCert.auditOpinion}">
                                        <br>审核意见：${volunteerCert.auditOpinion}
                                    </c:if>
                                </p>
                            </c:if>
                            <form action="${pageContext.request.contextPath}/cert/volunteer/save" method="post">
                                <div class="mb-3">
                                    <label class="form-label">真实姓名</label>
                                    <input type="text" name="realName" class="form-control" maxlength="20" required value="${volunteerCert.realName}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">身份证号</label>
                                    <input type="text" name="idCard" class="form-control" maxlength="18" required value="${volunteerCert.idCard}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">联系电话</label>
                                    <input type="text" name="phone" class="form-control" maxlength="11" required value="${volunteerCert.phone}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">紧急联系人</label>
                                    <input type="text" name="emergencyContact" class="form-control" maxlength="20" value="${volunteerCert.emergencyContact}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">可服务区域</label>
                                    <input type="text" name="serviceArea" class="form-control" maxlength="100" value="${volunteerCert.serviceArea}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">技能标签</label>
                                    <input type="text" name="skillTags" class="form-control" maxlength="100" placeholder="如：驾驶、医疗护理" value="${volunteerCert.skillTags}">
                                </div>
                                <button type="submit" class="btn btn-primary">提交认证申请</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <p>
                                当前状态：
                                <span class="badge ${volunteerCert.status == 1 ? 'bg-warning text-dark' : 'bg-success'}">${volunteerCert.statusText}</span>
                            </p>
                            <p class="text-muted mb-1">真实姓名：${volunteerCert.realName}</p>
                            <p class="text-muted mb-1">可服务区域：${volunteerCert.serviceArea}</p>
                            <p class="text-muted mb-1">技能标签：${volunteerCert.skillTags}</p>
                            <p class="text-muted mb-0">申请时间：<fmt:formatDate value="${volunteerCert.applyTime}" pattern="yyyy-MM-dd HH:mm"/></p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- 团队认证 -->
        <div class="col-lg-6 mb-4">
            <div class="card h-100">
                <div class="card-header"><strong>团队认证</strong></div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty teamCert or teamCert.status == 3 or teamCert.status == 4}">
                            <c:if test="${not empty teamCert}">
                                <p class="text-muted">
                                    上次申请结果：
                                    <span class="badge ${teamCert.status == 3 ? 'bg-danger' : 'bg-secondary'}">${teamCert.statusText}</span>
                                </p>
                            </c:if>
                            <form action="${pageContext.request.contextPath}/cert/team/save" method="post">
                                <div class="mb-3">
                                    <label class="form-label">机构名称</label>
                                    <input type="text" name="teamName" class="form-control" maxlength="100" required value="${teamCert.teamName}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">统一社会信用代码</label>
                                    <input type="text" name="creditCode" class="form-control" maxlength="50" value="${teamCert.creditCode}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">负责人姓名</label>
                                    <input type="text" name="leaderName" class="form-control" maxlength="20" required value="${teamCert.leaderName}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">服务范围</label>
                                    <input type="text" name="serviceScope" class="form-control" maxlength="255" value="${teamCert.serviceScope}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">机构简介</label>
                                    <textarea name="description" class="form-control" rows="4" maxlength="1000">${teamCert.description}</textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">提交认证申请</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <p>
                                当前状态：
                                <span class="badge ${teamCert.status == 1 ? 'bg-warning text-dark' : 'bg-success'}">${teamCert.statusText}</span>
                            </p>
                            <p class="text-muted mb-1">机构名称：${teamCert.teamName}</p>
                            <p class="text-muted mb-1">负责人：${teamCert.leaderName}</p>
                            <p class="text-muted mb-1">服务范围：${teamCert.serviceScope}</p>
                            <p class="text-muted mb-0">申请时间：<fmt:formatDate value="${teamCert.applyTime}" pattern="yyyy-MM-dd HH:mm"/></p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-secondary">返回个人中心</a>
</div>
</body>
</html>
