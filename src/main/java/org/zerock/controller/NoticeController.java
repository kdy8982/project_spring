package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value = {"/notice/*"})
public class NoticeController {
	
	@Autowired
	BoardService boardService;

	@RequestMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("Notice controller list call..");
		model.addAttribute("noticeList", boardService.getNoticeList(cri));
		
		int total = boardService.getTotalNotice(cri); // 페이징 처리를 위해, 전체 공지글 수를 구한다.
		model.addAttribute("pageMaker" , new PageDTO(cri, total));
	}
	
	@RequestMapping("/get")
	public void get(@RequestParam("bno") Long bno) {
		log.info("Notice controller get call..");
	}
	
	
}
