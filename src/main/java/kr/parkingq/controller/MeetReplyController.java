package kr.parkingq.controller;

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

import kr.parkingq.domain.meetboard.MeetCriteria;
import kr.parkingq.domain.meetboard.MeetReplyPageDTO;
import kr.parkingq.domain.meetboard.MeetReplyVO;
import kr.parkingq.service.meetboard.MeetReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/meetreplies/")
@RestController
@Log4j
@AllArgsConstructor
public class MeetReplyController {
	
	public MeetReplyService service;
	
	// add Cookie data Get
	@GetMapping({"/create", "/getList", "/get", "/remove", "/modify", "/pages", "/new"})
	public void test(@CookieValue("userId") String id, @CookieValue("userNick") String nick) {
		log.info("Cookie ID : " + id);
		log.info("Cookie Nick : "+nick);
	}
	
	@PostMapping(
			value="/new",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE})
		public ResponseEntity<String> create(@RequestBody MeetReplyVO vo, @CookieValue("userId") String id, @CookieValue("userNick") String nick){
			log.info("MeetReplyVO: "+vo);
			vo.setId(id);
			vo.setReplyer(nick);
			int insertCount = service.register(vo);
			log.info("Reply INSERT COUNT : "+insertCount);
			
			return insertCount == 1
					? new ResponseEntity<>("success", HttpStatus.OK)
							: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	
	@GetMapping(
			value="/pages/{no}/{page}",
			produces= {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
			public ResponseEntity<MeetReplyPageDTO> getList(
					@PathVariable("page") int page,
					@PathVariable("no") Long no)
			{
				log.info("getList....................");
				MeetCriteria cri = new MeetCriteria(page, 10);
				log.info("get Reply List no : "+no);
				log.info(cri);
				
				return new ResponseEntity<>(service.getListPage(cri, no), HttpStatus.OK);
			}
	
	@GetMapping(
			value="/{gno}",
			produces= {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<MeetReplyVO> get(@PathVariable("gno") Long gno){
		log.info("get:" + gno);
		
		return new ResponseEntity<>(service.get(gno), HttpStatus.OK);
	}
	
	@DeleteMapping(
			value="/{gno}",
			produces= {
					MediaType.TEXT_PLAIN_VALUE
			})
	public ResponseEntity<String> remove(@PathVariable("gno") Long gno){
		log.info("remove:" + gno);
		
		return service.remove(gno) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(
			method= {RequestMethod.PUT, RequestMethod.PATCH},
			value="/{gno}",
			consumes="application/json",
			produces= {
					MediaType.TEXT_PLAIN_VALUE
			})
	public ResponseEntity<String> modify(
			
			@RequestBody MeetReplyVO vo,
			@PathVariable("gno") Long gno){
		vo.setGno(gno);
		log.info("gno:"+gno);
		log.info("modify:"+vo);
		
		return service.modify(vo) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
