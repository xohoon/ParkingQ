package kr.parkingq.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.parkingq.domain.infoboard.Criteria;
import kr.parkingq.domain.infoboard.InfoAttachFileDTO;
import kr.parkingq.domain.infoboard.InfoAttachVO;
import kr.parkingq.domain.infoboard.InfoBoardVO;
import kr.parkingq.domain.infoboard.PageDTO;
import kr.parkingq.domain.infoboard.infoLikeVO;
import kr.parkingq.service.infoboard.InfoBoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

// log4j 
@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("infoboard")
public class InfoboardController {

	private InfoBoardService service;

	@GetMapping("list")
	public String list(Criteria cri,Model model , @CookieValue(value="userId", required=false) String userId) {
		
		if( userId == null ) {
			model.addAttribute("msg","로그인 정보가 없습니다.");
			model.addAttribute("movePath","/common/login");
			return "common/message";
		}
		
		
		log.info("list() 시작>>>>>>");
		model.addAttribute("list",service.getList(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,150));
		log.info("list() 끝>>>>>>");
		
		return "infoboard/list";
	}
	
	@PostMapping("register")
	public String register(InfoBoardVO board, RedirectAttributes rttr) {
		
		log.info("register() 시작>>>>>>");
		log.info("register : "+board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.register(board);
		rttr.addFlashAttribute("result",board.getNo()); /*게시글 등록번호*/
		
		//지도등록
		service.addMap(board);
		
		log.info("register() 끝>>>>>>");
		
		return "redirect:/infoboard/list";
		
	}
	
	
	@GetMapping("register")
	public void register(@CookieValue("userId") String userId,@CookieValue("userNick") String userNick) {
		log.info("userNick>>>>"+userNick);
		log.info("userId>>>>"+userId);
		
	}
	
	
	
	@GetMapping({"get","modify"})
	public void get(@RequestParam("no") int no, Model model, @ModelAttribute("cri") Criteria cri, 
			@CookieValue("userId") String userId, @CookieValue("userNick") String userNick) {
		
		log.info("get or modify>>>>>>>>>>>>>>>");
		log.info("Cookie : "+userNick+"/"+userId);
		model.addAttribute("board",service.get(no));
		model.addAttribute("mapboard",service.getMap(no));
	}
	
	@ResponseBody
	@PostMapping("get")
	public String get(infoLikeVO like) {
		log.info(like);
		int resultNum = service.getLike(like);
		log.info("resultNum>>>>>>>"+resultNum);
		return Integer.toString(resultNum);
	}
	
	@ResponseBody
	@PostMapping("addLike")
	public String addget(infoLikeVO like) {
		log.info(like);
		int resultNum = service.addLike(like);
		log.info("addget() resultNum>>>>>>>"+resultNum);
		return Integer.toString(resultNum);
	}
	
	@ResponseBody
	@PostMapping("deletLike")
	public String deleteget(infoLikeVO like) {
		log.info(like);
		int resultNum = service.deleteLike(like);
		log.info("deleteget() resultNum>>>>>>>"+resultNum);
		return Integer.toString(resultNum);
	}
	
	@ResponseBody
	@PostMapping("checkLike")
	public String checkget(infoLikeVO like) {
		log.info(like);
		int resultNum = service.checkLike(like);
		log.info("checkget() resultNum>>>>>>>"+resultNum);
		return Integer.toString(resultNum);
	}
	
	@PostMapping("modify")
	public String modify(InfoBoardVO board, RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		log.info("modify Post1>>>>>> ");
		
		if(service.modify(board)){
			rttr.addFlashAttribute("result","success");
		}
		log.info("modify Post2>>>>>> ");
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("keyword", cri.getKeyword());
		log.info("modify Post3>>>>>> ");
		log.info("board.getLat + getLng"+board.getLat()+"||"+board.getLng());
		int result = service.updateMap(board);
		log.info("service.updateMap(board)>>"+result);
		
		return "redirect:/infoboard/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("no") int no, RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		log.info("remove..."+no);
		List<InfoAttachVO> attachList = service.getAttachList(no);
		
		if(service.remove(no)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result","seccess");
		}
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		/*rttr.addAttribute("type", cri.getType());*/
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/infoboard/list" + cri.getListLink();
	}
	
	/*파일 업로드 컨트롤러*/
	
	/* 파일 날짜 나누기 */
	private String getFolder() {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String str = sdf.format(date);

		return str.replace("-", File.separator);
	}
	
	/*업로드파일이 이미지파일인지 확인*/
	private boolean checkImageType(File file) {

		try {
			String contentType = Files.probeContentType(file.toPath());

			return contentType.startsWith("image");

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}
	
	/*파일 업로드 페이지*/
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<InfoAttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {

		List<InfoAttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";

		String uploadFolderPath = getFolder();
		// make folder --------
		File uploadPath = new File(uploadFolder, uploadFolderPath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// make yyyy/MM/dd folder

		for (MultipartFile multipartFile : uploadFile) {

			InfoAttachFileDTO attachDTO = new InfoAttachFileDTO();

			String uploadFileName = multipartFile.getOriginalFilename();

			// IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			attachDTO.setFileName(uploadFileName);

			UUID uuid = UUID.randomUUID();

			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);

				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);

				// check image type file
				if (checkImageType(saveFile)) {

					attachDTO.setImage(true);

					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				
				// add to List
				list.add(attachDTO);
				log.info("list>>>>>>>>"+list);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} // end for
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	
	/*@ResponseBody
	@PostMapping("/uploadAjaxAction")
		public String uploadAjaxPost(MultipartFile[] uploadFile) {
		
			log.info("update ajax post.........");
		
			String uploadFolder = "C:\\upload";
			
			// make folder --------
			File uploadPath = new File(uploadFolder, getFolder());
			log.info("upload path: " + uploadPath);
			
			if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
			}
			// make yyyy/MM/dd folder
			
			
			String fileName = null;
		
			for (MultipartFile multipartFile : uploadFile) {
		
				log.info("-------------------------------------");
				log.info("Upload File Name: " + multipartFile.getOriginalFilename());
				log.info("Upload File Size: " + multipartFile.getSize());
				fileName = multipartFile.getOriginalFilename();
		
				String uploadFileName = multipartFile.getOriginalFilename();
		
				// IE has file path
				uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") +1);
				log.info("only file name: " + uploadFileName);
				
				UUID uuid = UUID.randomUUID();
				uploadFileName = uuid.toString() + "_" + uploadFileName;
				
				// File saveFile = new File(uploadFolder, uploadFileName);
				File saveFile = new File(uploadPath, uploadFileName);
		
				try {
					log.info(">>>>>>>>>>END1");
					multipartFile.transferTo(saveFile);
					//이미지 파일인지 체크하기
					if(checkImageType(saveFile)) {
						FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
						Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
						thumbnail.close();
					}
				} catch (Exception e) {
					log.info(">>>>>>>>>>END2");
					log.error(e.getMessage());
				} // end catch
		
				} // end for
			
			log.info(">>>>>>>>>>END3");
			
			return fileName;
		
		}*/
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {

		log.info("fileName: " + fileName);

		File file = new File("c:\\upload\\" + fileName);

		log.info("file: " + file);

		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();

			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping(value = "/download", produces =MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {

		log.info("download file: " + fileName);
		
		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		log.info("resourceName:>>>>"+resourceName);
		
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		log.info("resourceOriginalName:>>>>"+resourceOriginalName);
		HttpHeaders headers = new HttpHeaders();
		try {
			
			String downloadName = null;
			
			if(userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+"," ");
				
			}else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				
			}else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			log.info("downloadName : " + downloadName);
			
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
		}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {

		log.info("deleteFile: " + fileName);

		File file;

		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

			file.delete();

			if (type.equals("image")) {

				String largeFileName = file.getAbsolutePath().replace("s_", "");

				log.info("largeFileName: " + largeFileName);

				file = new File(largeFileName);

				file.delete();
			}

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		

		return new ResponseEntity<String>("deleted", HttpStatus.OK);

	}
	
	@GetMapping(value="/getAttachList", produces =MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<InfoAttachVO>> getAttachList(int no){
		log.info("getAttachList>>>"+no);
		return new ResponseEntity<>(service.getAttachList(no), HttpStatus.OK);
	}
	
	private void deleteFiles(List<InfoAttachVO> attachList) {
	    
	    if(attachList == null || attachList.size() == 0) {
	      return;
	    }
	    
	    log.info("delete attach files...................");
	    log.info(attachList);
	    
	    attachList.forEach(attach -> {
	      try {        
	        Path file  = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" + attach.getUuid()+"_"+ attach.getFileName());
	        
	        Files.deleteIfExists(file);
	        
	        if(Files.probeContentType(file).startsWith("image")) {
	        
	          Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+ attach.getFileName());
	          
	          Files.delete(thumbNail);
	        }
	
	      }catch(Exception e) {
	        log.error("delete file error" + e.getMessage());
	      }//end catch
	    });//end foreachd
	  }

	

}