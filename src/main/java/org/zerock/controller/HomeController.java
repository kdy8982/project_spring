package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;



/**
 * @author 김대연
 * 서비스의 메인페이지 컨트롤
 *
 */
@Controller
@Log4j
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		log.info("Main page call!");
		return "/includes/home";
	}
	
}
