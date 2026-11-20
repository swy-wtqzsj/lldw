package com.salmon.pet.utils;

import javax.el.ELContext;
import javax.el.ELResolver;
import java.beans.FeatureDescriptor;
import java.util.Iterator;

/**
 * 全局输出转义 ELResolver。
 *
 * <p>注册到 JSP 的 ELResolver 链后，页面中所有 ${...} 求值得到的字符串都会
 * 先经过 HTML 转义再输出，从根源上防御存储型与反射型 XSS。</p>
 *
 * <p>实现要点：本 Resolver 由 JspApplicationContext#addELResolver 注册，位于
 * ImplicitObjectELResolver 之后、标准 Resolver 之前。因此在他被调用时需要委托
 * 标准链解析出原始值，再对字符串结果转义。为避免委托调用再次进入本 Resolver
 * 形成死循环，使用 ThreadLocal 标记做一次性跳过。</p>
 */
public class XssELResolver extends ELResolver {

    /** 委托解析期间的跳过标记，防止递归调用自身。 */
    private static final ThreadLocal<Boolean> DELEGATING = new ThreadLocal<Boolean>();

    @Override
    public Object getValue(ELContext context, Object base, Object property) {
        if (property == null || context == null) {
            return null;
        }
        // 委托调用进入时直接放行，让链中后续的标准 Resolver 完成解析
        if (Boolean.TRUE.equals(DELEGATING.get())) {
            return null;
        }
        // 已被前置 Resolver（如隐式对象）解析，不重复处理
        if (context.isPropertyResolved()) {
            return null;
        }
        DELEGATING.set(Boolean.TRUE);
        Object value;
        try {
            value = context.getELResolver().getValue(context, base, property);
        } finally {
            DELEGATING.remove();
        }
        if (value instanceof String) {
            return escapeXml((String) value);
        }
        return value;
    }

    /**
     * HTML/XML 转义，覆盖 &amp; &lt; &gt; &quot; &apos; 五个字符。
     */
    public static String escapeXml(String input) {
        if (input == null) {
            return null;
        }
        StringBuilder sb = new StringBuilder(input.length() + 16);
        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            switch (c) {
                case '&':  sb.append("&amp;");  break;
                case '<':  sb.append("&lt;");   break;
                case '>':  sb.append("&gt;");   break;
                case '"':  sb.append("&quot;"); break;
                case '\'': sb.append("&#39;");  break;
                default:   sb.append(c);
            }
        }
        return sb.toString();
    }

    @Override
    public Class<?> getType(ELContext context, Object base, Object property) {
        return null;
    }

    @Override
    public void setValue(ELContext context, Object base, Object property, Object value) {
        // 只读转义，不拦截赋值
    }

    @Override
    public boolean isReadOnly(ELContext context, Object base, Object property) {
        return false;
    }

    @Override
    public Iterator<FeatureDescriptor> getFeatureDescriptors(ELContext context, Object base) {
        return null;
    }

    @Override
    public Class<?> getCommonPropertyType(ELContext context, Object base) {
        return Object.class;
    }
}
