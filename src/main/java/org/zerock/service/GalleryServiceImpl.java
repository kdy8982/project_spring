package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardAttachMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class GalleryServiceImpl implements GalleryService{

	@Autowired 
	BoardAttachMapper boardAttachMapper;
	
	
	@Override
	public List<BoardAttachVO> getList() {
		
		return boardAttachMapper.getGalleryList();
	}

}
