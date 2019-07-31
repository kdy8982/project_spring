package org.zerock.security;

import java.io.UnsupportedEncodingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;
import org.zerock.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailService implements UserDetailsService {
	
	@Setter(onMethod_={@Autowired})
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException { // input의 name과 파라미터로 선언하는 변수명은 대소문자를 구분하지 않는다.
		log.info("Call loadUserByUsername..!");
		log.warn("Load User by UserName : " + userid);
		
		MemberVO vo = memberMapper.read(userid);
		try {
			vo.setThumbPhoto();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		log.warn("quried by member mapper : " + vo);
		
		// 다양한 인증 방법을 설정하기 위해, org.springframework.security.core.userdetails.User클래스를 상속하여 만든,
		// CustomUser 클래스를 리턴한다.
		return vo == null ? null : new CustomUser(vo);
		
	}

}
