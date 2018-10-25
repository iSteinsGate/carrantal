package com.tqh.pojo;

import java.util.Date;

public class LeaseRecode {
    private Integer id;

    private Integer cid;

    private Integer uid;

    private Date starttime;

    private Integer estimateday;
    
    private String state;

    public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

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

    public Date getStarttime() {
        return starttime;
    }

    public void setStarttime(Date starttime) {
        this.starttime = starttime;
    }

    public Integer getEstimateday() {
        return estimateday;
    }

    public void setEstimateday(Integer estimateday) {
        this.estimateday = estimateday;
    }
}