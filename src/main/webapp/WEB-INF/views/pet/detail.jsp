<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pet.petName} - 宠物详情</title>
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/pet/list">领养中心</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/help/list">求助中心</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/activity/list">志愿活动</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/knowledge/list">知识科普</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="row">
        <div class="col-md-6">
            <img src="${pageContext.request.contextPath}${empty pet.photo ? '/static/img/default.svg' : pet.photo}" class="img-fluid rounded" alt="${pet.petName}" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/static/img/default.svg'">
        </div>
        <div class="col-md-6">
            <h2>${pet.petName}</h2>
            <p class="text-muted">编号：${pet.petNo}</p>

            <table class="table">
                <tr>
                    <td width="100">种类</td>
                    <td>${pet.speciesText}</td>
                </tr>
                <tr>
                    <td>品种</td>
                    <td>${pet.breed}</td>
                </tr>
                <tr>
                    <td>性别</td>
                    <td>${pet.genderText}</td>
                </tr>
                <tr>
                    <td>年龄段</td>
                    <td>${pet.ageStageText}</td>
                </tr>
                <tr>
                    <td>绝育</td>
                    <td>${pet.neuteredText}</td>
                </tr>
                <tr>
                    <td>疫苗</td>
                    <td>${pet.vaccinatedText}</td>
                </tr>
                <tr>
                    <td>状态</td>
                    <td><span class="badge bg-success">${pet.adoptStatusText}</span></td>
                </tr>
            </table>

            <c:if test="${not empty pet.healthStatus}">
                <p><strong>健康状况：</strong>${pet.healthStatus}</p>
            </c:if>

            <c:if test="${not empty pet.description}">
                <p><strong>详细介绍：</strong></p>
                <p>${pet.description}</p>
            </c:if>

            <c:if test="${pet.adoptStatus == 2}">
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser}">
                        <button class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#applyModal">
                            申请领养
                        </button>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg">登录后申请领养</a>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <c:if test="${pet.adoptStatus != 2}">
                <button class="btn btn-secondary btn-lg" disabled>当前不可领养</button>
            </c:if>
        </div>
    </div>

    <div class="mt-4">
        <h5>留言</h5>
        <c:choose>
            <c:when test="${not empty sessionScope.loginUser}">
                <form action="${pageContext.request.contextPath}/comment/add" method="post" class="mb-3">
                    <input type="hidden" name="targetType" value="1">
                    <input type="hidden" name="targetId" value="${pet.petId}">
                    <div class="input-group">
                        <input type="text" name="content" class="form-control" maxlength="500" placeholder="写下你的留言...">
                        <button type="submit" class="btn btn-primary">发表</button>
                    </div>
                </form>
            </c:when>
            <c:otherwise>
                <p class="text-muted">登录后可发表留言</p>
            </c:otherwise>
        </c:choose>

        <c:forEach var="comment" items="${comments}">
            <div class="card mb-2">
                <div class="card-body py-2">
                    <div class="d-flex justify-content-between">
                        <strong>${comment.username}</strong>
                        <span>
                            <small class="text-muted"><fmt:formatDate value="${comment.commentTime}" pattern="yyyy-MM-dd HH:mm"/></small>
                            <a href="${pageContext.request.contextPath}/report/publish?targetType=1&amp;targetId=${comment.commentId}" class="ms-2 small">举报</a>
                        </span>
                    </div>
                    <p class="mb-0">${comment.content}</p>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty comments}">
            <p class="text-muted">暂无留言，来抢沙发~</p>
        </c:if>
    </div>
</div>

<!-- 领养申请弹窗 -->
<div class="modal fade" id="applyModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">领养申请 - ${pet.petName}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/pet/apply" method="post">
                <div class="modal-body">
                    <input type="hidden" name="petId" value="${pet.petId}">
                    <div class="mb-3">
                        <label class="form-label">领养人姓名</label>
                        <input type="text" name="adopterName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">联系电话</label>
                        <input type="text" name="phone" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">经济状况</label>
                        <select name="economicStatus" class="form-select">
                            <option value="良好">良好</option>
                            <option value="一般">一般</option>
                            <option value="一般偏下">一般偏下</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">申请理由</label>
                        <textarea name="reason" class="form-control" rows="3" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">提交申请</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
