package com.mokylin.cabal.modules.bus.web;

import com.alibaba.fastjson.JSONArray;
import com.mokylin.cabal.common.config.Global;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.utils.DateUtils;
import com.mokylin.cabal.common.utils.FileUtils;
import com.mokylin.cabal.common.utils.IdGen;
import com.mokylin.cabal.common.utils.excel.StrUtil;
import com.mokylin.cabal.common.web.BaseController;
import com.mokylin.cabal.modules.bus.entity.BusFile;
import com.mokylin.cabal.modules.bus.service.BusFileService;
import com.mokylin.cabal.modules.bus.vo.*;
import com.mokylin.cabal.modules.sys.entity.Log;
import com.mokylin.cabal.modules.sys.entity.User;
import com.mokylin.cabal.modules.sys.utils.UserUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.fileupload.util.Streams;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.*;

@Controller
@RequestMapping(value = "${adminPath}/bus/file")
public class BusFileController extends BaseController{

    @Autowired
    private BusFileService busFileService;


    @RequiresPermissions("bus:file:manager")
    @RequestMapping(value ={"list", ""})
    public String list(Model model) {

        Page<BusFile> fileList = busFileService.loadBusFileAll();
        model.addAttribute("page",fileList);

        return "modules/bus/fileList";
    }





    @RequiresPermissions("bus:file:manager")
    @RequestMapping(value = "create")
    public String create(Model model) {

        model.addAttribute("busFile",new BusFile());

        return "modules/bus/fileCreate";
    }

    @RequiresPermissions("bus:file:manager")
    @RequestMapping(value = "editView")
    public String editView(String id,Model model) {


        BusFile busFile = busFileService.findBusFileById(id);

        model.addAttribute("busFile",busFile);

        return "modules/bus/fileEdit";
    }

    @RequiresPermissions("bus:file:manager")
    @RequestMapping(value = "edit")
    public String edit(BusFile busFile) {

        busFileService.editBusFile(busFile);

        return "redirect:"+ Global.getAdminPath()+"/bus/file/?repage";
    }



    @RequiresPermissions("bus:file:manager")
    @RequestMapping(value = "save")
    public String save(BusFile busFile) {

        busFileService.createBusFile(busFile);




        return "redirect:"+ Global.getAdminPath()+"/bus/file/?repage";
    }


    @RequiresPermissions("bus:file:manager")
    @RequestMapping(value = "saveFile")
    public String saveFile(String id,String fileId, RedirectAttributes redirectAttributes) {


        busFileService.saveFileById(id);
        addMessage(redirectAttributes, "合同归档成功,合同号："+fileId);

        return "redirect:"+ Global.getAdminPath()+"/bus/file/?repage";
    }

    @RequiresPermissions("bus:file:manager")
    @RequestMapping(value = "delete")
    public String delete(String id,String fileId, RedirectAttributes redirectAttributes) {


        busFileService.deleteFileById(id);
        addMessage(redirectAttributes, "删除合同成功,合同号："+fileId);

        return "redirect:"+ Global.getAdminPath()+"/bus/file/?repage";
    }
    @RequiresPermissions("bus:file:upload")
    @RequestMapping(value = "remove")
    public String remove(String id,String fileId, RedirectAttributes redirectAttributes) {


        busFileService.removeFileById(id);
        addMessage(redirectAttributes, "移除归档合同成功,合同号："+fileId);

        return "redirect:"+ Global.getAdminPath()+"/bus/file/list2?repage";
    }

    @RequiresPermissions("bus:file:view")
    @RequestMapping(value ={"list2"})
    public String list2(Model model,@RequestParam Map<String, Object> paramMap) {

        Page<BusFile> fileList = busFileService.loadBusFileAll2(paramMap);
        model.addAttribute("page",fileList);
        model.addAllAttributes(paramMap);

        return "modules/bus/fileList2";
    }








    //上传


    @RequiresPermissions("bus:file:manager")
    @RequestMapping(value = "uploadView")
    public String uploadView(String id,Model model) {


        BusFile busFile = busFileService.findBusFileById(id);

        model.addAttribute("busFile",busFile);

        return "modules/bus/fileUpload";
    }




