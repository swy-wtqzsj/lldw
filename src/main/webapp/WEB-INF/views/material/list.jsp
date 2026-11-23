<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>物资捐赠 - 流浪猫狗救助系统</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">首页</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/pet/list">领养中心</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/help/list">求助中心</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/activity/list">志愿活动</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/knowledge/list">知识科普</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/material/list">物资捐赠</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/sign/list">志愿签到</a></li>
            </ul>
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser}">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/profile">个人中心</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">登录</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3 class="mb-3">物资捐赠</h3>
    <p class="text-muted">捐赠的物资会实时入库并记入出入库流水；库存低于预警阈值的物资会优先展示给管理员补充。</p>

    <c:if test="${not empty sessionScope.materialMsg}">
        <div class="alert alert-info">${sessionScope.materialMsg}</div>
        <c:remove var="materialMsg" scope="session"/>
    </c:if>

    <div class="card mb-4">
        <div class="card-header">我要捐赠</div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <form action="${pageContext.request.contextPath}/material/donate" method="post" class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">选择已有物资</label>
                            <select name="materialId" class="form-select">
                                <option value="">捐赠新物资（在下方填写名称）</option>
                                <c:forEach var="m" items="${list}">
                                    <option value="${m.materialId}">${m.name}（当前库存 ${m.quantity} ${m.unit}）</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">新物资名称</label>
                            <input type="text" name="name" class="form-control" maxlength="50" placeholder="如：幼猫粮">
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">类别</label>
                            <select name="category" class="form-select">
                                <option value="1">食物</option>
                                <option value="2">药品</option>
                                <option value="3" selected>用品</option>
                            </select>
                        </div>
                        <div class="col-md-1">
                            <label class="form-label">数量</label>
                            <input type="number" name="quantity" class="form-control" min="1" value="1" required>
                        </div>
                        <div class="col-md-1">
                            <label class="form-label">单位</label>
                            <input type="text" name="unit" class="form-control" value="件" maxlength="10">
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary">提交捐赠</button>
                            <span class="text-muted ms-2">选择已有物资时，名称/类别/单位以库存记录为准。</span>
                        </div>
                    </form>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">登录后捐赠</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>当前物资库存</span>
            <span>
                <a href="${pageContext.request.contextPath}/material/list" class="btn btn-sm ${empty category ? 'btn-primary' : 'btn-outline-primary'}">全部</a>
                <a href="${pageContext.request.contextPath}/material/list?category=1" class="btn btn-sm ${category == 1 ? 'btn-primary' : 'btn-outline-primary'}">食物</a>
                <a href="${pageContext.request.contextPath}/material/list?category=2" class="btn btn-sm ${category == 2 ? 'btn-primary' : 'btn-outline-primary'}">药品</a>
                <a href="${pageContext.request.contextPath}/material/list?category=3" class="btn btn-sm ${category == 3 ? 'btn-primary' : 'btn-outline-primary'}">用品</a>
            </span>
        </div>
        <div class="card-body table-responsive">
            <table class="table table-hover align-middle">
                <thead><tr><th>物资</th><th>类别</th><th>库存</th><th>单位</th><th>最近捐赠人</th><th>状态</th></tr></thead>
                <tbody>
                <c:forEach var="m" items="${list}">
                    <tr>
                        <td>${m.name}</td>
                        <td>${m.categoryText}</td>
                        <td>${m.quantity}</td>
                        <td>${m.unit}</td>
                        <td>${empty m.donor ? '—' : m.donor}</td>
                        <td>
                            <c:choose>
                                <c:when test="${m.lowStock}"><span class="badge bg-danger">库存预警</span></c:when>
                                <c:otherwise><span class="badge bg-success">充足</span></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="6" class="text-center text-muted py-4">暂无物资记录，欢迎成为第一位捐赠者</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <c:if test="${not empty sessionScope.loginUser}">
        <div class="card">
            <div class="card-header">我的捐赠</div>
            <div class="card-body table-responsive">
                <table class="table table-sm align-middle">
                    <thead><tr><th>物资</th><th>数量</th><th>类型</th><th>时间</th></tr></thead>
                    <tbody>
                    <c:forEach var="r" items="${myDonations}">
                        <tr>
                            <td>${r.materialName}</td>
                            <td>${r.quantity}</td>
                            <td>${r.typeText}</td>
                            <td><fmt:formatDate value="${r.recordTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty myDonations}">
                        <tr><td colspan="4" class="text-center text-muted py-3">还没有捐赠记录</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
</div>
</body>
</html>
