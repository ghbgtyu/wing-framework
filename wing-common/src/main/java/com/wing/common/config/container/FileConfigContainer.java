package com.wing.common.config.container;


import com.wing.common.config.interfaces.IStaticConfigHandler;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by nijia on 2017/9/4.
 */
public class FileConfigContainer extends AbsConfigContainer<IStaticConfigHandler<File,Object>> {


    /**配置文件目录*/
    private String dirctory;

    private Map<String,IStaticConfigHandler<File,Object>> handlerMap = new HashMap<>();

    /**存放解析后的配置*/
    private Map<Class,Object> entityMap = new HashMap<>();


    /**需要检索哪些配置文件类型
     *
     *
     * */
    private Map<String,String> typeMap = new HashMap<>();

    /**
     * @param dirctory 配置文件目录
     * @throws Exception
     */
    public FileConfigContainer(String dirctory) throws  Exception{
        this.dirctory = dirctory;


    }


    private void getFileAll(File file,List<File>fileList) throws  Exception{
        if( file == null ){
            return;
        }
        if(file.isDirectory()){

            File[]fileArray = file.listFiles();
            if(fileArray == null){
                return;
            }

            for(File f:fileArray){
                this.getFileAll(f,fileList);
            }
        }else{
            String fileName = file.getName();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            if(this.typeMap.containsKey(suffix)){
                fileList.add(file);
            }

        }
    }


    @Override
    public void registerHandler(IStaticConfigHandler<File,Object> handler) {

        this.handlerMap.put(handler.getFileName()+"."+handler.getType(),handler);
        this.typeMap.put(handler.getType(),handler.getType());
    }


    @Override
    public void parseStart() throws Exception{

        ResourceLoader resourceLoader = new DefaultResourceLoader();
        Resource resource = resourceLoader.getResource(this.dirctory);

        File file = resource.getFile();
        List<File>fileList = new ArrayList<>();
        this.getFileAll(file,fileList);
        for( File f:fileList ){
            IStaticConfigHandler<File,Object> h = handlerMap.get(f.getName());
            if( h!=null ){
                Object obj = h.parse(f);
                entityMap.put(obj.getClass().getClass(),obj);
            }
        }
    }

    @Override
    public <E> E get(Class<E> e) {

        Object value = entityMap.get(e.getClass());
        if( value == null ){
            return null;
        }

        return (E)value;
    }

    @Override
    public void reload() throws Exception{
        this.parseStart();
    }

}
