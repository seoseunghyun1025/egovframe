<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%> <!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${investmentDTO.assetName} 상세 히스토리</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/investment/investment.css'/>">
    <style>
        /* 형님이 원하시는 카드 스타일 추가 */
        .summary-card {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 8px;
            background-color: #f9f9f9;
            min-width: 200px;
            box-shadow: 2px 2px 5px rgba(0,0,0,0.05);
        }
        #paging { margin-top: 20px; text-align: center; }
        .type-buy { color: red; font-weight: bold; }
        .type-sell { color: blue; font-weight: bold; }
    </style>
</head>
<body>

<div class="container">
    <section id="portfolioSection">
    <div style="display: flex; background: white; border: 1px solid #e0e0e0; border-radius: 10px; overflow: hidden;">
        <div style="background: #007bff; color: white; padding: 20px 40px; display: flex; flex-direction: column; justify-content: center;">
            <span style="font-size: 1.1em; opacity: 0.8;">Asset Name</span>
            <span style="font-size: 1.5em; font-weight: bold;">${investmentDTO.assetName}</span>
        </div>
        
        <div style="padding: 20px; flex-grow: 1; display: flex; align-items: center; gap: 30px;">
            <div>
                <p style="margin: 0; color: #888; font-size: 0.9em;">Total History</p>
                <p style="margin: 0; font-size: 1.4em; font-weight: bold;">${paginationInfo.totalRecordCount}건의 기록</p>
            </div>
            <div style="height: 40px; width: 1px; background: #eee;"></div>
            <div>
                <p style="margin: 0; color: #888; font-size: 0.9em;">Page Info</p>
                <p style="margin: 0; font-size: 1.1em;">현재 ${paginationInfo.currentPageNo} 페이지 조회 중</p>
            </div>
        </div>
    </div>
	</section>
</div>

<div class="container" style="margin-top: 30px;">
    <section id="listSection">
        <h3>📜 상세 거래 히스토리</h3>
        
        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>구분</th>
                    <th>단가</th>
                    <th>수량</th>
                    <th>날짜</th>
                    <th>메모</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty resultList}">
                        <c:forEach var="item" items="${resultList}">
                            <tr onclick="location.href='<c:url value="/investments/regist.do"><c:param name="id" value="${item.id}"/></c:url>';" 
    							style="cursor: pointer;">
                                <td>${item.rnum}</td> <td>
                                    <span class="${item.txType == 'BUY' ? 'type-buy' : 'type-sell'}">
                                        ${item.txType}
                                    </span>
                                </td>
                                <td><fmt:formatNumber value="${item.buyPrice}" pattern="#,###"/></td>
                                <td>${item.quantity}</td>
                                <td>${item.buyDate}</td>
                                <td><c:out value="${item.memo}" default="-"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="6" style="text-align:center;">거래 내역이 없습니다.</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div id="paging">
            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_link_page" />
        </div>
    </section>
</div>

<form id="listForm" action="<c:url value='/history.do'/>" method="get">
    <input type="hidden" name="assetName" value="${investmentDTO.assetName}" />
    <input type="hidden" name="pageIndex" id="pageIndex" value="${paginationInfo.currentPageNo}" />
</form>

<script type="text/javascript">
    function fn_link_page(pageNo) {
        document.getElementById("pageIndex").value = pageNo;
        document.getElementById("listForm").submit();
    }
</script>

</body>
</html>