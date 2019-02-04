package com.mokylin.cabal.modules.bus.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Lists;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.service.BaseService;
import com.mokylin.cabal.modules.bus.dao.BusFileDao;
import com.mokylin.cabal.modules.bus.entity.BusFile;
import com.mokylin.cabal.modules.sys.entity.User;
import com.mokylin.cabal.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by nijia on 2018/12/2.
 */
@Service
@Transactional(readOnly = true)
public class BusFileService extends BaseService {

    @Autowired
    private BusFileDao fileDao;


    public boolean upload() {
        User user = UserUtils.getUser();

        return false;
    }

    public Page<BusFile> loadBusFileAll() {

        return fileDao.loadBusFileAllAsEdit();


    }

    public Page<BusFile> loadBusFileAll2() {

        return fileDao.loadBusFileAll();


    }

    @Transactional(readOnly = false)
    public void editBusFile(BusFile busFile) {

        BusFile updateFile = findBusFileById(busFile.getId());
        updateFile.setContent(busFile.getContent());
        updateFile.setUploadDesc(busFile.getUploadDesc());
        updateFile.setFileId(busFile.getFileId());
        fileDao.save(updateFile);

    }

    @Transactional(readOnly = false)
    public void saveBusFile(BusFile busFile) {

        fileDao.save(busFile);

    }

    @Transactional(readOnly = false)
    public void createBusFile(BusFile busFile) {

        User user = UserUtils.getUser();
        busFile.setCreateDate(new Date());

        busFile.setDocFileJsonPath(new JSONArray().toJSONString());
        busFile.setOtherFileJsonPath(new JSONArray().toJSONString());
        busFile.setPictureFileJsonPath(new JSONArray().toJSONString());

        fileDao.clear();
        fileDao.save(busFile);

    }

    @Transactional(readOnly = false)
    public void deleteFileById(String id) {

        fileDao.deleteById(id);

    }

    @Transactional(readOnly = false)
    public void removeFileById(String id) {
        BusFile updateFile = findBusFileById(id);
        updateFile.setState(0);
        fileDao.clear();
        fileDao.save(updateFile);


    }

    @Transactional(readOnly = false)
    public BusFile findBusFileById(String id) {


        return fileDao.get(id);

    }

    @Transactional(readOnly = false)
    public void saveFileById(String id) {
        BusFile updateFile = findBusFileById(id);
        updateFile.setState(1);
        fileDao.clear();
        fileDao.save(updateFile);
    }

    public Page<BusFile> loadBusFileAll2(Map<String, Object> paramMap) {

        return fileDao.loadBusFileAll(paramMap);
    }
}
