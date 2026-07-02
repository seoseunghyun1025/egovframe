package egovframework.pagenation;

import egovframework.page.dto.PageInfoDTO;

public class Pagenation {
	public static PageInfoDTO getPageInfo(int pageNo, int totalCount) {
		int maxPage;
		int startPage;
		int endPage;
		int startRow;
		int endRow;
		int limit = 10;
		int buttonAmount = 10;
		
		//총 페이지 수 계산
		maxPage = (int) Math.ceil((double) totalCount / limit); //올림처리
		
		//현재 페이지에 보여줄 시작페이지 수
		startPage = (int) (Math.ceil((double) pageNo / buttonAmount) - 1) * buttonAmount + 1; // 1, 11, 21, 31, .... 
		
		//목록 아래 쪽에 보여질 마지막 페이지 수
		endPage = startPage + buttonAmount - 1;
		
		//maxPage가 더 작은 경우 마지막 페이지가 maxPage
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 존재하지 않으면 max 페이지와 endPage를 1로 변경
		if(maxPage == 0 && endPage == 0) {
			maxPage = startPage;
			endPage = startPage;
		}
		
		startRow = (pageNo - 1) * limit + 1;
		endRow = startRow + limit - 1;
		
		return new PageInfoDTO(pageNo, totalCount, limit, buttonAmount, maxPage, startPage, endPage, startRow, endRow);
	}
}
