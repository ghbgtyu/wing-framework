package com.mokylin.cabal.modules.tools.service;

import com.mokylin.cabal.common.config.Global;
import com.mokylin.cabal.common.persistence.ToolDaoTemplate;
import com.mokylin.cabal.common.utils.AsFileParseUtils;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.utils.WebPathUtil;
import com.mokylin.cabal.modules.tools.entity.ConfigFile;
import com.mokylin.cabal.modules.tools.vo.Goods;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/11/10 18:17
 * 项目: cabal-tools
 */
@Component
public class GoodsAnalyzeService{

    private static final Logger LOG = LoggerFactory.getLogger(GoodsAnalyzeService.class.getName());

    @Resource
    protected ToolDaoTemplate toolDaoTemplate;

    private static final String FILE_TYPE = "goods.jat";

    private static final Map<String, Goods> goodsMap = new HashMap<String, Goods>();

    private List<Goods> xuniGoodsList = new ArrayList<Goods>();


    @PostConstruct
    public void init(){

        try{
            String contextPath = WebPathUtil.getWebContentPath();
            Map<String,Object> parameter = new HashMap<String, Object>();
            parameter.put("fileType",FILE_TYPE);
            ConfigFile configFile = toolDaoTemplate.selectOne("configFile.selectOneByName", parameter);
            //ConfigFile configFile = null;
            if(configFile == null){
                LOG.error("找不到配置文件{}",FILE_TYPE);
                return;
            }
            String filePath = configFile.getFilePath();
            String fileName = configFile.getFileName();
            String fullFileName = contextPath + filePath + fileName;
            List goodsFileDataList = AsFileParseUtils.parse(fullFileName);
            if (CollectionUtils.isEmpty(goodsFileDataList)) {
                LOG.error("物品表{}文件没找到或者文件格式错误", fullFileName);
                return ;
            }
            //Object[] array = (Object[])goodsFileDataList.get(0);
            for (Object object : goodsFileDataList) {
                Map map = (Map)object;
                String id = MapUtils.getString(map, "id");
                String name = MapUtils.getString(map, "name");
                String maxstack = MapUtils.getString(map, "maxstack");
                boolean xuni = MapUtils.getBooleanValue(map, "xuni");
                if (StringUtils.isBlank(id) || StringUtils.isBlank(name)) {
                    continue;
                }
                Goods goods = new Goods(id, name, maxstack);
                goods.setXuniGoods(xuni);
                goods.setGoodsDesc( MapUtils.getString(map, "describe") );

                //是虚拟物品，则加入虚拟物品列表
                if( goods.isXuniGoods() ){
                    xuniGoodsList.add(goods);
                }

                goodsMap.put(goods.getId() , goods);
            }
        }catch (Exception e) {
            LOG.error("解析物品配置文件出错",  e);
        }
    }

    public void refresh(){
        goodsMap.clear();
        xuniGoodsList.clear();
        init();
    }
   

    /** 获取所有物品列表 **/
    public Map<String, Goods> getGoods(){
        return goodsMap;
    }

    /** 获取虚拟物品列表 */
    public List<Goods> getXuniGoodsList(){
        return xuniGoodsList;
    }


    /**
     * 按物品名查找
     */
    public List<Goods> query(String goodsName){
        List<Goods> result = new ArrayList();
        for (Goods goods : this.getGoods().values()) {
            if (StringUtils.contains(goods.getName(), goodsName)){
                result.add(goods);
            }
        }
        return result;
    }
}
