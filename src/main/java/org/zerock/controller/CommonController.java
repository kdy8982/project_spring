package org.zerock.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

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
import org.zerock.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	@Autowired
	MemberService memberService;
	
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
	public void signUp(MemberVO vo, HttpServletRequest request) {
		log.info("sign up call .. ");
		log.info("요청 type : " + request.getMethod());
		
		if(request.getMethod().equals("POST")) {
			memberService.insert(vo);
		}
	}
	
	@RequestMapping(value="/memberDetail", method= {RequestMethod.GET})
	public void memberDetail(MemberVO vo, Model model) throws UnsupportedEncodingException {
		log.info("member detail call ..");
		//MemberVO getVo = memberService.get(vo);
		//getVo.setThumbPhoto();
		//model.addAttribute("member", getVo);
		
	}
	
	
	@RequestMapping(value="/memberPhotoModify", method= {RequestMethod.POST})
	public String memberPhotoModify(MemberVO vo, RedirectAttributes rttr) {
		log.info("memberPhotoModify call ..");
		
		log.info(vo.getPhoto());
		memberService.changeProfilePhoto(vo);
		
		return "redirect:/memberDetail?userid=" + vo.getUserid();
		
	}
	
	@RequestMapping(value="/memberPasswordModify", method= {RequestMethod.POST})
	public String memberPasswordModify(MemberVO vo, String newpw, RedirectAttributes rttr) {
		log.info("memberPasswordModify call ..");
		
		if(memberService.changePassword(vo, newpw)) {
			rttr.addFlashAttribute("result", "성공적으로 처리되었습니다.");
		} else {
			rttr.addFlashAttribute("result", "비밀번호가 틀렸습니다.");
		}
		
		return "redirect:/memberDetail?userid=" + vo.getUserid();
		
	}
	
	@RequestMapping(value="/memberPhotoPasswordModify", method= {RequestMethod.POST})
	public String memberPhotoPasswordModify(MemberVO vo, String newpw, RedirectAttributes rttr) {
		log.info("memberPhotoPasswordModify call ..");
		
		memberService.changeProfilePhoto(vo);
		
		if(memberService.changePassword(vo, newpw)) {
			rttr.addFlashAttribute("result", "성공적으로 처리되었습니다.");
		} else {
			rttr.addFlashAttribute("result", "비밀번호가 틀렸습니다.");
		}
		
		return "redirect:/memberDetail?userid=" + vo.getUserid();
		
	}
	
	
	
	/* 스프링 시큐리티 암호 체크 방식 테스트용 메서드 */
	/*
	 * @RequestMapping(value="/checkBcrypt", method= {RequestMethod.GET,
	 * RequestMethod.POST}) public void checkBcrypt(@RequestParam(value="targetStr",
	 * required=false) String targetStr) { log.info("check Bcrypt!!!!");
	 * 
	 * if(StringUtils.hasText(targetStr)) { String bCrtyptString =
	 * passwordEncoder.encode(targetStr);
	 * 
	 * log.info("targetStr : " + targetStr); log.info("bCrtyptString : " +
	 * bCrtyptString); log.info(passwordEncoder.matches(targetStr,
	 * "$2a$10$vqsyLHb7CG.3JUMY9/R6PO4BA0dyfSA.QPDGWqR4nwRKf7iu8jv36")); } }
	 */
	
}
