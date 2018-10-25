package com.tqh.conversion;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

public class DateConverter implements Converter<String, Date>{

	public Date convert(String source) {
		if(null!=source){
			SimpleDateFormat sd = new SimpleDateFormat("yyyy-mm-dd hh:mm");
			try {
				source = source.replaceAll("T", " ");
				Date date = sd.parse(source);
				return date;
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return null;
	}


}
