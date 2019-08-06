package org.zerock.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value= {"/admin/*"})
public class AdminController {

	@RequestMapping("/main")
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void main() {
		log.info("admin main page call..!");
		
	}
}
