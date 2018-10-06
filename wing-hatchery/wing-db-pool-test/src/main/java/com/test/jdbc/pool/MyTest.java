package com.test.jdbc.pool;

import com.test.jdbc.pool.datasource.MyC3p0DataSource;
import com.test.jdbc.pool.datasource.MyDruidDataSource;
import com.test.jdbc.pool.datasource.MyHikariDataSource;
import com.test.jdbc.pool.datasource.MyTomcatJdbcDataSource;
import com.test.jdbc.pool.test.impl.*;

import java.sql.SQLException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by nijia on 2017/11/13.
 */
public class MyTest {


    public static final void main(String[]args){

        MyDruidDataSource myDruidDataSource = new MyDruidDataSource();
        MyC3p0DataSource myC3p0DataSource = new MyC3p0DataSource();
        MyHikariDataSource myHikariDataSource = new MyHikariDataSource();
        MyTomcatJdbcDataSource myTomcatJdbcDataSource = new MyTomcatJdbcDataSource();
//        try {
//            myDruidDataSource.getConnection();
//
//            myC3p0DataSource.getConnection();
//            myHikariDataSource.getConnection();
//            myTomcatJdbcDataSource.getConnection();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }


        //单线程测试（获取连接、关闭连接）

        EmptyTest druidEmptyTest = new EmptyTest(myDruidDataSource );


        EmptyTest c3p0EmptyTest = new EmptyTest(myC3p0DataSource);

        EmptyTest hikariEmptyTest = new EmptyTest(myHikariDataSource);

        EmptyTest tomcatJdbcEmptyTest = new EmptyTest(myTomcatJdbcDataSource);


        //单线程测试（查询数据）

        QueryTest c3p0QueryTest = new QueryTest(myC3p0DataSource);

        QueryTest druidQueryTest = new QueryTest(myDruidDataSource);

        QueryTest hikariQueryTest = new QueryTest(myHikariDataSource);


        QueryTest tomcatJdbcQueryTest = new QueryTest(myTomcatJdbcDataSource);

        int threadSize = 10;

        //多线程并发测试（获取连接、关闭连接）

        MultiThreadEmptyTest c3p0MultiThreadEmptyTest = new MultiThreadEmptyTest(myC3p0DataSource,threadSize);
        MultiThreadEmptyTest druidMultiThreadEmptyTest = new MultiThreadEmptyTest(myDruidDataSource,threadSize);
        MultiThreadEmptyTest hikariMultiThreadEmptyTest = new MultiThreadEmptyTest(myHikariDataSource,threadSize);
        MultiThreadEmptyTest tomcatJdbcMultiThreadEmptyTest = new MultiThreadEmptyTest(myTomcatJdbcDataSource,threadSize);

        //多线程并发测试（插入数据）

        MultiThreadInsertTest c3p0MultiThreadInsertTest = new MultiThreadInsertTest(myC3p0DataSource,threadSize);
        MultiThreadInsertTest druidMultiThreadInsertTest = new MultiThreadInsertTest(myDruidDataSource,threadSize);
        MultiThreadInsertTest hikariMultiThreadInsertTest = new MultiThreadInsertTest(myHikariDataSource,threadSize);
        MultiThreadInsertTest tomcatJdbcMultiThreadInsertTest = new MultiThreadInsertTest(myTomcatJdbcDataSource,threadSize);



        ExecutorService service =  Executors.newFixedThreadPool(10);




        //service.execute(druidEmptyTest);
        //service.execute(c3p0EmptyTest);
//        service.execute(hikariEmptyTest);
       // service.execute(tomcatJdbcEmptyTest);




//          service.execute(druidEmptyTest);
//          service.execute(c3p0EmptyTest);
//          service.execute(hikariEmptyTest);
//          service.execute(tomcatJdbcEmptyTest);


            //service.execute(druidQueryTest);
            //service.execute(c3p0QueryTest);
            //service.execute(hikariQueryTest);
            //service.execute(tomcatJdbcQueryTest);

//        service.execute(druidQueryTest);
//        service.execute(c3p0QueryTest);
//        service.execute(hikariQueryTest);
//        service.execute(tomcatJdbcQueryTest);
//
//        for(int i = 0;i<10;i++){
//            service.execute(druidEmptyTest);
//            service.execute(c3p0EmptyTest);
//            service.execute(hikariEmptyTest);
//            service.execute(tomcatJdbcEmptyTest);
//        }
//
        //service.execute(c3p0MultiThreadEmptyTest);
        //service.execute(druidMultiThreadEmptyTest);
//        service.execute(hikariMultiThreadEmptyTest);
   //     service.execute(tomcatJdbcMultiThreadEmptyTest);


        service.execute(c3p0MultiThreadInsertTest);
        service.execute(druidMultiThreadInsertTest);
        service.execute(hikariMultiThreadInsertTest);
        service.execute(tomcatJdbcMultiThreadInsertTest);

        service.shutdown();

    }
}
