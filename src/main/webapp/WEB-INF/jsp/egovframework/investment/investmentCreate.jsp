<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>투자 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/egovframework/investment/investment.css">
    <style>
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input, .form-group select { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn-box { margin-top: 20px; display: flex; gap: 10px; }
        button { padding: 10px 20px; cursor: pointer; border: none; border-radius: 5px; }
        .btn-save { background-color: #007bff; color: white; }
        .btn-cancel { background-color: #6c757d; color: white; }
    </style>
</head>
<body>

<div class="container">
    <h2>📝 새로운 투자 등록</h2>
    
    <form id="investmentForm">
        <div class="form-group">
            <label>종목명</label>
            <input type="text" id="assetName" required placeholder="예: 삼성전자">
        </div>
        
        <div class="form-group">
            <label>거래 구분</label>
            <select id="txType">
                <option value="BUY">매수</option>
                <option value="SELL">매도</option>
            </select>
        </div>

        <div class="form-group">
            <label>단가</label>
            <input type="number" id="buyPrice" step="0.01" required>
        </div>

        <div class="form-group">
            <label>수량</label>
            <input type="number" id="quantity" step="0.01" required>
        </div>

        <div class="form-group">
            <label>날짜 (비워두면 오늘)</label>
            <input type="date" id="buyDate">
        </div>

        <div class="form-group">
            <label>메모</label>
            <input type="text" id="memo" placeholder="간단한 메모">
        </div>

        <input type="hidden" id="commission" value="0">
        <input type="hidden" id="currency" value="KRW">
        <input type="hidden" id="exchange" value="KOSPI">

        <div class="btn-box">
            <button type="submit" class="btn-save">저장하기</button>
            <button type="button" class="btn-cancel" onclick="location.href='${pageContext.request.contextPath}/investments/investmentList.do'">취소</button>
        </div>
    </form>
</div>

<script>
    const ctx = '${pageContext.request.contextPath}';

    document.getElementById('investmentForm').addEventListener('submit', async (e) => {
        e.preventDefault();

        const formData = {
            assetName: document.getElementById('assetName').value,
            txType: document.getElementById('txType').value,
            buyPrice: parseFloat(document.getElementById('buyPrice').value),
            quantity: parseFloat(document.getElementById('quantity').value),
            buyDate: document.getElementById('buyDate').value,
            memo: document.getElementById('memo').value,
            commission: parseFloat(document.getElementById('commission').value),
            currency: document.getElementById('currency').value,
            exchange: document.getElementById('exchange').value
        };

        try {
            // 사수님이 정해주신 데이터 저장 API 주소
            const response = await fetch(ctx + '/investments/insertInvestment.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                alert('등록에 성공했습니다!');
                // 저장 성공 후 리스트 화면(.do)으로 이동
                location.href = ctx + '/investments/investmentList.do';
            } else {
                const errorText = await response.text();
                throw new Error(errorText || '등록 실패');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('저장 중 오류가 발생했습니다: ' + error.message);
        }
    });
</script>

</body>
</html>