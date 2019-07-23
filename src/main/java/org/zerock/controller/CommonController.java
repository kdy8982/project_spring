package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping("/accessError")
	public void accessDenied (Authentication auth, Model model) {
		
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg","Access Denied");
	}
	
	@GetMapping("/customLogin")
	public void login(String error, String logout, Model model) {
		log.info("error : " + error);
		log.info("logout: " + logout);
		
		if(error!=null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if(logout!=null) {
			model.addAttribute("logout", "Logout!!");
		}
	}
	
	@RequestMapping(value="/customLogout",method={RequestMethod.GET})
	public void logout() {
		log.info("custom logout page load.");
	}
	
	@RequestMapping(value="/customLogout",method={RequestMethod.POST})
	public void logoutPost() {
		log.info("post custom logout!!");
	}
	
	@RequestMapping(value="/customSignup", method= {RequestMethod.GET, RequestMethod.POST})
	public void signUp(MemberVO vo) {
		
		log.info("sign up !!");
		log.info(vo);		
	}
	
	/* 스프링 시큐리티 암호 체크 방식 테스트용 메서드 */
	@RequestMapping(value="/checkBcrypt", method= {RequestMethod.GET, RequestMethod.POST})
	public void checkBcrypt(@RequestParam(value="targetStr", required=false) String targetStr) {
		log.info("check Bcrypt!!!!");
		
		if(StringUtils.hasText(targetStr)) {
			String bCrtyptString = passwordEncoder.encode(targetStr);
			
			log.info("targetStr : " + targetStr);
			log.info("bCrtyptString : " + bCrtyptString);
			log.info(passwordEncoder.matches(targetStr, "$2a$10$vqsyLHb7CG.3JUMY9/R6PO4BA0dyfSA.QPDGWqR4nwRKf7iu8jv36"));
		}
	}
	
}
