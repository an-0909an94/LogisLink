package com.logislink.basic.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.dao.PostDao;
import com.logislink.basic.service.PostService;


@Service("postService")
public class PostServiceImpl implements PostService {
	@Resource(name="postDao")
	private PostDao postDao;
}
