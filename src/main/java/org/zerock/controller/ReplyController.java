package org.zerock.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/replies/")
@AllArgsConstructor
public class ReplyController {
	
	// @Setter(onMethod_= {@Autowired}) //AllArgsConstructor 사용함으로써 Autwoired안 해줘도 됨.
	private ReplyService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/new", consumes = "application/json", produces= {MediaType.TEXT_PLAIN_VALUE, "text/plain;charset=UTF-8"})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		log.info("ReplyVO : " + vo);
		int insertCount = service.register(vo);
		log.info("Reply INSERT COUNT : " + insertCount);
		return insertCount == 1 ? new ResponseEntity<>("새로운 댓글이 등록되었습니다." , HttpStatus.OK):new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	@GetMapping(value="/pages/{bno}/{page}")
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno) throws UnsupportedEncodingException {
		Criteria cri = new Criteria(page, 5);
		
		log.info(MediaType.APPLICATION_XML_VALUE);
		log.info(MediaType.APPLICATION_JSON_UTF8_VALUE);
		
		ReplyPageDTO replyPageDTO = service.getListPage(cri, bno);
		List<ReplyVO> replyList = replyPageDTO.getList();

		for(ReplyVO reply : replyList) {
			reply.setThumbPhoto();
		}
		
		replyPageDTO.setList(replyList);
		
		log.info(replyPageDTO);
		
		return new ResponseEntity<>(replyPageDTO, HttpStatus.OK);
	}
	
	
	/*
	 * [과거 댓글 삭제 컨트롤러] 
	@DeleteMapping(value="/{rno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) { 
		log.info("remove : " + rno);
		return service.remove(rno) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK):new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	*/
	
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value="/{rno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {
		
		log.info("remove : " + rno);
		log.info("replyer : " + vo.getReplyer());
		return service.remove(rno) == 1 ? new ResponseEntity<String>("댓글을 삭제하였습니다.", HttpStatus.OK):new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	/* [댓글 수정 컨트롤러] */
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, value="/{rno}", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify (@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {

		log.info("rno : " + vo.getRno());
		log.info("modify : " + vo );
		
		return service.modify(vo) == 1 ? new ResponseEntity <> ("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/{rno}")
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
		log.info("read : " + rno);
		ReplyVO getVO = service.get(rno);
		return getVO != null ? new ResponseEntity<> (getVO, HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR) ;
	}
	
}
