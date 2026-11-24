package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Material;
import com.salmon.pet.mapper.MaterialMapper;
import com.salmon.pet.mapper.MaterialRecordMapper;
import org.junit.Test;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;
import java.util.concurrent.atomic.AtomicInteger;

import static org.junit.Assert.*;

public class MaterialServiceImplTest {

    @Test
    public void failedStockUpdateDoesNotCreateLedgerEntry() throws Exception {
        AtomicInteger records = new AtomicInteger();
        MaterialServiceImpl service = service((proxy, method, args) -> {
            if (method.getName().equals("selectById")) return new Material();
            if (method.getName().equals("increaseStock")) return 0;
            return defaultValue(method.getReturnType());
        }, (proxy, method, args) -> {
            if (method.getName().equals("insert")) records.incrementAndGet();
            return defaultValue(method.getReturnType());
        });

        assertFalse(service.stockIn(1, 5, "admin"));
        assertEquals(0, records.get());
        assertEquals("捐赠失败，物资不存在或库存已达上限",
                service.donate(1, null, null, 5, null, "捐赠人", "user"));
        assertEquals(0, records.get());
    }

    @Test
    public void invalidMaterialCannotBeInserted() throws Exception {
        AtomicInteger inserts = new AtomicInteger();
        MaterialServiceImpl service = service((proxy, method, args) -> {
            if (method.getName().equals("insert")) inserts.incrementAndGet();
            return defaultValue(method.getReturnType());
        }, (proxy, method, args) -> defaultValue(method.getReturnType()));
        Material material = new Material();
        material.setName("猫粮");
        material.setCategory(1);
        material.setUnit("袋");
        material.setWarnThreshold(5);
        material.setQuantity(-3);

        assertFalse(service.add(material));
        assertEquals(0, inserts.get());
    }

    @Test
    public void stockOutRequiresTraceableUsage() throws Exception {
        AtomicInteger updates = new AtomicInteger();
        MaterialServiceImpl service = service((proxy, method, args) -> {
            if (method.getName().equals("decreaseStock")) updates.incrementAndGet();
            return defaultValue(method.getReturnType());
        }, (proxy, method, args) -> defaultValue(method.getReturnType()));

        assertFalse(service.stockOut(1, 2, "  ", "admin"));
        assertEquals(0, updates.get());
    }

    private MaterialServiceImpl service(InvocationHandler materialHandler,
                                        InvocationHandler recordHandler) throws Exception {
        MaterialServiceImpl service = new MaterialServiceImpl();
        setField(service, "materialMapper", proxy(MaterialMapper.class, materialHandler));
        setField(service, "materialRecordMapper", proxy(MaterialRecordMapper.class, recordHandler));
        return service;
    }

    private <T> T proxy(Class<T> type, InvocationHandler handler) {
        return type.cast(Proxy.newProxyInstance(type.getClassLoader(), new Class<?>[]{type}, handler));
    }

    private void setField(Object target, String name, Object value) throws Exception {
        Field field = target.getClass().getDeclaredField(name);
        field.setAccessible(true);
        field.set(target, value);
    }

    private Object defaultValue(Class<?> type) {
        if (type == int.class) return 0;
        if (type == boolean.class) return false;
        return null;
    }
}
