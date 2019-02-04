package com.mokylin.cabal.common.persistence;

import com.mokylin.cabal.common.game.api.GameTemplate;
import com.mokylin.cabal.common.persistence.dynamicDataSource.LookupContext;
import com.mokylin.cabal.common.test.SpringTransactionalContextTests;
import com.mokylin.cabal.modules.tools.entity.GameEmail;
import com.mokylin.cabal.modules.tools.entity.GameNotice;
import com.mokylin.cabal.modules.tools.entity.Recharge;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class GameTemplateTest extends SpringTransactionalContextTests {
    private static final Logger logger = LoggerFactory.getLogger(GameTemplateTest.class);

    @Resource
    private GameTemplate gameTemplate;

    @Test
    public void testAddAnnounce() {
        GameNotice gameNotice = new GameNotice();
        gameNotice.setContent("测试公告添加");
        gameNotice.setCreateBy("创建者1");
        gameNotice.setCreateDate(new Date());
        gameNotice.setCreateName("wrtgb");
        gameNotice.setDelFlag("0");
        gameNotice.setFinishTime(new Date());
        gameNotice.setGamePlatformId("0");
        gameNotice.setId("test1");
        gameNotice.setIsGlobal(0);
        gameNotice.setNoticeStatus("1");
        gameNotice.setNoticeType("1");
        gameNotice.setRepeatCount(3);
        gameNotice.setServerIds("21");
        gameNotice.setStartTime(new Date());
        gameNotice.setStepTime(1);
        gameNotice.setUpdateBy("更新者1");
        gameNotice.setUpdateDate(new Date());
        Result result = gameTemplate.announceOperation().addAnnounce(gameNotice);
        if (result.isSuccess()) {
            logger.info("公告添加成功", gameNotice.getId());
        } else {
            logger.info("公告添加失败", gameNotice.getId());
        }
    }

    @Test
    public void testDeleteAnnounce() {
        GameNotice gameNotice = new GameNotice();
        gameNotice.setId("test1");
        gameNotice.setIsGlobal(0);
        gameNotice.setServerIds("21");
        Result result = gameTemplate.announceOperation().deleteAnnounce(gameNotice);
        if (result.isSuccess()) {
            logger.info("公告删除成功", gameNotice.getId());
        } else {
            logger.info("公告删除失败", gameNotice.getId());
        }
    }

    @Test
    public void testSendEmail() {
        GameEmail gameEmail = new GameEmail();
        gameEmail.setId("mail1");
        gameEmail.setIsGlobal(1);
        gameEmail.setServerIds("21");
        gameEmail.setReceiverUserIds("837518622951,846108559764");
        gameEmail.setTitle("测试邮件发送");
        gameEmail.setContent("这是一封测试邮件");
        gameEmail.setJb(23);
        gameEmail.setYb(54);
        gameEmail.setAttachments("");
        gameEmail.setDelayHours(1);
        Result result = gameTemplate.gameEmailOperation().sendEmail(gameEmail);
        if (result.isSuccess()) {
            logger.info("邮件发送成功", gameEmail.getId());
        } else {
            logger.info("邮件发送失败", gameEmail.getId());
        }
    }

    @Test
    public void testRecharge() {
        List<Recharge> rechargeList = new ArrayList<Recharge>();
        for (int i = 0; i < 3; i++) {
            Recharge recharge = new Recharge();
            recharge.setId("" + i);
            recharge.setRoleIds("837518622951,846108559764");
            recharge.setRechargeType("0");
            recharge.setMoneyType("1");
            recharge.setMoneyNum(23);
            recharge.setServerId("21");
            rechargeList.add(recharge);
        }
        Result result = gameTemplate.treasureOperation().recharge(rechargeList);
        if (result.isSuccess()) {
            logger.info("充值成功");
        } else {
            logger.info("充值失败");
        }
    }

    @Test
    public void testBatchJinYan() {
        List<String> roleIds = new ArrayList<String>();
        roleIds.add("837518622951");
        LookupContext.setCurrentServerId("21");
        Result result = gameTemplate.roleOperation().batchJinYan(roleIds);
        if (result.isSuccess()) {
            logger.info("禁言成功");
        } else {
            logger.info("禁言失败");
        }
    }

    @Test
    public void testBatchFengHao() {
        List<String> roleIds = new ArrayList<String>();
        roleIds.add("846108559764");
        LookupContext.setCurrentServerId("21");
        Result result = gameTemplate.roleOperation().batchFenHao(roleIds);
        if (result.isSuccess()) {
            logger.info("封号成功");
        } else {
            logger.info("封号失败");
        }
    }

    @Test
    public void testBatchCancelJinYan() {
        List<String> roleIds = new ArrayList<String>();
        roleIds.add("837518622951");
        LookupContext.setCurrentServerId("21");
        Result result = gameTemplate.roleOperation().batchCancelJinYan(roleIds);
        if (result.isSuccess()) {
            logger.info("取消禁言成功");
        } else {
            logger.info("取消禁言失败");
        }
    }

    @Test
    public void testBatchCancelFenHao() {
        List<String> roleIds = new ArrayList<String>();
        roleIds.add("846108559764");
        LookupContext.setCurrentServerId("21");
        Result result = gameTemplate.roleOperation().batchCancelFenHao(roleIds);
        if (result.isSuccess()) {
            logger.info("取消封号成功");
        } else {
            logger.info("取消封号失败");
        }
    }

    @Test
    public void testUpdateRoleType() {
        //调用游戏接口，更新角色类型，O、普通玩家 2、指导员 1、GM
        //第一个参数为serverId，第二个参数为roleId，第三个参数为角色类型
        gameTemplate.roleOperation().updateRoleType("21", "837518622951", "2");
    }

    @Test
    public void testChatMonitor() {
        List<String> serverIdList = new ArrayList<String>();
        serverIdList.add("21");
        Result result = gameTemplate.monitorOperation().chatMonitor(serverIdList);
        if (result.isSuccess()) {
            logger.info("监控成功");
        } else {
            logger.info("监控失败");
        }
    }

    @Test
    public void testCancelMonitor() {
        List<String> serverIdList = new ArrayList<String>();
        serverIdList.add("21");
        Result result = gameTemplate.monitorOperation().cancelMonitor(serverIdList);
        if (result.isSuccess()) {
            logger.info("取消监控成功");
        } else {
            logger.info("取消监控失败");
        }
    }


}
