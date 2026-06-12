<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>투자 등록</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/investment/investment.css'/>">
    <script src="/js/jquery.min.js"></script>
</head>
<body>

<div class="container">
    <c:choose>
        <c:when test="${not empty investmentDTO.id && investmentDTO.id > 0}">
        	<h2>📝 현재 투자 상황</h2>	
        </c:when>
        <c:otherwise>
        	<h2>📝 새로운 투자 등록</h2>
        </c:otherwise>
    </c:choose>
    		
    <form id="investmentForm" action="<c:url value='/investment/regist.do'/>" method="post">
    	<input type="hidden" name="id" value="${investmentDTO.id}">
    	<input type="hidden" name="memberId" value="${loginMember.memberId}">
    	
        <div class="form-group">
            <label>종목명</label>
            <input type="text" name="assetName" value="${investmentDTO.assetName}" required placeholder="예: 나스닥100">
        </div>
        
        <div class="form-group">
            <label>거래 구분</label>
            <select name="txType">
                <option value="BUY" <c:if test="${investmentDTO.txType == 'BUY'}">selected</c:if>>매수</option>
                <option value="SELL"  <c:if test="${investmentDTO.txType == 'SELL'}">selected</c:if>>매도</option>
            </select>
        </div>

        <div class="form-group">
            <label>단가</label>
            <input type="number" name="buyPrice" value="${investmentDTO.buyPrice}" step="0.01" required>
        </div>

        <div class="form-group">
            <label>수량</label>
            <input type="number" name="quantity" value="${investmentDTO.quantity}" step="0.01" required>
        </div>

        <div class="form-group">
            <label>날짜 (비워두면 오늘)</label>
            <input type="date" value="${investmentDTO.buyDate}" name="buyDate">
        </div>

        <div class="form-group">
            <label>메모</label>
            <input type="text" name="memo" value="${investmentDTO.memo}" placeholder="간단한 메모">
        </div>

        <%-- 히든 필드들도 name 값을 DTO에 맞게 설정 --%>
        <input type="hidden" name="commission" value="0">
        <div class="form-group">
            <label>수수료</label>
            <input type="text" name="commission" value="${investmentDTO.commission}" placeholder="간단한 메모">
        </div>
        
        <div class="form-group">
            <label>통화</label>
            <input type="radio" name="currency"  value="KRW" <c:if test="${investmentDTO.currency eq 'KRW'}">checked</c:if>>KRW
            <input type="radio" name="currency"  value="USD" <c:if test="${investmentDTO.currency eq 'USD'}">checked</c:if>>USD
            <input type="radio" name="currency"  value="EUR" <c:if test="${investmentDTO.currency eq 'EUR'}">checked</c:if>>EUR
            <input type="radio" name="currency"  value="JPY" <c:if test="${investmentDTO.currency eq 'JPY'}">checked</c:if>>JPY
        </div>
        
        <div class="form-group">
            <label>거래소</label>
            <select id="exchange" name="exchange" size="1">
            	<option value="">선택</option>
            	<option value="${investmentDTO.exchange}"<c:if test="${investmentDTO.exchange eq '한국투자증권'}">selected</c:if>>한국투자증권</option>
            	<option value="${investmentDTO.exchange}"<c:if test="${investmentDTO.exchange eq '토스증권'}">selected</c:if>>토스증권</option>
            	<option value="${investmentDTO.exchange}"<c:if test="${investmentDTO.exchange eq '카카오증권'}">selected</c:if>>카카오증권</option>
            	<option value="${investmentDTO.exchange}"<c:if test="${investmentDTO.exchange eq '나무증권'}">selected</c:if>>나무증권</option>
            </select>
        </div>
        
        <div class="btn-box">
    		<c:choose>
        		<c:when test="${not empty investmentDTO.id && investmentDTO.id > 0}">
            		<button type="submit" class="btn-update">수정하기</button>
            		<button type="button" class="btn-delete" data-id="${investmentDTO.id}">삭제하기</button>
        		</c:when>
        		<c:otherwise>
            		<button type="submit" class="btn-save">저장하기</button>
        		</c:otherwise>
    		</c:choose>
    		<button type="button" id="list">취소</button>
		</div>
    </form>
    <form id="deleteForm" action="/investment/delete.do" method="post">
    	<input type="hidden" name="id" id="deleteId" value="">
	</form>
</div>
</body>
	<script>console.log('${loginMember.memberId}');</script>
	<script type="text/javascript">
	window.onload = function() {
        var mainForm = document.getElementById("investmentForm");
        if (mainForm) {
            mainForm.onsubmit = function() {
                return confirm("저장하시겠습니까?");
            };
        }
    };
		/* function fn_delete(id){
			if(confirm("정말로 이 투자 기록을 삭제하시겠습니까?\n(삭제된 데이터는 목록에서 제거됩니다.)")){
				document.getElementById("deleteId").value = id;
				document.getElementById("deleteForm").submit();
			}
		} */
		
		document.getElementById("investmentForm").onsubmit = function(){
			return confirm("입력하신 정보로 저장하시겠습니까?");
		}
		
		
        
        $(document).ready(function(){
			$(".btn-delete").on("click", function(){
				var id = $(this).data("id");
				$("#deleteId").val(id);
				$("#deleteForm").submit();
			})
			
			$("#list").click(function() {
    			window.location = "/investment/listForm.do";
        	})
        })

	</script>
</html>