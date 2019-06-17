package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.GalleryAttachVO;
import org.zerock.domain.GalleryVO;
import org.zerock.mapper.GalleryAttachMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class GalleryServiceImpl implements GalleryService{

	@Autowired 
	GalleryAttachMapper galleryAttachMapper;
	
	
	@Override
	public List<GalleryVO> getList() {
		
		return galleryAttachMapper.getGalleryList();
	}

}
