package org.zerock.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.domain.AuthVO;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberMapper memberMapper;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Override
	public boolean insert(MemberVO member) {
		log.info("call member service impl..!!  ");

		String encodedPw = passwordEncoder.encode(member.getUserpw());
		member.setUserpw(encodedPw);

		boolean insertResult = memberMapper.insert(member) == 1;
		log.info("insertResult : " + insertResult);
		
		ArrayList<AuthVO> authArrayList = new ArrayList<AuthVO>();
		authArrayList.add(new AuthVO());
		member.setAuthList(authArrayList);
		log.info("member.getAuthList().size() : " + member.getAuthList().size());


		if (insertResult && member.getAuthList().size() > 0) {
			member.getAuthList().forEach(auth -> {
				auth.setUserid(member.getUserid());
				auth.setAuth("ROLE_USER"); // 처음에는 무조건 ROLE_USER 단계로 가입된다. log.info(auth);
				// member.getAuthList().add(auth);
				memberMapper.authorize(auth); // 권한을 부여한다.
			});
		}
		return insertResult;
	}

}
