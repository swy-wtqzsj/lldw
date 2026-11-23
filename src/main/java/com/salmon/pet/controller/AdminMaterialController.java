package com.salmon.pet.controller;

import com.salmon.pet.entity.Material;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.MaterialService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 后台物资管理控制器
 */
@Controller
@RequestMapping("/admin/material")
public class AdminMaterialController {

    @Autowired
    private MaterialService materialService;

    /**
     * 物资列表（分页 + 类别/关键字筛选）
     */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer category,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(defaultValue = "1") Integer pageNum,
                       Model model) {
        PageHelper.startPage(pageNum, 10);
        List<Material> list = materialService.getList(category, keyword);
        PageInfo<Material> pageInfo = new PageInfo<>(list);
        model.addAttribute("list", list);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("category", category);
        model.addAttribute("keyword", keyword);
        return "admin/material_list";
    }

    /**
     * 新增物资页面
     */
    @RequestMapping("/add")
    public String add() {
        return "admin/material_form";
    }

    /**
     * 保存物资
     */
    @RequestMapping("/save")
    public String save(Material material, HttpSession session) {
        if (material.getName() == null || material.getName().trim().isEmpty()) {
            session.setAttribute("adminMaterialMsg", "物资名称不能为空");
            return "redirect:/admin/material/add";
        }
        materialService.add(material);
        session.setAttribute("adminMaterialMsg", "物资「" + material.getName() + "」已新增");
        return "redirect:/admin/material/list";
    }

    /**
     * 编辑物资页面
     */
    @RequestMapping("/edit")
    public String edit(@RequestParam Integer materialId, Model model) {
        model.addAttribute("material", materialService.getById(materialId));
        return "admin/material_form";
    }

    /**
     * 更新物资
     */
    @RequestMapping("/update")
    public String update(Material material, HttpSession session) {
        materialService.update(material);
        session.setAttribute("adminMaterialMsg", "物资信息已更新");
        return "redirect:/admin/material/list";
    }

    /**
     * 删除物资
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam Integer materialId, HttpSession session) {
        if (!materialService.delete(materialId)) {
            session.setAttribute("adminMaterialMsg", "该物资存在出入库流水，不能删除");
        } else {
            session.setAttribute("adminMaterialMsg", "物资已删除");
        }
        return "redirect:/admin/material/list";
    }

    /**
     * 出入库操作
     */
    @RequestMapping("/stock")
    public String stock(@RequestParam Integer materialId,
                        @RequestParam Integer type,
                        @RequestParam Integer quantity,
                        @RequestParam(required = false) String usageDesc,
                        HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        String operator = loginUser == null ? "管理员" : loginUser.getUsername();

        if (type != null && type == 1) {
            if (materialService.stockIn(materialId, quantity, operator)) {
                session.setAttribute("adminMaterialMsg", "入库成功");
            } else {
                session.setAttribute("adminMaterialMsg", "入库失败，请检查数量");
            }
        } else {
            if (materialService.stockOut(materialId, quantity, usageDesc, operator)) {
                session.setAttribute("adminMaterialMsg", "出库成功");
            } else {
                session.setAttribute("adminMaterialMsg", "出库失败，库存不足或数量不合法");
            }
        }
        return "redirect:/admin/material/list";
    }

    /**
     * 物资流水
     */
    @RequestMapping("/records")
    public String records(@RequestParam Integer materialId, Model model) {
        model.addAttribute("material", materialService.getById(materialId));
        model.addAttribute("list", materialService.getRecords(materialId));
        return "admin/material_record_list";
    }

    /**
     * 最近流水
     */
    @RequestMapping("/recent")
    public String recent(Model model) {
        model.addAttribute("list", materialService.getRecentRecords(50));
        return "admin/material_record_list";
    }
}
