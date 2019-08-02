package org.zerock.mapper;

import org.zerock.domain.AuthVO;
import org.zerock.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userid); 
	
	public int insert(MemberVO vo); // 회원가입
	public int authorize(AuthVO authVo); // 회원가입(권한부여)

	public int changePassword(MemberVO vo);
	public int changeProfilePhoto(MemberVO vo);
}