    @RequestMapping(value = "uploadDownView")
    public String uploadDownView(String id,Model model) {


        BusFile busFile = busFileService.findBusFileById(id);

        List<SysFile> fileList=new ArrayList<>();
        String json =  busFile.getPictureFileJsonPath();

        List<SysFile> pictureList = JSONArray.parseArray(json,SysFile.class);

        String otherJson =  busFile.getOtherFileJsonPath();
        List<SysFile> otherFiles = JSONArray.parseArray(otherJson,SysFile.class);

        fileList.addAll(pictureList);
        fileList.addAll(otherFiles);
        model.addAttribute("busFile",busFile);
        model.addAttribute("fileList",fileList);

        return "modules/bus/fileDown";
    }
    @RequestMapping(value = "uploadDownView2")
    public String uploadDownView2(String id,Model model) {


        BusFile busFile = busFileService.findBusFileById(id);

        List<SysFile> fileList=new ArrayList<>();
        String json =  busFile.getPictureFileJsonPath();

        List<SysFile> pictureList = JSONArray.parseArray(json,SysFile.class);

        String otherJson =  busFile.getOtherFileJsonPath();
        List<SysFile> otherFiles = JSONArray.parseArray(otherJson,SysFile.class);

        fileList.addAll(pictureList);
        fileList.addAll(otherFiles);
        model.addAttribute("busFile",busFile);
        model.addAttribute("fileList",fileList);

        return "modules/bus/fileDown2";
    }

    public static  Map fileIconMap=new HashMap();
    private static List<String> PICTURE_LIST = new ArrayList<>();
    private static List<String> FILE_LIST = new ArrayList<>();
    static {
        fileIconMap.put("doc" ,"<i class='fa fa-file-word-o text-primary'></i>");
        fileIconMap.put("docx","<i class='fa fa-file-word-o text-primary'></i>");
        fileIconMap.put("xls" ,"<i class='fa fa-file-excel-o text-success'></i>");
        fileIconMap.put("xlsx","<i class='fa fa-file-excel-o text-success'></i>");
        fileIconMap.put("ppt" ,"<i class='fa fa-file-powerpoint-o text-danger'></i>");
        fileIconMap.put("pptx","<i class='fa fa-file-powerpoint-o text-danger'></i>");
        fileIconMap.put("jpg" ,"<i class='fa fa-file-photo-o text-warning'></i>");
        fileIconMap.put("pdf" ,"<i class='fa fa-file-pdf-o text-danger'></i>");
        fileIconMap.put("zip" ,"<i class='fa fa-file-archive-o text-muted'></i>");
        fileIconMap.put("rar" ,"<i class='fa fa-file-archive-o text-muted'></i>");
        fileIconMap.put("default" ,"<i class='fa fa-file-o'></i>");


        PICTURE_LIST.add("jpg");
        PICTURE_LIST.add("png");

        FILE_LIST.add("doc");
        FILE_LIST.add("docx");
        FILE_LIST.add("xls");
        FILE_LIST.add("xlsx");
        FILE_LIST.add("ppt");
        FILE_LIST.add("pptx");
        FILE_LIST.add("zip");
        FILE_LIST.add("txt");
        FILE_LIST.add("rar");
    }




