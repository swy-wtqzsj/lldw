package com.salmon.pet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * 后台图片上传控制器
 */
@Controller
@RequestMapping("/admin/upload")
public class UploadController {

    private static final List<String> ALLOWED_EXT =
            Arrays.asList("jpg", "jpeg", "png", "gif", "webp");

    @PostMapping
    @ResponseBody
    public Map<String, Object> upload(@RequestParam("file") MultipartFile file,
                                      HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        if (file == null || file.isEmpty()) {
            result.put("code", 1);
            result.put("msg", "请选择要上传的图片");
            return result;
        }

        String original = file.getOriginalFilename();
        String ext = "";
        if (original != null && original.contains(".")) {
            ext = original.substring(original.lastIndexOf('.') + 1).toLowerCase();
        }
        if (!ALLOWED_EXT.contains(ext)) {
            result.put("code", 1);
            result.put("msg", "仅支持 jpg/jpeg/png/gif/webp 格式");
            return result;
        }

        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            result.put("code", 1);
            result.put("msg", "文件类型不是图片");
            return result;
        }

        try {
            String relativeDir = "/static/uploads";
            String realDir = request.getServletContext().getRealPath(relativeDir);
            File dir = new File(realDir);
            if (!dir.exists() && !dir.mkdirs()) {
                result.put("code", 1);
                result.put("msg", "上传目录创建失败");
                return result;
            }

            String fileName = UUID.randomUUID().toString().replace("-", "") + "." + ext;
            File dest = new File(dir, fileName);
            file.transferTo(dest);

            result.put("code", 0);
            result.put("url", relativeDir + "/" + fileName);
            return result;
        } catch (Exception e) {
            result.put("code", 1);
            result.put("msg", "图片保存失败");
            return result;
        }
    }
}
