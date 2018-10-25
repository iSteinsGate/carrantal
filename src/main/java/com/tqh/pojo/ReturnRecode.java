package com.tqh.pojo;

import java.util.Date;

public class ReturnRecode {
    private Integer id;

    private Integer cid;

    private Integer uid;

    private Date endtime;

    private String gasolinecost;

    private String damagecost;

    private String usecost;

    private String totalprice;

    private Car car;
    
    public Car getCar() {
		return car;
	}

	public void setCar(Car car) {
		this.car = car;
	}
	
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Date getEndtime() {
        return endtime;
    }

    public void setEndtime(Date endtime) {
        this.endtime = endtime;
    }

    public String getGasolinecost() {
		return gasolinecost;
	}

	public void setGasolinecost(String gasolinecost) {
		this.gasolinecost = gasolinecost;
	}

	public String getDamagecost() {
        return damagecost;
    }

    public void setDamagecost(String damagecost) {
        this.damagecost = damagecost == null ? null : damagecost.trim();
    }

    public String getUsecost() {
        return usecost;
    }

    public void setUsecost(String usecost) {
        this.usecost = usecost == null ? null : usecost.trim();
    }

    public String getTotalprice() {
        return totalprice;
    }

    public void setTotalprice(String totalprice) {
        this.totalprice = totalprice == null ? null : totalprice.trim();
    }
}