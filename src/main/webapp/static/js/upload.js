async function uploadImage(input, fieldId, previewId) {
    var file = input.files && input.files[0];
    if (!file) {
        return;
    }
    var formData = new FormData();
    formData.append('file', file);

    try {
        var response = await fetch(window.APP_CTX + '/admin/upload', {
            method: 'POST',
            body: formData
        });
        var data = await response.json();
        if (!data || data.code !== 0) {
            alert((data && data.msg) || '图片上传失败');
            return;
        }
        var field = document.getElementById(fieldId);
        if (field) {
            field.value = data.url;
        }
        var preview = document.getElementById(previewId);
        if (preview) {
            preview.src = window.APP_CTX + data.url;
            preview.style.display = 'block';
        }
    } catch (e) {
        alert('图片上传失败，请稍后重试');
    }
}
