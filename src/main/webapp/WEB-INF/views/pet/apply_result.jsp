<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>申请结果</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body text-center">
                    <h4 class="mb-4">${msg}</h4>
                    <a href="/pet-adoption/pet/my" class="btn btn-primary">查看我的领养</a>
                    <a href="/pet-adoption/pet/list" class="btn btn-outline-secondary">返回领养中心</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
