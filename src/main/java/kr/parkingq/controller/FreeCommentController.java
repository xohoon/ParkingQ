package kr.parkingq.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.parkingq.domain.freeboard.CommentPageDTO;
import kr.parkingq.domain.freeboard.Criteria;
import kr.parkingq.domain.freeboard.FreeCommentVO;
import kr.parkingq.service.freeboard.FreeCommentService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class FreeCommentController {

	private FreeCommentService service;
	
	
	// ��� �ۼ�
	@PostMapping(value = "/new",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody FreeCommentVO vo, @CookieValue("userId") String id, @CookieValue("userNick") String nick){
		
		log.info("FreeCommentVO PARAM : " + vo);
		
		vo.setId(id);
		vo.setNick(nick);
		
		log.info("FreeCommentVO: " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("comment insert count: " + insertCount);
		
		return insertCount == 1
			   ? new ResponseEntity<>("success", HttpStatus.OK)
			   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	// ��� ���
/*	@GetMapping(value = "/pages/{no}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
					})
	public ResponseEntity<List<FreeCommentVO>> getList(
		@PathVariable("page") int page,
		@PathVariable("no") Long no){
		
		
			log.info("getList>>>>>>>>>>>>>>>>>>>>>>>>>");
			log.info(page);
			
			log.info(no);
			log.info("getList>>>>>>>>>>>>>>>>>>>>>>>>>");

			Criteria cri = new Criteria(page,10);
			
			log.info(cri);
			
			return new ResponseEntity<> (service.getList(cri, no), HttpStatus.OK); 
	}*/

	//��� ��ȸ
	@GetMapping(value = "/{gno}",
			produces = {MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<FreeCommentVO> get(@PathVariable("gno") Long gno){
		
		log.info("get: " + gno);
		return new ResponseEntity<>(service.get(gno), HttpStatus.OK);
	}
	
	//��� ����
	@DeleteMapping(value = "/{gno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("gno") Long gno){
		
		log.info("remove: " + gno);
		
		return service.remove(gno) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	//��� ����
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value = "/{gno}",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
			@RequestBody FreeCommentVO vo,
			@PathVariable("gno") Long gno){
		
		vo.setGno(gno);
		log.info("gno: " + gno);
		log.info("modify: " + vo);
		
		return service.modify(vo) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//��� ����¡ ó��
	@GetMapping(value = "/pages/{no}/{page}",
			produces  = {MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<CommentPageDTO> getList(@PathVariable("page") int page, @PathVariable("no") Long no){
		
		Criteria cri = new Criteria(page, 10);
		
		log.info("get comment List no: " + no);
		log.info("cri :" +cri);
		
		return new ResponseEntity<>(service.getListPage(cri, no),
				HttpStatus.OK);
		
	}
	
	
	
}
	
			
			
	













