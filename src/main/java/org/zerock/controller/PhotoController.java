package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.domain.Criteria;
import org.zerock.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/photo/*")
public class PhotoController {

	@Autowired 
	BoardService boardService;
	
	@RequestMapping("/list")
	public void list (Model model) {
		log.info("photo list ...");

		model.addAttribute("photoList", boardService.getList(new Criteria(1, 12, "photo")));
		
	}
}