    @RequestMapping("avatarUpload")
    @ResponseBody
    /**目前没有用到这个保存头像*/
    public AvatarResult avatarUpload(HttpServletRequest httpRequest, HttpSession session) throws Exception {

        MultipartHttpServletRequest request = (MultipartHttpServletRequest) httpRequest;
        Map<String, MultipartFile> fileMap = request.getFileMap();
        String contentType = request.getContentType();
        if (contentType.indexOf("multipart/form-data") >= 0) {


            String dirPath = request.getSession().getServletContext().getRealPath("/") + "/";
            String relPath =  MapUtils.getString(Global.getCommonMap(), "upload-file");
            AvatarResult result = new AvatarResult();
            result.setAvatarUrls(new ArrayList());
            result.setSuccess(false);
            result.setMsg("Failure!");

            // 定义一个变量用以储存当前头像的序号
            int avatarNumber = 1;
            User user = UserUtils.getUser();
            // 文件名
            String fileName = user.getName() + "_" + (new Date()).getTime() + ".jpg";



            String initParams = "";

            BufferedInputStream inputStream;
            BufferedOutputStream outputStream;
            for (Iterator<Map.Entry<String, MultipartFile>> it = fileMap.entrySet().iterator(); it.hasNext(); avatarNumber++) {
                File filePath = new File(dirPath + relPath);
                if (!filePath.exists()) {
                    filePath.mkdirs();
                }
                Map.Entry<String, MultipartFile> entry = it.next();
                MultipartFile mFile = entry.getValue();
                String fieldName = entry.getKey();
                Boolean isSourcePic = fieldName.equals("__source"); // 是否是原始图片域名称
                // 文件名，如果是本地或网络图片为原始文件名（不含扩展名）、如果是摄像头拍照则为 *FromWebcam
                // String name = fileItem.getName();
                // 当前头像基于原图的初始化参数（即只有上传原图时才会发送该数据），用于修改头像时保证界面的视图跟保存头像时一致，提升用户体验度。
                // 修改头像时设置默认加载的原图url为当前原图url+该参数即可，可直接附加到原图url中储存，不影响图片呈现。
                if (fieldName.equals("__initParams")) {
                    inputStream = new BufferedInputStream(mFile.getInputStream());
                    byte[] bytes = new byte[mFile.getInputStream().available()];
                    inputStream.read(bytes);
                    initParams = new String(bytes, "UTF-8");
                    inputStream.close();
                } else if (isSourcePic || fieldName.startsWith("__avatar")) {
                    String virtualPath = dirPath + relPath + "\\" + fileName;
                    if (avatarNumber > 1) {
                        fileName = avatarNumber + fileName;
                        virtualPath = dirPath + relPath + "\\" + fileName;
                    }
                    // 原始图片(file 域的名称：__source，如果客户端定义可以上传的话，可在此处理）。
                    if (isSourcePic) {
                        fileName = "source" + fileName;
                        virtualPath = dirPath + relPath + "\\" + fileName;
                        result.setSourceUrl(relPath + "/" + fileName);
                    }
                    // 头像图片(file 域的名称：__avatar1,2,3...)。
                    else {
                        result.getAvatarUrls().add(relPath + "/" + fileName);
                    }

                    inputStream = new BufferedInputStream(mFile.getInputStream());
                    outputStream = new BufferedOutputStream(new FileOutputStream(virtualPath.replace("/", "\\")));
                    Streams.copy(inputStream, outputStream, true);
                    inputStream.close();
                    outputStream.flush();
                    outputStream.close();
                    // 保存图片信息
                    result.setMsg("success");//uploaderService.saveAvatar(userId, fileName, relPath + File.separator + fileName, dirPath)
                }

            }
            if (result.getSourceUrl() != null) {
                result.setSourceUrl(result.getSourceUrl() + initParams);
            }
            result.setSuccess(true);
            return result;
        }
        return null;
    }

