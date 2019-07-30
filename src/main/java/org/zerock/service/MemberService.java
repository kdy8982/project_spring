package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {
	public boolean insert(MemberVO vo);

	public boolean changePassword(MemberVO vo, String newpw);

	public void changeProfilePhoto(MemberVO vo);
	
}
