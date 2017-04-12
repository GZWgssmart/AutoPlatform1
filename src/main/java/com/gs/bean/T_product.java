
package com.gs.bean;

import java.io.Serializable;
import java.math.*;


/** t_product
	ID    INT(11)
	PRODUCTNO    VARCHAR(255)
	FILEID    INT(11)
	DAYS    INT(11)
	NAME    VARCHAR(255)
	BRAND    VARCHAR(255)	STATUS    VARCHAR(255)
	PRICE    DOUBLE(22,31)
	TOTALSALES    INT(11)
	TOTALSTOCK    INT(11)
	BJSALES    INT(11)
	BJSTOCK    INT(11)
	SHSALES    INT(11)
	SHSTOCK    INT(11)
	GZSALES    INT(11)
	GZSTOCK    INT(11)
	CDSALES    INT(11)
	CDSTOCK    INT(11)
	WHSALES    INT(11)
	WHSTOCK    INT(11)
	SYSALES    INT(11)
	SYSTOCK    INT(11)
	XASALES    INT(11)
	XASTOCK    INT(11)
	GASALES    INT(11)
	GASTOCK    INT(11)
*/
public class T_product implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String productno;
	private int fileid;
	private int days;
	private String name;
	private String brand;
	private String status;
	private BigDecimal price;
	private int totalsales;
	private int totalstock;
	private int bjsales;
	private int bjstock;
	private int shsales;
	private int shstock;
	private int gzsales;
	private int gzstock;
	private int cdsales;
	private int cdstock;
	private int whsales;
	private int whstock;
	private int sysales;
	private int systock;
	private int xasales;
	private int xastock;
	private int gasales;
	private int gastock;

	public void setId(int id){
		this.id=id;
	}
	public int getId(){
		return id;
	}
	public void setProductno(String productno){
		this.productno=productno;
	}
	public String getProductno(){
		return productno;
	}
	public void setFileid(int fileid){
		this.fileid=fileid;
	}
	public int getFileid(){
		return fileid;
	}
	public void setDays(int days){
		this.days=days;
	}
	public int getDays(){
		return days;
	}
	public void setName(String name){
		this.name=name;
	}
	public String getName(){
		return name;
	}
	public void setBrand(String brand){
		this.brand=brand;
	}
	public String getBrand(){
		return brand;
	}
	public void setStatus(String status){
		this.status=status;
	}
	public String getStatus(){
		return status;
	}
	public void setPrice(BigDecimal price){
		this.price=price;
	}
	public BigDecimal getPrice(){
		return price;
	}
	public void setTotalsales(int totalsales){
		this.totalsales=totalsales;
	}
	public int getTotalsales(){
		return totalsales;
	}
	public void setTotalstock(int totalstock){
		this.totalstock=totalstock;
	}
	public int getTotalstock(){
		return totalstock;
	}
	public void setBjsales(int bjsales){
		this.bjsales=bjsales;
	}
	public int getBjsales(){
		return bjsales;
	}
	public void setBjstock(int bjstock){
		this.bjstock=bjstock;
	}
	public int getBjstock(){
		return bjstock;
	}
	public void setShsales(int shsales){
		this.shsales=shsales;
	}
	public int getShsales(){
		return shsales;
	}
	public void setShstock(int shstock){
		this.shstock=shstock;
	}
	public int getShstock(){
		return shstock;
	}
	public void setGzsales(int gzsales){
		this.gzsales=gzsales;
	}
	public int getGzsales(){
		return gzsales;
	}
	public void setGzstock(int gzstock){
		this.gzstock=gzstock;
	}
	public int getGzstock(){
		return gzstock;
	}
	public void setCdsales(int cdsales){
		this.cdsales=cdsales;
	}
	public int getCdsales(){
		return cdsales;
	}
	public void setCdstock(int cdstock){
		this.cdstock=cdstock;
	}
	public int getCdstock(){
		return cdstock;
	}
	public void setWhsales(int whsales){
		this.whsales=whsales;
	}
	public int getWhsales(){
		return whsales;
	}
	public void setWhstock(int whstock){
		this.whstock=whstock;
	}
	public int getWhstock(){
		return whstock;
	}
	public void setSysales(int sysales){
		this.sysales=sysales;
	}
	public int getSysales(){
		return sysales;
	}
	public void setSystock(int systock){
		this.systock=systock;
	}
	public int getSystock(){
		return systock;
	}
	public void setXasales(int xasales){
		this.xasales=xasales;
	}
	public int getXasales(){
		return xasales;
	}
	public void setXastock(int xastock){
		this.xastock=xastock;
	}
	public int getXastock(){
		return xastock;
	}
	public void setGasales(int gasales){
		this.gasales=gasales;
	}
	public int getGasales(){
		return gasales;
	}
	public void setGastock(int gastock){
		this.gastock=gastock;
	}
	public int getGastock(){
		return gastock;
	}
}

