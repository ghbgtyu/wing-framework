package com.wing.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.rmi.ServerException;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;


/**
 * @author Guilong Jiang
 */
public class XMLUtil {
	public static boolean saveXML(Element ele, String sFilePathName) throws Exception {
		return saveXML(ele, sFilePathName, "UTF-8");
	}

	/**
	 * save xml to file with special encode
	 * 
	 * @param ele
	 * @param sFilePathName
	 * @param encode XMLUtil.ENCODE_UTF_8 or XMLUtil.ENCODE_GBK, default is
	 *            former
	 * @return
	 * @throws ServerException
	 */
	public static boolean saveXML(Element ele, String sFilePathName, String encode) throws Exception {

		Document dom = ele.getDocument();
		if (dom == null) {
			dom = DocumentHelper.createDocument(ele);
		}
		return saveXML(dom, sFilePathName, encode);
	}

	/**
	 * save xml to file with special encode
	 * 
	 * @param dom
	 * @param sFilePathName
	 * @param encode XMLUtil.ENCODE_UTF_8 or XMLUtil.ENCODE_GBK, default is
	 *            former
	 * @return
	 * @throws ServerException
	 */
	public static boolean saveXML(Document dom, String sFilePathName, String encode) throws Exception {

		File file = new File(sFilePathName);
		File parent = file.getParentFile();
		if (!parent.exists()) {
			parent.mkdirs();
		}

		try {
			OutputFormat format = OutputFormat.createPrettyPrint();
			FileOutputStream out = new FileOutputStream(file);
			// if(!encode.equals(ENCODE_UTF_8)){
			format.setEncoding(encode);
			XMLWriter xmlWriter = new XMLWriter(out, format);
			xmlWriter.write(dom);
			xmlWriter.flush();
			xmlWriter.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
		return true;
	}

	public static Document loadFromFile(String sFilePathName) throws Exception {
		InputStream is = null;
		try {
			is = new FileInputStream(sFilePathName);
		} catch (FileNotFoundException e) {
			throw new Exception("load file '" + sFilePathName + "' failed " + e.getMessage());
		}
		return loadDocument(is);
	}

	public static Document loadDocument(InputStream is) throws Exception {
		SAXReader rd = new SAXReader();
		Document document = null;
		try {
			document = rd.read(is);
		} catch (Exception e) {
			throw new Exception("parsing document failed:" + e.getMessage());
		}
		return document;
	}

	public static int attributeValueInt(Element element, String attr) throws Exception {
		if (element == null) {
			throw new Exception("element == null");
		}
		String value = element.attributeValue(attr);
		if (value == null) {
			throw new Exception(String.format("缺少属性%s: %s", attr, element.asXML()));
		}
		try {
			return Integer.parseInt(value);
		} catch (NumberFormatException e) {
			throw new Exception(String.format("属性%s不是数值类型: %s", attr, element.asXML()));
		}
	}

	public static float attributeValueFloat(Element element, String attr) throws Exception {
		if (element == null) {
			throw new Exception("element == null");
		}
		String value = element.attributeValue(attr);
		if (value == null) {
			throw new Exception(String.format("缺少属性%s: %s", attr, element.asXML()));
		}
		try {
			return Float.parseFloat(value);
		} catch (NumberFormatException e) {
			throw new Exception(String.format("属性%s不是数值类型: %s", attr, element.asXML()));
		}
	}

	public static int attributeValueInt(Element element, String attr, int defaultValue) throws Exception {
		if (element == null) {
			throw new Exception("element == null");
		}
		String value = element.attributeValue(attr);
		if (value == null) {
			return defaultValue;
		}
		try {
			return Integer.parseInt(value);
		} catch (NumberFormatException e) {
			throw new Exception(String.format("属性%s不是数值类型: %s", attr, element.asXML()));
		}
	}

	public static String attributeValueString(Element element, String attr) throws Exception {
		if (element == null) {
			throw new Exception("element == null");
		}
		String value = element.attributeValue(attr);
		if (value == null) {
			throw new Exception(String.format("缺少属性%s: %s", attr, element.asXML()));
		}
		return value;
	}

	public static String attributeValueString(Element element, String attr, String defaultValue) throws Exception {
		if (element == null) {
			throw new Exception("element == null");
		}
		String value = element.attributeValue(attr);
		if (value == null) {
			return defaultValue;
		}
		return value;
	}

	public static boolean attributeValueBoolean(Element element, String attr, boolean defaultValue) throws Exception {
		if (element == null) {
			throw new Exception("element == null");
		}
		String value = element.attributeValue(attr);
		if (value == null) {
			return defaultValue;
		}
		try {
			return Boolean.parseBoolean(value);
		} catch (NumberFormatException e) {
			throw new Exception(String.format("属性%s不是布尔类型: %s", attr, element.asXML()));
		}
	}

	public static boolean attributeValueBoolean(Element element, String attr) throws Exception {
		if (element == null) {
			throw new Exception("element == null");
		}
		String value = element.attributeValue(attr);
		if (value == null) {
			throw new Exception(String.format("缺少属性%s: %s", attr, element.asXML()));
		}
		try {
			return Boolean.parseBoolean(value);
		} catch (NumberFormatException e) {
			throw new Exception(String.format("属性%s不是布尔类型: %s", attr, element.asXML()));
		}
	}

	public static Element subElement(Element parent, String name) throws Exception {
		if (parent == null) {
			throw new Exception("parent == null");
		}
		Element result = parent.element(name);
		if (result == null) {
			throw new Exception(String.format("找不到%s节点的子节点%s", parent.getName(), name));
		}
		return result;
	}

	public static Element parseText(String content)throws Exception  {
		Element ret = null;
		try {
			Document doc = DocumentHelper.parseText(content);
			ret = doc.getRootElement(); // 获取根节点
		} catch (DocumentException e) {
			throw new Exception("parsing content failed:" + e.getMessage());
		}
		return ret;
	}
}
