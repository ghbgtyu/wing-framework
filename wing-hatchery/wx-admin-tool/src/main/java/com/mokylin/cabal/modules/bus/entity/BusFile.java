package com.mokylin.cabal.modules.bus.entity;

import com.mokylin.cabal.common.persistence.IdEntity;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.validator.constraints.Length;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Date;

/**
 * Created by nijia on 2018/12/1.
 */

@Table(name = "bus_file")
@Entity
@DynamicInsert
@DynamicUpdate
public class BusFile extends IdEntity<BusFile> {


    private static final long serialVersionUID = 1L;
//    public BusFile(){
//        super();
//    }
//    public BusFile(String id){
//        this();
//        this.id = id;
//    }


    private Date uploadDate;    // 上传时间

    //  private String uploadType;  // 上传类型

    private int state;          //上传状态

    private String fileId;     // 合同id
    private String content;    // 主题内容
    private String uploadDesc;       // 备注

    private String docFileJsonPath; //doc 文件路径
    private String pictureFileJsonPath; //图片文件路径
    private String otherFileJsonPath; //其他文件路径


    @Length(min = 0, max = 65535)
    public String getUploadDesc() {
        return uploadDesc;
    }

    public void setUploadDesc(String uploadDesc) {
        this.uploadDesc = uploadDesc;
    }


//    public String getUploadType() {
//        return uploadType;
//    }
//
//    public void setUploadType(String uploadType) {
//        this.uploadType = uploadType;
//    }


    @Temporal(TemporalType.TIMESTAMP)
    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    @Length(min = 0, max = 255)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Length(min = 0, max = 65535)
    public String getDocFileJsonPath() {
        return docFileJsonPath;
    }

    public void setDocFileJsonPath(String docFileJsonPath) {
        this.docFileJsonPath = docFileJsonPath;
    }

    @Length(min = 0, max = 65535)
    public String getPictureFileJsonPath() {
        return pictureFileJsonPath;
    }

    public void setPictureFileJsonPath(String pictureFileJsonPath) {
        this.pictureFileJsonPath = pictureFileJsonPath;
    }

    @Length(min = 0, max = 65535)
    public String getOtherFileJsonPath() {
        return otherFileJsonPath;
    }

    public void setOtherFileJsonPath(String otherFileJsonPath) {
        this.otherFileJsonPath = otherFileJsonPath;
    }

    public int getState() {
        return state;
    }

    @Length(min = 0, max = 64)
    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }


    public void setState(int state) {
        this.state = state;
    }
}