    /**
     * markdown组件上传图片
     */
    @RequestMapping(value = "markdownUpload", method = RequestMethod.POST)
    @ResponseBody
    public MarkDownResult markdownUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "editormd-image-file", required = false) MultipartFile attach) {
        try {


            String dirPath = request.getSession().getServletContext().getRealPath("/") + "/";
            String relPath =  MapUtils.getString(Global.getCommonMap(), "upload-file");

            //不存在目录 则创建
            File filePath = new File(dirPath + relPath);
            if (!filePath.exists()) {
                filePath.mkdirs();
            }
            File realFile = new File(dirPath + relPath + File.separator + attach.getOriginalFilename());
            //上传的文件已存在 则对新上传的文件重命名
            if (realFile.exists()) {
                String fileName = DateUtils.formatDate(new Date(), "yyyyMMddHHmmss") + "_" + attach.getOriginalFilename();
                realFile = new File(dirPath + relPath + File.separator + fileName);
            }

            FileUtils.copyInputStreamToFile(attach.getInputStream(), realFile);
            String url = relPath + File.separator + realFile.getName();
            url = request.getAttribute("basePath").toString() + url.replaceAll("\\\\", "/");
            return new MarkDownResult(1, "上传成功", url);

        } catch (IOException ex) {
            return new MarkDownResult(0, "上传失败:原因" + ex.getMessage().toString(), null);
        }
    }

    /**
     * 跳转到通用文件上传窗口
     * @return
     */
    @RequestMapping(value="uploader",method = RequestMethod.GET)
    public String uploader(String config,HttpServletRequest request){
        request.setAttribute("config",config);
        return "base/file/file_uploader";
    }


    /**
     * 通用文件上传接口，存储到固定地址，以后存储到文件服务器地址
     */
    @RequestMapping(value = "uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public FileResult uploadFile(@RequestParam(value = "file", required = false) MultipartFile file, @RequestParam(value = "fileId") String fileId,
                                 HttpServletRequest request, HttpServletResponse response) throws IOException {
        MultipartFile[] files=new MultipartFile[]{file};

        return uploadMultipleFile(files,fileId,request,response);
    }

    /**
     * 多文件上传，用于uploadAsync=false(同步多文件上传使用)
     * @param files
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "uploadMultipleFile", method = RequestMethod.POST)
    @ResponseBody
    public FileResult uploadMultipleFile(@RequestParam(value = "file", required = false) MultipartFile[] files,
                                         @RequestParam(value = "id") String id,
                                         HttpServletRequest request, HttpServletResponse response) throws IOException {

        BusFile busFile = busFileService.findBusFileById(id);
        User user = UserUtils.getUser();
        FileResult msg = new FileResult();
        String dirPath = request.getSession().getServletContext().getRealPath(File.separator) + File.separator;
        String uploaderPath =  MapUtils.getString(Global.getCommonMap(), "upload-file")+File.separator+busFile.getFileId();
        ArrayList<Integer> arr = new ArrayList<>();
        //缓存当前的文件
        List<SysFile> fileList=new ArrayList<>();
        String json =  busFile.getPictureFileJsonPath();

        List<SysFile> pictureList = JSONArray.parseArray(json,SysFile.class);

        String otherJson =  busFile.getOtherFileJsonPath();
        List<SysFile> otherFiles = JSONArray.parseArray(otherJson,SysFile.class);


            for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];

            if (!file.isEmpty()) {
                InputStream in = null;
                OutputStream out = null;
                try {
                    File dir = new File(dirPath+uploaderPath);
                    if (!dir.exists())
                        dir.mkdirs();
                    //这样也可以上传同名文件了
                    String filePrefixFormat="yyyyMMddHHmmssS";
                    String savedName=DateUtils.formatDate(new Date(),filePrefixFormat)+"_"+file.getOriginalFilename();
                    String filePath=dir.getAbsolutePath() + File.separator + savedName;
                    File serverFile = new File(filePath);
                    //将文件写入到服务器
                    FileUtils.copyInputStreamToFile(file.getInputStream(),serverFile);
                    file.transferTo(serverFile);
                    SysFile sysFile=new SysFile();
                    sysFile.setFileName(file.getOriginalFilename());
                    sysFile.setSavedName(savedName);
                    sysFile.setFileSize(file.getSize());
                    sysFile.setFilePath(dirPath+uploaderPath+File.separator+savedName);
                    sysFile.setId(IdGen.uuid());
                    sysFile.setUploadUserName(user.getLoginName());
                    sysFile.setTimeStr(DateUtils.formatDate(new Date(),"yyyy-MM-dd HH:mm:ss"));

                    if(isImage(file.getOriginalFilename())){

                        pictureList.add(sysFile);

                    }else{

                        otherFiles.add(sysFile);
                    }



                    /*preview.add("<div class=\"file-preview-other\">\n" +
                            "<span class=\"file-other-icon\"><i class=\"fa fa-file-o text-default\"></i></span>\n" +
                            "</div>");*/

                    logger.info("Server File Location=" + serverFile.getAbsolutePath());
                } catch (Exception e) {
                    logger.error(   file.getOriginalFilename()+"上传发生异常，异常原因："+e.getMessage());
                    arr.add(i);
                } finally {
                    if (out != null) {
                        out.close();
                    }
                    if (in != null) {
                        in.close();
                    }
                }
            } else {
                arr.add(i);
            }
        }

        busFile.setPictureFileJsonPath(JSONArray.toJSONString(pictureList));
        busFile.setOtherFileJsonPath(JSONArray.toJSONString(otherFiles));



        this.busFileService.saveBusFile(busFile);
        if(arr.size() > 0) {
            msg.setError("文件上传失败！");
            msg.setErrorkeys(arr);
        }
        FileResult preview=getPreivewSettings(fileList,request);
        msg.setInitialPreview(preview.getInitialPreview());
        msg.setInitialPreviewConfig(preview.getInitialPreviewConfig());
        msg.setFileIds(preview.getFileIds());
        return msg;
    }

    public boolean isImage(String name){
        return false;
    }

    //删除某一项文件
    @RequestMapping(value="deleteFile")
    @RequiresPermissions("bus:file:manager")
    public String delete(String id,String fileId, Model model,HttpServletRequest request){

        BusFile busFile = this.busFileService.findBusFileById(fileId);
        String path = null;
        if(busFile!=null){

            String json =  busFile.getPictureFileJsonPath();

            List<SysFile> sysFiles = JSONArray.parseArray(json,SysFile.class);
            List<SysFile>delList = new ArrayList<>();
            for(SysFile f:sysFiles){
                if(f.getId().equals(id)){
                    path = f.getFilePath();
                    delList.add(f);
                    break;
                }
            }
            if(!delList.isEmpty()){
                sysFiles.removeAll(delList);
                busFile.setPictureFileJsonPath(JSONArray.toJSONString(sysFiles));
                delList.clear();
                this.busFileService.saveBusFile(busFile);

            }

            json =  busFile.getOtherFileJsonPath();
            sysFiles = JSONArray.parseArray(json,SysFile.class);
            for(SysFile f:sysFiles){
                if(f.getId().equals(id)){
                    path = f.getFilePath();
                    delList.add(f);
                    break;
                }
            }
            if(!delList.isEmpty()){
                sysFiles.removeAll(delList);
                busFile.setOtherFileJsonPath(JSONArray.toJSONString(sysFiles));
                delList.clear();
                this.busFileService.saveBusFile(busFile);

            }

        }

        if(path!=null){
            FileUtils.delFile(path);
        }



        return this.uploadDownView(fileId,model);
    }

    @RequestMapping(value="downloadFile",method = RequestMethod.GET)
    public void downloadFile(@RequestParam String id,@RequestParam String fileId, HttpServletRequest request, HttpServletResponse response) throws IOException {



        InputStream is = null;
        OutputStream os = null;
        File file = null;
        try {
            // PrintWriter out = response.getWriter();







            BusFile busFile = this.busFileService.findBusFileById(fileId);

            if(busFile!=null){
                String path = null;

                String json = busFile.getPictureFileJsonPath();

                List<SysFile> sysFiles = JSONArray.parseArray(json, SysFile.class);

                for (SysFile f : sysFiles) {
                    if (f.getId().equals(id)) {
                        path = f.getFilePath();
                        break;
                    }
                }


                json = busFile.getOtherFileJsonPath();
                sysFiles = JSONArray.parseArray(json, SysFile.class);
                for (SysFile f : sysFiles) {
                    if (f.getId().equals(id)) {
                        path = f.getFilePath();
                        break;
                    }
                }

                if (path != null){
                    file = new File(path);
                }

                if (file != null && file.exists() && file.isFile()) {
                    long filelength = file.length();
                    is = new FileInputStream(file);
                    // 设置输出的格式
                    os = response.getOutputStream();
                    response.setContentType("application/x-msdownload");
                    response.setContentLength((int) filelength);
                    response.addHeader("Content-Disposition", "attachment; filename=\"" + new String(file.getName().getBytes("GBK"),// 只有GBK才可以
                            "iso8859-1") + "\"");

                    // 循环取出流中的数据
                    byte[] b = new byte[4096];
                    int len;
                    while ((len = is.read(b)) > 0) {
                        os.write(b, 0, len);
                    }
                } else {
                    response.getWriter().println("<script>");
                    response.getWriter().println(" modals.info('文件不存在!');");
                    response.getWriter().println("</script>");
                }

            }








        } catch (IOException e) {
            // e.printStackTrace();
        } finally {
            if (is != null) {
                is.close();
            }
            if (os != null) {
                os.close();
            }
        }
    }

    /**
     * 获取字体图标map,base-file控件使用
     */
    @RequestMapping(value="icons",method = RequestMethod.POST)
    @ResponseBody
    public Map getIcons(){
        return fileIconMap;
    }

    /**
     * 根据文件名获取icon
     * @param fileName 文件
     * @return
     */
    public String getFileIcon(String fileName){
        String ext= StrUtil.getExtName(fileName);
        return fileIconMap.get(ext)==null?fileIconMap.get("default").toString():fileIconMap.get(ext).toString();
    }

    /**
     * 根据附件IDS 获取文件
     * @param fileIds
     * @param request
     * @return
     */
    @RequestMapping(value="getFiles",method = RequestMethod.POST)
    @ResponseBody
    public FileResult getFiles(String fileIds,String fileId,HttpServletRequest request){
        List<SysFile> fileList=new ArrayList<>();
        if(!StrUtil.isEmpty(fileIds)) {
            String[] fileIdArr = fileIds.split(",");
            BusFile busFile = this.busFileService.findBusFileById(fileId);
            if(busFile==null){
                return new FileResult();
            }

            String json = busFile.getPictureFileJsonPath();
            List<SysFile> sysFiles = JSONArray.parseArray(json, SysFile.class);

            for(String id:fileIdArr){
                for (SysFile f : sysFiles) {
                    if (f.getId().equals(id)) {
                        fileList.add(f);
                        break;
                    }
                }


                json = busFile.getOtherFileJsonPath();
                sysFiles = JSONArray.parseArray(json, SysFile.class);
                for (SysFile f : sysFiles) {
                    if (f.getId().equals(id)) {
                        fileList.add(f);
                        break;
                    }
                }
            }




        }
        return getPreivewSettings(fileList,request);
    }


    /**
     * 回填已有文件的缩略图
     * @param fileList 文件列表
     * @param request
     * @return initialPreiview initialPreviewConfig fileIds
     */
    public FileResult getPreivewSettings(List<SysFile> fileList,HttpServletRequest request){
        FileResult fileResult=new FileResult();
        List<String> previews=new ArrayList<>();
        List<FileResult.PreviewConfig> previewConfigs=new ArrayList<>();
        //缓存当前的文件
        String dirPath = request.getRealPath("/");
        String[] fileArr=new String[fileList.size()];

        int index=0;
        for (SysFile sysFile : fileList) {
            //上传后预览 TODO 该预览样式暂时不支持theme:explorer的样式，后续可以再次扩展
            //如果其他文件可预览txt、xml、html、pdf等 可在此配置
            if(FileUtils.isImage(sysFile.getFilePath())) {
                previews.add("<img src='." + sysFile.getFilePath().replace(File.separator, "/") + "' class='file-preview-image kv-preview-data' " +
                        "style='width:auto;height:160px' alt='" + sysFile.getFileName() + " title='" + sysFile.getFileName() + "''>");
            }else{
                previews.add("<div class='kv-preview-data file-preview-other-frame'><div class='file-preview-other'>" +
                        "<span class='file-other-icon'>"+getFileIcon(sysFile.getFileName())+"</span></div></div>");
            }
            //上传后预览配置
            FileResult.PreviewConfig previewConfig=new FileResult.PreviewConfig();
            previewConfig.setWidth("120px");
            previewConfig.setCaption(sysFile.getFileName());
            previewConfig.setKey(sysFile.getId());
            // previewConfig.setUrl(request.getContextPath()+"/file/delete");
            previewConfig.setExtra(new FileResult.PreviewConfig.Extra(sysFile.getId()));
            previewConfig.setSize(sysFile.getFileSize());
            previewConfigs.add(previewConfig);
            fileArr[index++]=sysFile.getId();
        }
        fileResult.setInitialPreview(previews);
        fileResult.setInitialPreviewConfig(previewConfigs);
        fileResult.setFileIds(StrUtil.join(fileArr));
        return fileResult;
    }



}
