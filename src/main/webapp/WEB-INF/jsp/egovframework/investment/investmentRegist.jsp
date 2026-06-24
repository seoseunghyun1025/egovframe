<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>투자 등록</title>
    <script src="/js/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/egovframework/investment/investmentRegist.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<body class="bg-light">
<main class="container mx-auto my-5">
    <c:choose>
        <c:when test="${not empty investmentDTO.id && investmentDTO.id > 0}">
        	<h2 class="d-flex align-items-center p-3 my-3 text-white bg-purple rounded shadow-sm" id="situation">📝 현재 투자 상황</h2>	
        </c:when>
        <c:otherwise>
        	<h2 class="d-flex align-items-center p-3 my-3 text-white bg-purple rounded shadow-sm" id="situation">📝 새로운 투자 등록</h2>
        </c:otherwise>
    </c:choose>
    <div class="my-3 p-3 bg-body rounded shadow-sm">
    <div class="row g-3">	
    <form id="investmentForm" class="needs-validation" action="<c:url value='/investment/regist.do'/>" method="post" novalidate>
    	<input type="hidden" name="id" value="${investmentDTO.id}">
    	<input type="hidden" name="memberId" value="${loginMember.memberId}">
    	
        <div class="col-12 mb-3">
            <label for="assetName" class="form-label">종목명</label>
            <div class="input-group has-validation">
            <input type="text" class="form-control" name="assetName" id="assetName" value="${investmentDTO.assetName}" placeholder="예: 나스닥100" required>
            <div class="invalid-feedback" >종목명을 입력하세요</div>
            </div>
        </div>
        
        <div class="col-12 mb-3">
            <label for="txType" class="form-label">거래 구분</label>
            <select id="txType" name="txType" class="form-select" required>
            	<option value>선택</option>
                <option value="BUY" <c:if test="${investmentDTO.txType == 'BUY'}">selected</c:if>>매수</option>
                <option value="SELL"  <c:if test="${investmentDTO.txType == 'SELL'}">selected</c:if>>매도</option>
            </select>
            <div class="invalid-feedback" >거래 구분을 선택하세요</div>
        </div>

        <div class="col-12 mb-3">
            <label for="buyPrice" class="form-label">단가</label>
            <input id="buyPrice" class="form-control" type="number" name="buyPrice" value="${investmentDTO.buyPrice}" min="1" required>
            <div class="invalid-feedback" >단가를 입력하세요
            </div>
        </div>

        <div class="col-12 mb-3">
            <label for="quantity" class="form-label">수량</label>
            <input type="number" class="form-control" name="quantity" value="${investmentDTO.quantity}" min="1" required>
            <div class="invalid-feedback" >수량을 입력하세요
            </div>
        </div>

        <div class="col-12 mb-3">
            <label for="date" class="form-label">날짜 (비워두면 오늘)
            	<span class="text-muted">(선택)</span>
            </label>
            <input class="form-control" type="date" id="date" value="${investmentDTO.buyDate}" name="buyDate">
        </div>

        <div class="col-12 mb-3">
            <label for="memo" class="form-label">메모
            	<span class="text-muted">(선택)</span>
            </label>
            <input class="form-control" id="memo" type="text" name="memo" value="${investmentDTO.memo}" placeholder="간단한 메모">
        </div>

        <%-- 히든 필드들도 name 값을 DTO에 맞게 설정 --%>
        <input type="hidden" name="commission" value="0">
        <div class="col-12 mb-3">
            <label for="commission" class="form-label">수수료</label>
            <input class="form-control" type="text" id="commission" name="commission" value="${investmentDTO.commission}" placeholder="간단한 메모">
        </div>
        
        <div class="col-12 mb-3">
            <h6>통화</h6>
            <div class="form-check">
            	<input type="radio" name="currency"  value="KRW" class="form-check-input" <c:if test="${investmentDTO.currency eq 'KRW'}">checked</c:if> required>
            	<label class="form-check-label" for="KRW">
            		KRW
            	</label>
            </div>
            <div class="form-check">
            	<input type="radio" name="currency"  value="USD" class="form-check-input" <c:if test="${investmentDTO.currency eq 'USD'}">checked</c:if> required>
            	<label class="form-check-label" for="USD">
            		USD
            	</label>
            </div>
            <div class="form-check">
            <input type="radio" name="currency"  value="EUR" class="form-check-input" <c:if test="${investmentDTO.currency eq 'EUR'}">checked</c:if> required>
            	<label class="form-check-label" for="USD">
            		EUR
            	</label>
            </div>
            <div class="form-check">
            <input type="radio" name="currency"  value="JPY" class="form-check-input" <c:if test="${investmentDTO.currency eq 'JPY'}">checked</c:if> required>
            	<label class="form-check-label" for="USD">
            		JPY
            	</label>
            </div>
        </div>
        
        <div class="col-12 mb-3">
            <label>거래소</label>
            <label for="exchange" class="form-label">거래소</label>
            <select id="exchange" name="exchange" size="1" class="form-select" required>
            	<option value="">선택</option>
            	<option value="1"<c:if test="${investmentDTO.exchange eq '1'}">selected</c:if>>한국투자증권</option>
            	<option value="2"<c:if test="${investmentDTO.exchange eq '2'}">selected</c:if>>토스증권</option>
            	<option value="3"<c:if test="${investmentDTO.exchange eq '3'}">selected</c:if>>카카오증권</option>
            	<option value="4"<c:if test="${investmentDTO.exchange eq '4'}">selected</c:if>>나무증권</option>
            </select>
            <div class="invalid-feedback" >거래 구분을 선택하세요</div>
        </div>
        
        <div class="btn-box">
    		<c:choose>
        		<c:when test="${not empty investmentDTO.id && investmentDTO.id > 0}">
            		<button type="submit" class="w-20 btn btn-primary">수정하기</button>
            		<button type="button" id="btn-delete" class="w-20 btn btn-danger" data-id="${investmentDTO.id}">삭제하기</button>
        		</c:when>
        		<c:otherwise>
            		<button type="submit" class="w-20 btn btn-dark">저장하기</button>
        		</c:otherwise>
    		</c:choose>
    		<button type="button" id="list" class="w-20 btn btn-outline-dark">취소</button>
		</div>
    </form>
    <form id="deleteForm" action="/investment/delete.do" method="post">
    	<input type="hidden" name="id" id="deleteId" value="">
	</form>
	</div>
	</div>
</main>
</body>
	<script type="text/javascript">        
        $(document).ready(function(){
			$("#btn-delete").on("click", function(){
				var id = $(this).data("id");
				$("#deleteId").val(id);
				$("#deleteForm").submit();
			})
			
			$("#list").click(function() {
    			window.location = "/investment/list.do";
        	})
        })
	</script>
	<script src="/js/Bootstrap/form-validation.js"></script>
</html>