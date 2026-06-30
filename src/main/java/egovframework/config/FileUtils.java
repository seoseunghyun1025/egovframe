package egovframework.config;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.ObjectUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.notice.dto.Notice;
import egovframework.notice.dto.NoticeFile;

@Component
public class FileUtils {
	private static final String filePath = "C:\\mp\\file\\";
	
	public List<NoticeFile> parseInsertFileInfo(String noticeUuid,
			MultipartHttpServletRequest request) throws Exception{
		
		if(ObjectUtils.isEmpty(request)) {
			return null;
		}
		List<NoticeFile> fileList = new ArrayList<>();
		Iterator<String> iterator = request.getFileNames();
		
		String originalFileName = null; 
		//파일 확장자
		String originalFileExtension = null;
		String storedFileName = null;
		
		long fileSize = 0;
		
		File file = new File(filePath);
		if(file.exists() == false) {
			file.mkdirs();
		}
		while(iterator.hasNext()) {
			List<MultipartFile> list = request.getFiles(iterator.next());
			for(MultipartFile multipartFile: list) {
				if(multipartFile.isEmpty() == true) {
					break;
				}
				NoticeFile files = new NoticeFile();
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;
				fileSize = multipartFile.getSize();
				
				files.setOriginalName(originalFileName);
				files.setStoredFileName(storedFileName);
				files.setFileSize(fileSize);
				files.setNoticeUuid(noticeUuid);
				
				fileList.add(files);
				
				file = new File(filePath + "/" + storedFileName);
				multipartFile.transferTo(file);
			}
			
			/*
			 * multipartFile = request.getFile(iterator.next()); if(multipartFile.isEmpty()
			 * == false) { originalFileName = multipartFile.getOriginalFilename();
			 * originalFileExtension =
			 * originalFileName.substring(originalFileName.lastIndexOf(".")); //uuid 원본 파일
			 * 확장자 합침 storedFileName = getRandomString() + originalFileExtension;
			 * 
			 * file = new File(filePath + storedFileName); multipartFile.transferTo(file);
			 * listMap = new HashMap<String, Object>(); listMap.put("NOTICE_UUID",
			 * noticeUuid); listMap.put("ORIGINAL_NAME", originalFileName);
			 * listMap.put("STORED_FILE_NAME", storedFileName); listMap.put("FILE_SIZE",
			 * multipartFile.getSize()); list.add(listMap); }
			 */
		}
				
		return fileList;
	}
	
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-","");
	}
}
