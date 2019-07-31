package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {
	
	public MemberVO get(MemberVO vo);
	
	public boolean insert(MemberVO vo);

	public boolean changePassword(MemberVO vo, String newpw);

	public void changeProfilePhoto(MemberVO vo);
}
