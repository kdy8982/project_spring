package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	
	// @Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList(); 
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	// myBatis에 파라미터를 두개 이상 넘기기 위해 , 애노테이션을 등록함.  
	public void updateReplyCnt(@Param("bno")Long bno, @Param("amount")int cnt);
	
}
