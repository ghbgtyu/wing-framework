package com.test.jdbc.pool;

/**
 * Created by nijia on 2017/11/8.
 */
public class JdcbConstants {


    public static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    public static final String JDBC_URL = "jdbc:mysql://127.0.0.1:3306/testjdbc?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=utf-8";
    public static final String MYSQL_USER_NAME = "root";
    public static final String MYSQL_PASS_WORD = "root123";






    public static final int MAX_ACTIVE = 10;
    public static final int INITIAL_SIZE = 4;
    public static final int MIN_IDLE = 4;
    public static final int MAX_WAIT = 60000;

    public static final long TIME_BETWEEN_EVICTION_RUNS_MILLIS = 1000;
    public static final long MIN_EVICTABLE_IDLE_TIME_MILLIS = 1800000;

    public static final String VALIDATION_QUERY = "select 1";

    public static final boolean ON_BORROW_TEST = true;
    public static final boolean TEST_ON_RETURN = true;

    public static final boolean TEST_WHILE_IDLE = true;



}
