package com.gs.common.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

import com.gs.bean.Salary;
import com.gs.common.Methods;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.springframework.http.HttpRequest;

import javax.servlet.http.HttpServletRequest;

/**
 * 操作Excel表格的功能类
 */
public class ExcelReader {
    public static Map<String,Salary> readExcelFile(String fileName){
        //创建对Excel工作薄文件的引用

        List<Salary> salaries = new ArrayList<Salary>();
        HashMap<String, Salary> map=new HashMap<String, Salary>();
        try {

            InputStream is = new FileInputStream(fileName);
            HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);

            // 循环工作表Sheet
            for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
                HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
                if (hssfSheet == null) {
                    continue;
                }

                // 循环行Row
                for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
                    Salary salary = new Salary();
                    HSSFRow hssfRow = hssfSheet.getRow(rowNum);
                    if (hssfRow == null) {
                        continue;
                    }
                    salary.setSalaryId(String.valueOf(hssfRow.getCell(0).getStringCellValue()));
                    salary.setUserId(String.valueOf(hssfRow.getCell(1).getStringCellValue()));
                    hssfRow.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                    salary.setPrizeSalary(Double.valueOf(hssfRow.getCell(3).getNumericCellValue()));
                    hssfRow.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                    salary.setMinusSalay(Double.valueOf(hssfRow.getCell(4).getNumericCellValue()));
                    hssfRow.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                    salary.setTotalSalary(Double.valueOf(hssfRow.getCell(5).getNumericCellValue()));
                    salary.setSalaryDes(String.valueOf(hssfRow.getCell(6).getStringCellValue()));
                    hssfRow.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
                    salary.setSalaryTime((hssfRow.getCell(7).getDateCellValue()));
                    hssfRow.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
                    salary.setSalaryCreatedTime((hssfRow.getCell(8).getDateCellValue()));

                    salaries.add(salary);


                }

            }

            for(Salary salary : salaries) {
                System.out.printf(salary + "aaaaaaaaaaaaaaaaa");
            }

        } catch (Exception e) {
            e.printStackTrace();

        }finally{


        }


        return map;
    }
}