package org.zerock.security;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;
import org.zerock.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailService implements UserDetailsService {
	
	@Setter(onMethod_={@Autowired})
	private MemberMapper memberMapper;
	
	

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		
		log.warn("Load User by UserName : " + userName);
		
		MemberVO vo = memberMapper.read(userName);
		log.warn("quried by member mapper : " + vo);
		
		// 다양한 인증 방법을 설정하기 위해, org.springframework.security.core.userdetails.User클래스를 상속하여 만든,
		// CustomUser 클래스를 리턴한다.
		return vo == null ? null : new CustomUser(vo);
		
	}

}
