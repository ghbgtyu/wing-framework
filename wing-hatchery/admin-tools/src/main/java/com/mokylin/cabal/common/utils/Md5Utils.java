package com.mokylin.cabal.common.utils;


import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * @author DaoZheng Yuan
 * @description MD5工具类
 * @created 2010-12-17下午12:52:28
 */
public class Md5Utils {

    /**
     * MD5加密返回32位
     *
     * @param passText
     * @return
     */
    public static String md5To32(String passText) {
        StringBuffer buff = new StringBuffer("");
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(passText.getBytes());
            byte[] bt = md.digest();

            int i;
            for (int offset = 0; offset < bt.length; offset++) {
                i = bt[offset];
                if (i < 0) i += 256;
                if (i < 16) buff.append("0");
                buff.append(Integer.toHexString(i));
            }

            return buff.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * MD5加密返回16
     *
     * @param passText
     * @return
     */
    public static String md5To16(String passText) {
        StringBuffer buff = new StringBuffer("");
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(passText.getBytes());
            byte[] bt = md.digest();

            int i;
            for (int offset = 0; offset < bt.length; offset++) {
                i = bt[offset];
                if (i < 0) i += 256;
                if (i < 16) buff.append("0");
                buff.append(Integer.toHexString(i));
            }
            return buff.toString().substring(8, 24);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        String Str16 = md5To16("admin");
        System.out.println(Str16);
        String Str32 = md5To32("coopname=baidu&serverid=s1&userid=u111&key=3de397e1013&timestamp=1375409569425");
        System.out.println(Str32);
    }

}
