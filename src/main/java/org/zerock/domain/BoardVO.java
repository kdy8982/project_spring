package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updatedate;
	
	private int replyCnt;
	
	private boolean previewImg; // 프리뷰 이미지가 있는지 (이미지 갤러리 게시글인지)?
	
	private List<BoardAttachVO> attachList;
	
}
