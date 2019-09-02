package org.zerock.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.domain.FootprintsVO;
import org.zerock.service.IntroduceService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value = {"/introduce/*"} )
@AllArgsConstructor
public class IntroduceController {
	
	private IntroduceService introduceService;
	
	@RequestMapping("/church")
	public void church (Model model) {
		
	}

	@RequestMapping("/footprints")
	public void footprints (Model model) {
		model.addAttribute("footprintsList", introduceService.get());
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value="/footprints/add", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE, "text/plain;charset=UTF-8"})
	public ResponseEntity<String> footprintsAdd (@RequestBody FootprintsVO vo) {
		log.info(vo);
		log.info("footprints add method is calling..");
		return introduceService.add(vo) == 1 ? new ResponseEntity<String>("성공적으로 등록되었습니다.", HttpStatus.OK) : new ResponseEntity<String>("등록에 실패했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value="/footprints/delete", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE, "text/plain;charset=UTF-8"})
	public ResponseEntity<String> footprintsDelete (@RequestBody FootprintsVO vo) {
		log.info(vo);
		log.info("footprints delete method is calling..");
		introduceService.delete(vo);
		return new ResponseEntity<String>("삭제되었습니다.", HttpStatus.OK);
	}

	@RequestMapping("/seniorpastor")
	public void seniorPastor (Model model) {
		
	}
}
