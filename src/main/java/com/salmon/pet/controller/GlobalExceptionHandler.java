package com.salmon.pet.controller;

import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * 全局异常处理：把客户端错误统一转换为 4xx 友好错误页。
 *
 * <p>背景：部分表单接口的必填参数缺失或类型非法时，异常会一路冒泡到容器，
 * 被包装成 500「系统繁忙」，既误导用户也不利于定位。这里只拦截明确的
 * 客户端错误类型（参数缺失、类型不匹配、绑定失败、请求方法不支持），
 * 业务异常与系统异常仍由 web.xml 的 error-page 处理，不会掩盖真实故障。</p>
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    /** 参数缺失 / 类型不匹配 / 表单绑定失败 → 400 */
    @ExceptionHandler({MissingServletRequestParameterException.class,
            MethodArgumentTypeMismatchException.class,
            BindException.class})
    public ModelAndView handleBadRequest(Exception ex, HttpServletRequest request) {
        return errorView(HttpStatus.BAD_REQUEST, "请求参数缺失或格式不正确，请返回后重新提交", request);
    }

    /** 请求方法不支持（如 GET 调用仅允许 POST 的接口）→ 405 */
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ModelAndView handleMethodNotSupported(HttpRequestMethodNotSupportedException ex,
                                                 HttpServletRequest request) {
        return errorView(HttpStatus.METHOD_NOT_ALLOWED, "当前请求方式不被该操作支持", request);
    }

    /**
     * 转发到统一的错误页，并写入状态码供 error.jsp 渲染。
     * 使用 forward 而非 redirect，是为了保留原始状态码且不额外发起请求。
     */
    private ModelAndView errorView(HttpStatus status, String detail, HttpServletRequest request) {
        request.setAttribute("javax.servlet.error.status_code", status.value());
        request.setAttribute("javax.servlet.error.message", detail);
        ModelAndView mv = new ModelAndView("forward:/error.jsp");
        mv.setStatus(status);
        return mv;
    }
}
