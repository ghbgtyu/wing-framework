package com.hatchery.test.protobuf;

/**
 * Created by nijia on 2018/6/23.
 */
public class TestProtoMap {

    public static void main(String[]args){
        MapPro.TestObject.Builder builder = MapPro.TestObject.newBuilder();

        MapPro.TestObject.MapVaule.Builder mapBuilder = MapPro.TestObject.MapVaule.newBuilder();
        mapBuilder.setMapValue(1);

        MapPro.TestObject.MapVaule.Builder mapBuilder2 = MapPro.TestObject.MapVaule.newBuilder();
        mapBuilder2.setMapValue(122);


        builder.putMap("mapKey",mapBuilder.build());
        builder.putMap("mapKey2",mapBuilder2.build());


        byte[] bytes = builder.build().toByteArray();

        System.err.println("map序列化长度："+bytes.length);


//        MapPro.TestObject.MapVaule.Builder mapBuilder2 = MapPro.TestObject.MapVaule.newBuilder();
//        mapBuilder2.setMapValue("abcdefg");
//
//        byte[] sBytes = mapBuilder2.build().toByteArray();
//
//        System.err.println("String序列化长度："+sBytes.length);
    }

}
