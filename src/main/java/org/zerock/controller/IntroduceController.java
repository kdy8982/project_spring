package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
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

	@RequestMapping("/seniorpastor")
	public void seniorPastor (Model model) {
		
	}
}
