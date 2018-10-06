package com.wing.common.util;

import com.wing.common.config.annotation.Config;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.util.StringUtils;

import java.io.File;
import java.io.FileInputStream;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.Properties;

/**
 * Created by nijia on 2017/7/1.
 * 配置文件业务管理类 <br>
 * 配置文件的读取
 */

public class ConfigUtil {



    /**读取配置，注入到configVo中
     *
     * @param  configPath 配置文件路径
     * @param  configVo 配置文件vo ，需要与 @Config 配合使用
     *
     * */
    public static void parseConfig(String configPath,Object configVo)throws  Exception{

        if( StringUtils.isEmpty(configPath) || configVo == null ){
            return ;
        }

        Config configAnnotation = configVo.getClass().getAnnotation(Config.class);


        if( configAnnotation == null ){
            return;
        }

        File file = new File(configPath);
        if (!file.exists()) {
            return;
        }

        switch (configAnnotation.type()){
            case XML:loadXml(file,configVo);
            case PROPERTY:loadProperties(file,configVo);
            default:throw new Exception("配置文件没有指定类型,type="+configAnnotation.type());
        }


    }
    private static void loadProperties(File file,Object configVo)throws  Exception{

        try{
            Properties pro = new Properties();
            FileInputStream in = new FileInputStream(file);
            pro.load(in);
            in.close();

            for( Field field:configVo.getClass().getFields() ){
                Config.ConfigAttribute attrAnnotation =  field.getAnnotation(Config.ConfigAttribute.class);
                if( attrAnnotation == null ){
                    continue;
                }
                String key  = attrAnnotation.key();
                Class<?> type = field.getType();
                Object result = null;
                if( Integer.class.isAssignableFrom(type)){
                    result =Integer.valueOf(pro.getProperty(key));
                }else{
                    result =pro.getProperty(key);
                }
                if( !StringUtils.isEmpty(result) ){
                    field.setAccessible(true);
                    field.set(configVo,result);
                    field.setAccessible(false);
                }

            }
        }catch(Exception e){
            LogUtil.error("loadPropertiesError"+e);
            throw new Exception();
        }


    }
    private static void loadXml(File file,Object configVo)throws  Exception{
        SAXReader reader = new SAXReader();
        Document doc;
        try {
            doc = reader.read(file);
            Element root = doc.getRootElement();
            for( Field field:configVo.getClass().getFields() ){
                Config.ConfigAttribute attrAnnotation =  field.getAnnotation(Config.ConfigAttribute.class);
                if( attrAnnotation == null ){
                    continue;
                }
                String rootName = attrAnnotation.xmlElementName();
                String key  = attrAnnotation.key();
                Class<?> type = field.getType();
                Object result = fillElement(root,rootName,key,type);
                if( !StringUtils.isEmpty(result) ){
                    field.setAccessible(true);
                    field.set(configVo,result);
                    field.setAccessible(false);
                }

            }


        }catch (Exception e){
            LogUtil.error("loadXmlError"+e);
            throw new Exception();
        }
    }

    private  static Object fillElement(Element element,String rootName,String key,Class<?> type) throws  Exception{

        if( element == null ){
            return null;
        }

        if(element.getName().equals(rootName)){

            if( Integer.class.isAssignableFrom(type)){
                return XMLUtil.attributeValueInt(element,key);
            }else{
                return XMLUtil.attributeValueString(element,key);
            }

        }
        return fillElement(element.element(rootName),rootName,key,type);

    }


}
