package com.salmon.pet.utils;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * 密码哈希工具：PBKDF2WithHmacSHA256 + 随机盐，替代无盐 MD5。
 *
 * <p>存储格式：{@code pbkdf2$<迭代次数>$<盐Base64>$<哈希Base64>}。
 * 该格式最长约 100 字符，现有 password 字段为 varchar(64)，需要将字段
 * 扩容到 varchar(128)；为兼容历史数据，{@link #matches} 同时识别旧版
 * 32 位 MD5，登录成功后可由业务层自动升级为新格式（平滑迁移）。</p>
 */
public final class PasswordUtils {

    private static final String ALGORITHM = "PBKDF2WithHmacSHA256";
    private static final int ITERATIONS = 120000;
    private static final int SALT_BYTES = 16;
    private static final int KEY_BITS = 256;
    private static final SecureRandom RANDOM = new SecureRandom();

    private PasswordUtils() {}

    /** 生成加盐哈希串。 */
    public static String encode(String rawPassword) {
        byte[] salt = new byte[SALT_BYTES];
        RANDOM.nextBytes(salt);
        byte[] hash = pbkdf2(rawPassword, salt, ITERATIONS, KEY_BITS);
        return "pbkdf2$" + ITERATIONS + "$"
                + Base64.getEncoder().encodeToString(salt) + "$"
                + Base64.getEncoder().encodeToString(hash);
    }

    /**
     * 校验明文密码与存储值是否匹配。
     * 兼容旧版无盐 MD5（32 位十六进制），便于存量账号平滑迁移。
     */
    public static boolean matches(String rawPassword, String stored) {
        if (rawPassword == null || stored == null) {
            return false;
        }
        if (stored.startsWith("pbkdf2$")) {
            try {
                String[] parts = stored.split("\\$");
                // pbkdf2$<iterations>$<salt>$<hash>
                int iterations = Integer.parseInt(parts[1]);
                byte[] salt = Base64.getDecoder().decode(parts[2]);
                byte[] expected = Base64.getDecoder().decode(parts[3]);
                byte[] actual = pbkdf2(rawPassword, salt, iterations, expected.length * 8);
                return MessageDigest.isEqual(expected, actual);
            } catch (Exception e) {
                return false;
            }
        }
        // 历史 MD5 兼容
        return stored.equals(MD5Utils.md5(rawPassword));
    }

    /** 判断存储值是否为需要升级的旧版 MD5。 */
    public static boolean needsUpgrade(String stored) {
        return stored != null && !stored.startsWith("pbkdf2$");
    }

    private static byte[] pbkdf2(String raw, byte[] salt, int iterations, int keyBits) {
        try {
            PBEKeySpec spec = new PBEKeySpec(raw.toCharArray(), salt, iterations, keyBits);
            SecretKeyFactory factory = SecretKeyFactory.getInstance(ALGORITHM);
            byte[] hash = factory.generateSecret(spec).getEncoded();
            spec.clearPassword();
            return hash;
        } catch (Exception e) {
            throw new RuntimeException("密码哈希计算失败", e);
        }
    }
}
