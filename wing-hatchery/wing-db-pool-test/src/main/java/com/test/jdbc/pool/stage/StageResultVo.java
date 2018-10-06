package com.test.jdbc.pool.stage;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by nijia on 2017/11/10.
 */
public class StageResultVo {


    private List<TimeResultVo> resultList = new ArrayList();
    private float min = 0;
    private float max = 0;
    private int exceptionCount = 0;
    class TimeResultVo {
        private float time;
        private float value;

        private int allCount;
        private float costTime;

        TimeResultVo(float time,float value,int count,float costTime){
            this.time = time;
            this.value = value;
            this.allCount = count;
            this.costTime = costTime;
        }

        public int getAllCount() {
            return allCount;
        }

        public void setAllCount(int allCount) {
            this.allCount = allCount;
        }

        public float getCostTime() {
            return costTime;
        }

        public void setCostTime(float costTime) {
            this.costTime = costTime;
        }

        public float getTime() {
            return time;
        }

        public void setTime(float time) {
            this.time = time;
        }

        public float getValue() {
            return value;
        }

        public void setValue(float value) {
            this.value = value;
        }
    }


    public void addResult(float time,float value,int count,float costTime){
        resultList.add(new TimeResultVo(time,value,count,costTime));
    }

    public int getExceptionCount() {
        return exceptionCount;
    }

    public void setExceptionCount(int exceptionCount) {
        this.exceptionCount = exceptionCount;
    }

    public List<TimeResultVo> getResultList() {
        return resultList;
    }
    public int getAllCount(){
        int count = 0;
        for(TimeResultVo vo :this.resultList){
            count+=vo.getAllCount();
        }


        return count;
    }

    public void setResultList(List<TimeResultVo> resultList) {
        this.resultList = resultList;
    }

    public float getMin() {
        return min;
    }

    public void setMin(float min) {
        this.min = min;
    }

    public float getMax() {
        return max;
    }

    public void setMax(float max) {
        this.max = max;
    }

    public void mergeResult(StageResultVo stageResultVo){
        if(this.min>stageResultVo.getMin()||this.min==0){
            this.min = stageResultVo.getMin();
        }
        if(this.max<stageResultVo.getMax()){
            this.max = stageResultVo.getMax();
        }
        this.exceptionCount+=stageResultVo.getExceptionCount();
        this.getResultList().addAll(stageResultVo.getResultList());
    }


    @Override
    public String toString() {
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("\n")
                .append("min:").append(min).append("\n")
                .append("max:").append(max).append("\n")
                .append("average:").append(getAverage()).append("\n")
                .append("exceptionCount:").append(exceptionCount).append("\n")
        ;
        for(TimeResultVo entry:resultList){
            stringBuffer
                    .append("时间（秒）:").append(entry.getTime()).append("\t")
                    .append("性能(每毫秒处理数):").append(entry.getValue()).append("\t")
                    .append("allCount:").append(entry.getAllCount()).append("\t")
                    .append("costTime:").append(entry.getCostTime()).append("\t")

            .append("\n");
        }


        return stringBuffer.toString();
    }

    private float getAverage(){
        int num =0;
        float allValue=0;
        for(TimeResultVo vo:resultList){
            if(vo.getValue()==this.min||vo.getValue()==this.max){
                continue;
            }
            num++;
            allValue+=vo.getValue();
        }


        return allValue/num;
    }


    public void toExcel(String filePath,int resultNum,int allNum){
        try {
            //创建新工作簿
            HSSFWorkbook workbook = new HSSFWorkbook();
            //新建工作表
            HSSFSheet sheet = workbook.createSheet("性能测试");
            //创建行,行号作为参数传递给createRow()方法,第一行从0开始计算
            HSSFRow row = sheet.createRow(0);
            //创建单元格,row已经确定了行号,列号作为参数传递给createCell(),第一列从0开始计算
            HSSFCell cell = row.createCell(0);
            //设置单元格的值,即C1的值(第一行,第三列)
            cell.setCellValue("最小性能(每毫秒处理数)");
            cell = row.createCell(1);
            cell.setCellValue("最大性能(每毫秒处理数)");

            cell = row.createCell(2);
            cell.setCellValue("平均性能(每毫秒处理数)");

            cell = row.createCell(3);
            cell.setCellValue("异常数量");

            if(resultNum>0||allNum>0){
                cell = row.createCell(5);
                cell.setCellValue("执行次数");
                cell = row.createCell(6);
                cell.setCellValue("入库数量");
                cell = row.createCell(7);
                cell.setCellValue("丢失数量");


            }




            row = sheet.createRow(1);
            cell = row.createCell(0);
            cell.setCellValue(min);
            cell = row.createCell(1);
            cell.setCellValue(max);
            cell = row.createCell(2);
            cell.setCellValue(getAverage());
            cell = row.createCell(3);
            cell.setCellValue(exceptionCount);

            if(resultNum>0||allNum>0) {

                cell = row.createCell(5);
                cell.setCellValue(allNum);
                cell = row.createCell(6);
                cell.setCellValue(resultNum);
                cell = row.createCell(7);
                cell.setCellValue(allNum - resultNum);

            }




            row = sheet.createRow(3);
            cell = row.createCell(0);
            cell.setCellValue("时间轴（秒）");
            cell = row.createCell(1);
            cell.setCellValue("性能(每毫秒处理数)");
            cell = row.createCell(2);
            cell.setCellValue("执行次数");
            cell = row.createCell(3);
            cell.setCellValue("花费时间");


            int rowNum = 4;
            for(TimeResultVo entry:resultList){
                row = sheet.createRow(rowNum++);
                cell = row.createCell(0);
                cell.setCellValue(entry.getTime());
                cell = row.createCell(1);
                cell.setCellValue(entry.getValue());
                cell = row.createCell(2);
                cell.setCellValue(entry.getAllCount());
                cell = row.createCell(3);
                cell.setCellValue(entry.getCostTime());
            }




            //输出到磁盘中
            FileOutputStream fos = new FileOutputStream(new File(filePath));
            workbook.write(fos);

            fos.close();
        }catch (Exception e){
            e.printStackTrace();
        }

    }

}
