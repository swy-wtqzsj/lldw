package com.salmon.pet.controller;

import com.salmon.pet.entity.Material;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.MaterialService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
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
    @PostMapping("/save")
    public String save(Material material, HttpSession session) {
        if (!materialService.add(material)) {
            session.setAttribute("adminMaterialMsg", "新增失败，请检查名称、类别、单位、数量和预警阈值");
            return "redirect:/admin/material/add";
        }
        session.setAttribute("adminMaterialMsg", "物资「" + material.getName() + "」已新增");
        return "redirect:/admin/material/list";
    }

    /**
     * 编辑物资页面
     */
    @RequestMapping("/edit")
    public String edit(@RequestParam Integer materialId, Model model) {
        Material material = materialService.getById(materialId);
        if (material == null) {
            return "redirect:/admin/material/list";
        }
        model.addAttribute("material", material);
        return "admin/material_form";
    }

    /**
     * 更新物资
     */
    @PostMapping("/update")
    public String update(Material material, HttpSession session) {
        session.setAttribute("adminMaterialMsg", materialService.update(material)
                ? "物资信息已更新" : "更新失败，请检查填写内容或确认物资仍存在");
        return "redirect:/admin/material/list";
    }

    /**
     * 删除物资
     */
    @PostMapping("/delete")
    public String delete(@RequestParam Integer materialId, HttpSession session) {
        if (!materialService.delete(materialId)) {
            session.setAttribute("adminMaterialMsg", "删除失败：物资不存在，或仍有库存、出入库流水");
        } else {
            session.setAttribute("adminMaterialMsg", "物资已删除");
        }
        return "redirect:/admin/material/list";
    }

    /**
     * 出入库操作
     */
    @PostMapping("/stock")
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
                session.setAttribute("adminMaterialMsg", "入库失败：物资不存在、数量不合法或库存已达上限");
            }
        } else if (type != null && type == 2) {
            if (materialService.stockOut(materialId, quantity, usageDesc, operator)) {
                session.setAttribute("adminMaterialMsg", "出库成功");
            } else {
                session.setAttribute("adminMaterialMsg", "出库失败：库存不足、数量不合法或用途未填写");
            }
        } else {
            session.setAttribute("adminMaterialMsg", "操作类型不合法");
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
