package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value = {"/notice/*"})
@AllArgsConstructor
public class NoticeController {
	
	private BoardService boardService;

	@RequestMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("Notice controller list call..");
		model.addAttribute("noticeList", boardService.getNoticeList(cri));
		
		int total = boardService.getTotalNotice(cri); // 페이징 처리를 위해, 전체 공지글 수를 구한다.
		model.addAttribute("pageMaker" , new PageDTO(cri, total));
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("Notice controller get call..");
		
		model.addAttribute("notice", boardService.getNotice(bno));
	}

	
	@GetMapping("/register")
	public void get(BoardVO board) {
		log.info("Notice controller register get call..");
	}
	
	
	@PostMapping("/register")
	public void insert(BoardVO board) {
		log.info("Notice controller register post call..");
		boardService.register(board);
	}
	
	
	@GetMapping("/delete")
	public void delete(@RequestParam("bno")Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("delete call....");
		log.info(bno);
		log.info(cri);
	}
	
	@RequestMapping("/modify") 
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify post call..!!");
		
		if (boardService.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		};
		
		return "redirect:/notice/list" + cri.getListLink();
		
	}
	
}
