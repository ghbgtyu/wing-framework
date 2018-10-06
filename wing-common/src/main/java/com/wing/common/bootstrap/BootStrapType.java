package com.wing.common.bootstrap;

/**
 * Created by nijia on 2017/7/19.
 */
public enum BootStrapType {
    AMF(1),RPC(2)
    ;


     BootStrapType(int type){
        this.value = type;
    }

    private int value;

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
}
