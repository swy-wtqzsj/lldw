<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty pet ? '新增宠物' : '编辑宠物'}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/admin/dashboard">后台管理</a>
    </div>
</nav>

<div class="container mt-4">
    <h3>${empty pet ? '新增宠物' : '编辑宠物'}</h3>

    <form action="${empty pet ? '/pet-adoption/admin/pet/save' : '/pet-adoption/admin/pet/update'}" method="post">
        <c:if test="${not empty pet}">
            <input type="hidden" name="petId" value="${pet.petId}">
        </c:if>

        <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label">宠物名称</label>
                <input type="text" name="petName" class="form-control" value="${pet.petName}" required>
            </div>
            <div class="col-md-6">
                <label class="form-label">种类</label>
                <select name="species" class="form-select">
                    <option value="1" ${pet.species == 1 ? 'selected' : ''}>猫</option>
                    <option value="2" ${pet.species == 2 ? 'selected' : ''}>狗</option>
                </select>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label">品种</label>
                <input type="text" name="breed" class="form-control" value="${pet.breed}">
            </div>
            <div class="col-md-6">
                <label class="form-label">性别</label>
                <select name="gender" class="form-select">
                    <option value="0" ${pet.gender == 0 ? 'selected' : ''}>未知</option>
                    <option value="1" ${pet.gender == 1 ? 'selected' : ''}>公</option>
                    <option value="2" ${pet.gender == 2 ? 'selected' : ''}>母</option>
                </select>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label">年龄段</label>
                <select name="ageStage" class="form-select">
                    <option value="1" ${pet.ageStage == 1 ? 'selected' : ''}>幼年</option>
                    <option value="2" ${pet.ageStage == 2 ? 'selected' : ''}>成年</option>
                    <option value="3" ${pet.ageStage == 3 ? 'selected' : ''}>老年</option>
                </select>
            </div>
            <div class="col-md-6">
                <label class="form-label">封面照片路径</label>
                <input type="text" name="photo" class="form-control" value="${pet.photo}">
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label">是否绝育</label>
                <select name="isNeutered" class="form-select">
                    <option value="0" ${pet.isNeutered == 0 ? 'selected' : ''}>未绝育</option>
                    <option value="1" ${pet.isNeutered == 1 ? 'selected' : ''}>已绝育</option>
                </select>
            </div>
            <div class="col-md-6">
                <label class="form-label">是否疫苗</label>
                <select name="isVaccinated" class="form-select">
                    <option value="0" ${pet.isVaccinated == 0 ? 'selected' : ''}>未疫苗</option>
                    <option value="1" ${pet.isVaccinated == 1 ? 'selected' : ''}>已疫苗</option>
                </select>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">健康状况</label>
            <input type="text" name="healthStatus" class="form-control" value="${pet.healthStatus}">
        </div>

        <div class="mb-3">
            <label class="form-label">详细介绍</label>
            <textarea name="description" class="form-control" rows="4">${pet.description}</textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">领养状态</label>
            <select name="adoptStatus" class="form-select">
                <option value="1" ${pet.adoptStatus == 1 ? 'selected' : ''}>待审核</option>
                <option value="2" ${pet.adoptStatus == 2 ? 'selected' : ''}>待领养</option>
                <option value="3" ${pet.adoptStatus == 3 ? 'selected' : ''}>审核中</option>
                <option value="4" ${pet.adoptStatus == 4 ? 'selected' : ''}>已被领养</option>
                <option value="5" ${pet.adoptStatus == 5 ? 'selected' : ''}>退养回流</option>
                <option value="6" ${pet.adoptStatus == 6 ? 'selected' : ''}>暂停展示</option>
                <option value="7" ${pet.adoptStatus == 7 ? 'selected' : ''}>已归档</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">保存</button>
        <a href="/pet-adoption/admin/pet/list" class="btn btn-outline-secondary">返回</a>
    </form>
</div>
</body>
</html>
