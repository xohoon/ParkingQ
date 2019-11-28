package kr.parkingq.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.parkingq.domain.reviewboard.PagingVO;
import kr.parkingq.domain.reviewboard.ReplyPageDTO;
import kr.parkingq.domain.reviewboard.ReviewCommentVO;
import kr.parkingq.service.reviewboard.CommentService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/comment/")
@RestController
@Log4j
@AllArgsConstructor
public class ReviewCommentController {
	//댓글 컨트롤러
	private CommentService service;
	
	//394p rest방식으로 처리할 때 주의해야 하는 점은 브라우저나 외부에서 서버를 호출할 때 데이터의 포맷과 서버에서 보내주는 데이터의 타입을 명확히 설계해야 하는 것이다
	//예를 들어 댓글 등록의 경우 브라우저에서는 json타입으로 된 댓글 데이터를 전송하고, 서버에서는 댓글의 처리 결과가 정상적으로 되었는지 문자열로 결과를 알려 주도록 한다
	//등록작업
	@PostMapping(value="/new", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReviewCommentVO vo){
		
		log.info("ReviewCommentVO : " + vo);
		System.out.println("content : "+vo.getContent());
		System.out.println("id : " + vo.getId());
		System.out.println("gno : " + vo.getGno()); 
		int insertCount = service.register(vo);
		
		log.info("Comment insert count : "  + insertCount);
		return insertCount==1
				? new ResponseEntity<>("댓글을 등록하셨습니다", HttpStatus.OK) : 
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
		//create()는 @PostMapping으로 Post방식으로만 동작하도록 설계하고, consumes와 produces를 이ㅛㅇ해서 json방식의 데이터만 처리하도록 하고,
		//문자열을 반환하도록 설계한다. create()의 파라미터는 @Requ
				
		//특정게시물의 댓글 목록 확인 395p		
		@GetMapping(value = "/pages/{gno}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
		public ResponseEntity<ReplyPageDTO> getList(
				@PathVariable("page") int page,
				@PathVariable("gno") Long gno){
				
				log.info("getList..................");
				log.info("controller에서의 no : " + gno);
				log.info("controller에서의 page 값: " + page);
				PagingVO pgv = new PagingVO(page, 5);
				
				return new ResponseEntity<>(service.getListPage(pgv, gno), HttpStatus.OK);
		}		
		//reviewcontroller의 getList()는 pagingVO를 이요해서 파라미터를 수집하는데, '/{gno}/{page}'의 page 값은
		//pagingVO를 생성해서 직접 처리해야 한다. 게시물의 번호는 @PathVariable을 이용해서 파라미터로 처리하고 브라우저에서 아래와 같이 
		//RestController의 댓글의 수정/삭제/조회는 위와 유사한 방식으로 json이나 문자열을 반환하도록 설계한다
		
		
		//댓글 조회 397p
		@GetMapping(value="/{no}",
				produces= {MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
		public ResponseEntity<ReviewCommentVO> get(@PathVariable("no") Long no){
			log.info("get:"  + no);
			return new ResponseEntity<>(service.get(no), HttpStatus.OK);
		}
		
		//댓글 삭제 397p
		@DeleteMapping(value="/{no}", produces= {MediaType.TEXT_PLAIN_VALUE})
		public ResponseEntity<String> remove(@PathVariable("no") Long no){
			
			log.info("remove: " + no);
			
			return service.remove(no)==1
					? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		//댓글 수정은 json 형태로 전달되는 데이터와 파라미터로 전달되는 댓글 번호(no)를 처리하기 때문에 아래와 같이 처리한다
		//댓글 수정 397p
		@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH},
				value="/{no}",
				consumes="application/json",
				produces= {MediaType.TEXT_PLAIN_VALUE})
		public ResponseEntity<String> modify(
			@RequestBody ReviewCommentVO vo,
			@PathVariable("no") Long no){
				vo.setNo(no);
				log.info("controller에서의 no: " + no);
				log.info("modify : " + vo);
				log.info("controller에서의 content : " + vo.getContent());
				return service.modify(vo)==1
						? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			
		}
		//댓글 수정은 put방식이나 patch 방식을 이용하도록 처리하고 실제 수정되는 데이터는 json포맷이로 @requestbody를 이용해서 처리한다
		//@RequestBody로 처리되는 데이터는 일반 파라미터나 @PathVariable 파라미터를 처리할 수 없기 때문에 지접 처리해 주는 부분을 주의해야 한다

	
}
