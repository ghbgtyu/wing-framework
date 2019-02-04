package com.mokylin.cabal.modules.bus.dao;

import com.mokylin.cabal.common.persistence.BaseDao;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.persistence.Parameter;
import com.mokylin.cabal.common.utils.DateUtils;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.modules.bus.entity.BusFile;
import com.mokylin.cabal.modules.sys.entity.Log;
import com.mokylin.cabal.modules.sys.entity.Role;
import org.apache.commons.lang3.ObjectUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.Map;

/**
 * Created by nijia on 2018/12/2.
 */
@Repository
public class BusFileDao extends BaseDao<BusFile> {


    /**
     * 获取所有未归档的合同
     **/
    public Page<BusFile> loadBusFileAllAsEdit() {


        return this.find(new Page<BusFile>(), "from BusFile where delFlag = :p1 and state = :p2 ",
                new Parameter(Role.DEL_FLAG_NORMAL, 0));


//delFlag = :p1  and name = :p2", new Parameter(Role.DEL_FLAG_NORMAL, name)
//      return  this.findBySql(new Page<BusFile>(),"select * from bus_file where del_flag = :del_flag and state = :state ",
//              new Parameter(new Object[][]{{"del_flag", Role.DEL_FLAG_NORMAL}, {"state", "0"}}));

    }

    /**
     * 获取所有归档的合同
     **/
    public Page<BusFile> loadBusFileAll() {


        return this.find(new Page<BusFile>(), "from BusFile where delFlag = :p1 and state = :p2 ",
                new Parameter(Role.DEL_FLAG_NORMAL, 1));


//delFlag = :p1  and name = :p2", new Parameter(Role.DEL_FLAG_NORMAL, name)
//      return  this.findBySql(new Page<BusFile>(),"select * from bus_file where del_flag = :del_flag and state = :state ",
//              new Parameter(new Object[][]{{"del_flag", Role.DEL_FLAG_NORMAL}, {"state", "0"}}));

    }

    public Page<BusFile> loadBusFileAll(Map<String, Object> paramMap) {

        DetachedCriteria dc = this.createDetachedCriteria();


        String fileContent = ObjectUtils.toString(paramMap.get("file-content"));
        if (StringUtils.isNotBlank(fileContent)) {
            dc.add(Restrictions.like("content", "%" + fileContent + "%"));
        }
        String fileId = ObjectUtils.toString(paramMap.get("file-fileId"));
        if (StringUtils.isNotBlank(fileId)) {
            dc.add(Restrictions.like("fileId", "%" + fileId + "%"));
        }

        dc.add(Restrictions.eq("delFlag", Role.DEL_FLAG_NORMAL));
        dc.add(Restrictions.eq("state", 1));
        Date beginDate = DateUtils.parseDate(paramMap.get("beginDate"));
        if (beginDate == null) {
            beginDate = DateUtils.setDays(new Date(), 1);
            paramMap.put("beginDate", DateUtils.formatDate(beginDate, "yyyy-MM-dd"));
        }
        Date endDate = DateUtils.parseDate(paramMap.get("endDate"));
        if (endDate == null) {
            endDate = DateUtils.addDays(DateUtils.addMonths(beginDate, 1), -1);
            paramMap.put("endDate", DateUtils.formatDate(endDate, "yyyy-MM-dd"));
        }
        dc.add(Restrictions.between("createDate", beginDate, endDate));

        dc.addOrder(Order.desc("createDate"));

        return this.find(new Page<BusFile>(), dc);
    }
}
