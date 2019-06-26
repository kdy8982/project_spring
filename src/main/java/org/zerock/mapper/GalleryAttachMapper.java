package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.GalleryAttachVO;
import org.zerock.domain.GalleryVO;

public interface GalleryAttachMapper {
	public List<GalleryVO> getGalleryList();
	public List<GalleryVO> getHomeGalleryList();
	public void insert(GalleryAttachVO vo);
}
