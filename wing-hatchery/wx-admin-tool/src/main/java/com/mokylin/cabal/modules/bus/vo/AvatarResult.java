package com.mokylin.cabal.modules.bus.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by nijia on 2018/12/18.
 */
public class AvatarResult {

    private List<String> AvatarUrls = new ArrayList<>();
    private String sourceUrl;
    private boolean success = false;
    private String msg;


    public List<String> getAvatarUrls() {
        return AvatarUrls;
    }

    public void setAvatarUrls(List<String> avatarUrls) {
        AvatarUrls = avatarUrls;
    }

    public String getSourceUrl() {
        return sourceUrl;
    }

    public void setSourceUrl(String sourceUrl) {
        this.sourceUrl = sourceUrl;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
