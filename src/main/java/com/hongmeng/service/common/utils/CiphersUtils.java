package com.hongmeng.service.common.utils;

import java.security.MessageDigest;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CiphersUtils {

	static Logger log = LoggerFactory.getLogger(CiphersUtils.class);

	public static CiphersUtils INSTANCE = null;

	public CiphersUtils() {
	}

	public static CiphersUtils getInstance() {
		if (INSTANCE == null) {
			synchronized (CiphersUtils.class) {
				if (INSTANCE == null) {
					INSTANCE = new CiphersUtils();
				}
			}
		}
		return INSTANCE;
	}

	public String MD5Password(String input) {
		String pwdOrigin = decryptPwd(input);
		if (pwdOrigin == null) {
			throw new IllegalArgumentException("decrypt password error!");
		}
		String pwdMD5 = string2MD5(pwdOrigin);
		return pwdMD5;
	}

	/**
	 * MD5加密
	 * 
	 * @param pwd
	 * @return
	 */
	public String string2MD5(String pwd) {
		String salt = ConfigUtils.get("customize.salt");
		pwd = pwd + salt;
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		char[] charArray = pwd.toCharArray();
		byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++)
			byteArray[i] = (byte) charArray[i];
		byte[] md5Bytes = md5.digest(byteArray);
		StringBuffer hexValue = new StringBuffer();
		for (int i = 0; i < md5Bytes.length; i++) {
			int val = ((int) md5Bytes[i]) & 0xff;
			if (val < 16) {
				hexValue.append("0");
			}
			hexValue.append(Integer.toHexString(val));
		}
		return hexValue.toString();
	}

	public String encryptPwd(String pwd) {
		try {
			String key = DateUtils.getNow("yyyyMMdd");
			String ret = encrypt(pwd, key);
			return ret;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return null;
		}
	}

	/**
	 * 对密码进行DES加密
	 * 
	 * @param pwd
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public String encrypt(String pwd, String key) throws Exception {
		byte[] src = pwd.getBytes("UTF-8");
		SecureRandom random = new SecureRandom();
		DESKeySpec desKey = new DESKeySpec(key.getBytes("UTF-8"));
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey securekey = keyFactory.generateSecret(desKey);
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.ENCRYPT_MODE, securekey, random);
		String ret = Base64.encodeBase64String(cipher.doFinal(src));
		return ret;
	}

	public String decryptPwd(String pwd) {
		try {
			String key = DateUtils.getNow("yyyyMMdd");
			String ret = decrypt(pwd, key);
			return ret;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return null;
		}
	}

	/**
	 * 对密码进行DES解密
	 * 
	 * @param pwd
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public String decrypt(String pwd, String key) throws Exception {
		byte[] src = Base64.decodeBase64(pwd);
		SecureRandom random = new SecureRandom();
		DESKeySpec desKey = new DESKeySpec(key.getBytes());
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey securekey = keyFactory.generateSecret(desKey);
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.DECRYPT_MODE, securekey, random);
		return new String(cipher.doFinal(src), "UTF-8");
	}

}