package com.logislink.cmm;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.trace.handler.TraceHandler;

public class ComTraceHandler implements TraceHandler {

	private static final Logger logger = LoggerFactory.getLogger(ComTraceHandler.class);

	@Override
	public void todo(Class<?> clazz, String message) {
		// TODO Auto-generated method stub
		logger.debug("[TRACE]CLASS::: {}", clazz.getName());
		logger.debug("[TRACE]MESSAGE::: {}", message);
	}

}
