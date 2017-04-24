package com.gs.common.util;

import com.gs.bean.Salary;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by GZWangBin on 2017/4/24.
 */
public class ViewExcel extends AbstractExcelView {
    @Override
    protected void buildExcelDocument(Map<String, Object> obj,
                                      HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // map的key，在对应的controller中设置
        List<Salary> list = (List<Salary>) obj.get("list");
        HSSFSheet sheet = workbook.createSheet("list");
        sheet.setDefaultColumnWidth((short) 12);
        HSSFCell cell = getCell(sheet, 0, 0);
        setText(cell, "工资发放编号");
        cell = getCell(sheet, 0, 1);
        setText(cell, "用户编号");
        cell = getCell(sheet, 0, 2);
        setText(cell, "奖金");
        cell = getCell(sheet, 0, 3);
        setText(cell, "罚款");
        cell = getCell(sheet, 0, 4);
        setText(cell, "总工资");
        cell = getCell(sheet, 0, 5);
        setText(cell, "工资发放描述");
        cell = getCell(sheet, 0, 6);
        setText(cell, "工资发放时间");
        cell = getCell(sheet, 0, 7);
        setText(cell, "工资发放创建时间");
        for (short i = 0; i < list.size(); i++) {
            HSSFRow sheetRow = sheet.createRow(i+1);
            Salary salary = list.get(i);
            sheetRow.createCell(0).setCellValue(salary.getSalaryId());
            sheetRow.createCell(1).setCellValue(salary.getUserId());
            sheetRow.createCell(2).setCellValue(salary.getPrizeSalary());
            sheetRow.createCell(3).setCellValue(salary.getMinusSalay());
            sheetRow.createCell(4).setCellValue(salary.getTotalSalary());
            sheetRow.createCell(5).setCellValue(salary.getSalaryDes());
            sheetRow.createCell(6).setCellValue(salary.getSalaryTime());
            sheetRow.createCell(6).setCellValue(salary.getSalaryCreatedTime());
        }
        //设置下载时客户端Excel的名称
        String filename = new SimpleDateFormat("yyyy-MM-dd").format(new Date())+".xls";
        //处理中文文件名
        filename = MyUtils.encodeFilename(filename, request);
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition", "attachment;filename=" + filename);
        OutputStream ouputStream = response.getOutputStream();
        workbook.write(ouputStream);
        ouputStream.flush();
        ouputStream.close();
    }
}
