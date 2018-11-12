package com.mokylin.cabal.common.persistence;

import com.alibaba.fastjson.JSON;
import com.mokylin.cabal.common.test.SpringTransactionalContextTests;
import com.mokylin.cabal.modules.sys.dao.UserDao;
import com.mokylin.cabal.modules.sys.entity.User;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * BaseDaoTest
 * @author 稻草鸟人
 */
public class BaseDaoTest extends SpringTransactionalContextTests {
	
	@Autowired
	private UserDao userDao;

	@Test
	public void find(){
		Page<Object[]> objPage = new Page<Object[]>(1, 3);
		Page<Map<String, Object>> mapPage = new Page<Map<String, Object>>(1, 3);
		Page<User> entityPage = new Page<User>(1, 3);
 
		System.out.print("===== exe hql, return type: Object[] =====\n");
		String qlString = "select u.name, u.office.name as office_name from User u";
		objPage = userDao.find(objPage, qlString);
		for (Object[] o : objPage.getList()) {
			System.out.print(o[0]+", "+o[1]+"\n");
		}
		
		System.out.print("===== exe hql, return type: Map =====\n");
		qlString = "select new map(u.name, u.office.name as office_name) from User u";
		mapPage = userDao.find(mapPage, qlString);
		for (Map<String, Object> o : mapPage.getList()) {
			System.out.print(o.get("name")+", "+o.get("office_name")+"\n");
		}
		
		System.out.print("===== exe hql, return type: Entity =====\n");
		qlString = "select u from User u join u.office o where o.id=1";
		entityPage = userDao.find(entityPage, qlString);
		for (User o : entityPage.getList()) {
			System.out.print(o.getLoginName()+", "+o.getOffice().getName()+"\n");
		}
		
		System.out.print("===== exe sql, return type: Object[] =====\n");
		String sqlString = "select u.name, o.name as office_name from sys_user u join sys_office o on o.id=u.office_id";
		objPage = userDao.findBySql(objPage, sqlString);
		for (Object[] o : objPage.getList()) {
			System.out.print(o[0]+", "+o[1]+"\n");
		}
		
		System.out.print("===== exe sql, return type: Map =====\n");
		mapPage = userDao.findBySql(mapPage, sqlString, Map.class);
		for (Map<String, Object> o : mapPage.getList()) {
			System.out.print(o.get("name")+", "+o.get("office_name")+"\n");
		}
		
		System.out.print("===== exe sql, return type: Entity =====\n");
		sqlString = "select u.* from sys_user u join sys_office o on o.id=u.office_id";
		entityPage = userDao.findBySql(entityPage, sqlString, User.class);
		for (User o : entityPage.getList()) {
			System.out.print(o.getLoginName()+", "+o.getOffice().getName()+"\n");
		}
		
		System.out.print("========================================\n");
		System.out.print("userDao: "+userDao+"\n");
	}

    @Resource(name= "toolDaoTemplate")
    ToolDaoTemplate toolDaoTemplate;

//    @Test
//    public void testMybatisPaging(){
//        Page<User> param = new Page<User>(1,3);
//        Page<User> page= toolDaoTemplate.queryPage("user.queryPage", param);
//        List<User> userList = page.getList();
//        for(User user : userList){
//            System.out.println(user.getName());
//        }
//    }

    @Test
    public void testMybatisParameter(){
        MybatisParameter<User> parameter = new MybatisParameter<User>();
        Page<User> paramPage = new Page<User>(1,5);
        parameter.setPage(paramPage);
        parameter.put("email","75999267@qq.com");
        Page<User> page= toolDaoTemplate.paging("user.queryPage", parameter);
        List<User> userList = page.getList();
        System.out.println("pageNo:"+page.getPageNo()+"\tpageSize:"+page.getPageSize()+"\tpageCount:"+page.getCount());
        for(User user : userList){
            System.out.println(user.getLoginName()+"\t"+user.getEmail());
        }
    }

//    @Test
//    public void testFindGameServer(){
//        List<Role> roleList = userDao.get("1").getRoleList();
//        for(GamePlatform gamePlatform : roleList.get(0).getGamePlatformList()){
//            System.out.println(gamePlatform.getName());
//            for(GameServer gameServer : gamePlatform.getGameServerList()){
//                System.out.println(gameServer.getId());
//            }
//        }
//    }


    @Test
    public void testFindByUserId(){
        List<String> userIds = userDao.findUserIdsByUserId("104bc53879da4752b175acd55f10c1d3");
        System.out.println(JSON.toJSONString(userIds));
        //String sqlString = "select u.name, o.name as office_name from sys_user u join sys_office o on o.id=u.office_id";
    }
}