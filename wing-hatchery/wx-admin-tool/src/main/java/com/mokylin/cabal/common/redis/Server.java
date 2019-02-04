package com.mokylin.cabal.common.redis;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.io.Serializable;
import java.util.Date;

public class Server implements Serializable {

    private static final long serialVersionUID = 1875900293607911390L;

    private int worldId;//world_id
    private String worldName;//world_name
    private String name;//area_name
    private int id;//area_id
    private int type;//area_type
    private int subType;
    private String innerIp;//ip
    private String externalIp;//external_ip
    private int innerPort;//inner_port
    private int tcpPort;//tcp_port
    private int webPort;//web_port
    private int followerId;//follower_id
    private String key;// 服务器的公钥
    private int status;//status
    private String platformId;//pid
    private Date openTime;
    private Date updateTime;
    private String pName;

    public Server() {

    }

    public int getWorldId() {
        return worldId;
    }

    public int getFollowerId() {
        return followerId;
    }

    public void setFollowerId(int followerId) {
        this.followerId = followerId;
    }

    public void setWorldId(int worldId) {
        this.worldId = worldId;
    }

    public String getWorldName() {
        return worldName;
    }

    public void setWorldName(String worldName) {
        this.worldName = worldName;
    }

    public String getPlatformId() {
        return platformId;
    }

    public void setPlatformId(String platformId) {
        this.platformId = platformId;
    }

    public int getWebPort() {
        return webPort;
    }

    public void setWebPort(int webPort) {
        this.webPort = webPort;
    }

    public int getTcpPort() {
        return tcpPort;
    }

    public void setTcpPort(int tcpPort) {
        this.tcpPort = tcpPort;
    }

    public int getSubType() {
        return subType;
    }

    public void setSubType(int subType) {
        this.subType = subType;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getInnerPort() {
        return innerPort;
    }

    public void setInnerPort(int innerPort) {
        this.innerPort = innerPort;
    }

    public String getInnerIp() {
        return innerIp;
    }

    public void setInnerIp(String innerIp) {
        this.innerIp = innerIp;
    }

    public String getExternalIp() {
        return externalIp;
    }

    public void setExternalIp(String externalIp) {
        this.externalIp = externalIp;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

    /**
     * 生成内部完整的链接
     *
     * @return
     */
    public String createUrl() {
        return "http://" + innerIp + ":" + webPort;
    }

    public String createGateUrl() {
        return "http://" + externalIp;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((externalIp == null) ? 0 : externalIp.hashCode());
        result = prime * result + followerId;
        result = prime * result + ((innerIp == null) ? 0 : innerIp.hashCode());
        result = prime * result + innerPort;
        result = prime * result + ((name == null) ? 0 : name.hashCode());
        result = prime * result + ((platformId == null) ? 0 : platformId.hashCode());
        result = prime * result + status;
        result = prime * result + tcpPort;
        result = prime * result + type;
        result = prime * result + webPort;
        result = prime * result + ((worldName == null) ? 0 : worldName.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Server other = (Server) obj;
        if (externalIp == null) {
            if (other.externalIp != null)
                return false;
        } else if (!externalIp.equals(other.externalIp))
            return false;
        if (followerId != other.followerId)
            return false;
        if (innerIp == null) {
            if (other.innerIp != null)
                return false;
        } else if (!innerIp.equals(other.innerIp))
            return false;
        if (innerPort != other.innerPort)
            return false;
        if (name == null) {
            if (other.name != null)
                return false;
        } else if (!name.equals(other.name))
            return false;
        if (platformId != other.platformId)
            return false;
        if (status != other.status)
            return false;
        if (tcpPort != other.tcpPort)
            return false;
        if (type != other.type)
            return false;
        if (webPort != other.webPort)
            return false;
        if (worldName == null) {
            if (other.worldName != null)
                return false;
        } else if (!worldName.equals(other.worldName))
            return false;
        return true;
    }

    public Date getOpenTime() {
        return openTime;
    }

    public void setOpenTime(Date openTime) {
        this.openTime = openTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }
}
