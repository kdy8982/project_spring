package org.zerock.controller;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;
import org.zerock.service.GalleryService;

import lombok.extern.log4j.Log4j;



/**
 * @author 김대연
 * 서비스의 메인페이지 컨트롤러
 *
 */
@Controller
@Log4j
public class HomeController {
	@Autowired
	GalleryService galleryService;
	
	@Autowired
	BoardService boardService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Criteria cri, Model model) {
		log.info("Main page call!");
		
		// model.addAttribute("photoList", boardService.getList(new Criteria(1, 8, "photo")));
		 model.addAttribute("noticeList", boardService.getList(new Criteria(1, 6, "notice")));
		// model.addAttribute("essayList", boardService.getList(new Criteria (1, 3, "essay")));
		// model.addAttribute("photo_photoCount", boardService.getPhotoCount(new Criteria(1,8,"photo")));
		// model.addAttribute("essay_photoCount", boardService.getPhotoCount(new Criteria(1,3,"essay")));

		return "/index";
	}
	
	@RequestMapping(value = "/mobileIndex", method = RequestMethod.GET)
	public @ResponseBody Object mobileIndex(Criteria cri, Model model) {
		log.info("call Mobile Index..");
		JSONObject obj = new JSONObject();
		obj.put("photoList", boardService.getList(new Criteria(1, 2, "photo")));
		obj.put("essayList", boardService.getList(new Criteria (1, 2, "essay")));
		return obj;
	}
	
	@RequestMapping(value = "/pcIndex", method = RequestMethod.GET)
	public @ResponseBody Object pcIndex(Criteria cri, Model model) {
		log.info("call PC Index..");
		JSONObject obj = new JSONObject();
		obj.put("photoList", boardService.getList(new Criteria(1, 8, "photo")));
		obj.put("essayList", boardService.getList(new Criteria (1, 3, "essay")));
		return obj;
	}

}
