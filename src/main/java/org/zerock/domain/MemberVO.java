package org.zerock.domain;


import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String userid;
	private String userpw;
	private String username;
	private String enabled;
	
	private Date regDate;
	private Date updateDate;
	
	private List<AuthVO> authList; // 하나의 사용자는 여러개의 권한을 가질 수 있다(user, member, admin).
}
