package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/essay/*")
public class EssayController {

	@Autowired 
	BoardService boardService;
	
	@RequestMapping("/list")
	public void list (Criteria cri, Model model) {
		log.info("essay list ...");
		cri.setBoardType("essay");
		cri.setAmount(10);
		int total = boardService.getTotalNotice(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("essayList", boardService.getList(cri));
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("essay register get ...");
	}
	
	@RequestMapping("/register")
	public String registerForm(BoardVO board) {
		log.info("essay register post ...");
		boardService.register(board);
		
		return "redirect:/essay/list";
	}
	
	@GetMapping("/get")
	public void get(BoardVO board, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("essay get ... !!");

		model.addAttribute("essay" , boardService.getBoard(board));
	}
	
	@GetMapping("/modify")
	public void modify(Model model, Criteria cri, BoardVO board) {
		log.info("essay modify get ... ");
		board.setBoardType("essay");
		model.addAttribute("essay", boardService.getBoard(board));
	}
	
	@RequestMapping ("/modify")
	public String modify(Criteria cri, BoardVO board) {
		log.info("essay modify post ...");
		log.info(cri.getListLink());
		
		boardService.modify(board);
		
		return "redirect:/essay/list" + cri.getListLink();
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr ) {
		log.info("essay delete ....!!");
		
		List<BoardAttachVO> attachList = boardService.getAttachList(bno);
		
		if(boardService.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/essay/list" + cri.getListLink();
	}
	
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
				
				Files.deleteIfExists(file);
					if(Files.probeContentType(file).startsWith("image")) {
						Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath()+"\\s_" + attach.getUuid() + "_" + attach.getFileName());
						Files.delete(thumbNail);
					}
				} catch (Exception e) {
					log.error("delete file error" + e.getMessage());
			}
		});
		
	}
	
}