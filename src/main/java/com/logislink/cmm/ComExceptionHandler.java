package com.logislink.cmm;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.exception.handler.ExceptionHandler;

public class ComExceptionHandler implements ExceptionHandler {

	private static final Logger logger = LoggerFactory.getLogger(ComExceptionHandler.class);
	
	@Override
	public void occur(Exception exception, String packageName) {
		// TODO Auto-generated method stub
		exception.printStackTrace();
		logger.error(packageName, exception);
	}

}
