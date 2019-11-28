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

import kr.parkingq.domain.infoboard.Criteria;
import kr.parkingq.domain.infoboard.InfoReplyVO;
import kr.parkingq.service.infoboard.InfoReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/inforeplies/")
@RestController
@Log4j
@AllArgsConstructor
public class InfoReplyController {
	
	private InfoReplyService service;
	
	@GetMapping({"/create", "/getList", "/get", "/remove", "/modify", "/pages", "/new"})
	public void test(@CookieValue("userId") String userId, @CookieValue("userNick") String userNick) {
		log.info("Cookie ID : " + userId);
		log.info("Cookie Nick : "+userNick);
	}
	
	@PostMapping(value = "/new", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody InfoReplyVO vo){
		log.info("InfoReplyVO: "+vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT: " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/pages/{no}/{page}",produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<InfoReplyVO>> getList( @PathVariable("page") int page, @PathVariable("no") int no){
		log.info("getList........");
		Criteria cri = new Criteria(page,10);
		log.info(cri);
		
		return new ResponseEntity<>(service.getList(cri, no), HttpStatus.OK);
	}
	
	@GetMapping(value="/{gno}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<InfoReplyVO> get(@PathVariable("gno") int gno){
		
		log.info("get: "+gno);
		
		return new ResponseEntity<>(service.get(gno), HttpStatus.OK);
	}
	
	@DeleteMapping(value="/{gno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("gno") int gno){
		
		log.info("remove : " + gno);
		
		return service.remove(gno) == 1? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value="/{gno}",
			consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody InfoReplyVO vo, @PathVariable("gno") int gno){
		vo.setGno(gno);
		log.info("gno:" + gno);
		log.info("modify:" + vo);
		
		return service.modify(vo) == 1 ? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	

}
