<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>투자 상세 히스토리</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* 1. 확실한 베이지 배경색 */
        body { 
            background-color: #f9f9f9; /* 따뜻한 베이지 톤 */
            font-family: 'Malgun Gothic', sans-serif; 
            margin: 0; 
            padding: 40px 0; /* 상하 여유 */
        }

        .container { 
            max-width: 1000px; 
            margin: 0 auto; 
        }

        /* 2. 개별 카드 (화이트 보드) 스타일 */
        .card {
            background: #ffffff; /* 순백색 카드 */
            border-radius: 15px; /* 좀 더 둥글게 */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08); /* 입체감 있는 그림자 */
            padding: 35px;
            margin-bottom: 40px; /* 🔥 카드끼리 절대 안 붙게 간격 대폭 추가 */
            border: none;
        }

        /* 📝 상단 수정 폼 전용 (기존 로직 유지) */
        #editSection { display: none; border: 2px solid #4485f4; } 
        .form-header { 
            font-size: 1.3em; font-weight: bold; margin-bottom: 25px; 
            padding-bottom: 12px; border-bottom: 1px solid #eee;
            display: flex; align-items: center; gap: 10px;
        }
        .form-grid { display: flex; flex-direction: column; gap: 18px; }
        .form-item { display: flex; flex-direction: column; }
        .form-item label { font-size: 0.95em; font-weight: bold; color: #333; margin-bottom: 8px; }
        .form-item input, .form-item select { 
            padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1em; background: #fafafa;
        }

        /* 📊 요약 정보 카드 (그림 완벽 재현) */
        .summary-card-layout {
            display: flex; padding: 0; overflow: hidden; height: 130px;
        }
        .summary-blue-zone {
            background: #4485f4; color: white; width: 240px;
            display: flex; flex-direction: column; justify-content: center; align-items: center;
        }
        .summary-info-zone {
            flex: 1; display: flex; align-items: center; padding-left: 50px; gap: 60px;
        }
        .stat-group { display: flex; flex-direction: column; }
        .stat-tit { font-size: 0.9em; color: #999; margin-bottom: 6px; }
        .stat-val { font-size: 1.5em; font-weight: bold; color: #222; }

        /* 📜 테이블 스타일 */
        .table-header-area { font-size: 1.3em; font-weight: bold; margin-bottom: 25px; display: flex; align-items: center; gap: 10px; }
        table { width: 100%; border-collapse: collapse; }
        thead th { background: #4485f4; color: white; padding: 18px; font-size: 1em; border-right: 1px solid rgba(255,255,255,0.1); }
        thead th:last-child { border-right: none; }
        tbody td { padding: 18px; border-bottom: 1px solid #f0f0f0; text-align: center; color: #444; font-size: 1.05em; }
        .history-row:hover { background-color: #f8faff; cursor: pointer; }
        
        .type-buy { color: #e54d42; font-weight: bold; }
        .type-sell { color: #2e5bff; font-weight: bold; }

        /* 버튼 디자인 */
        .btn-box { display: flex; gap: 12px; margin-top: 30px; }
        .btn-ui { padding: 12px 25px; border-radius: 8px; cursor: pointer; border: 1px solid #ddd; font-weight: bold; background: #f8f9fa; color: #555; }
        .btn-cancel { background: #555; color: white; border: none; }

        /* 페이징 */
        .page-nav { margin-top: 35px; text-align: center; }
    </style>
</head>
<body>

<div class="container">
    
    <section id="editSection" class="card">
        <div class="form-header">📝 현재 투자 상황</div>
        <form id="editForm">
            <input type="hidden" id="edit-id">
            <div class="form-grid">
                <div class="form-item"><label>종목명</label><input type="text" id="edit-assetName" readonly></div>
                <div class="form-item">
                    <label>거래 구분</label>
                    <select id="edit-txType">
                        <option value="BUY">매수</option>
                        <option value="SELL">매도</option>
                    </select>
                </div>
                <div class="form-item"><label>단가</label><input type="number" id="edit-buyPrice"></div>
                <div class="form-item"><label>수량</label><input type="number" step="0.1" id="edit-quantity"></div>
                <div class="form-item"><label>날짜 (비워두면 오늘)</label><input type="date" id="edit-buyDate"></div>
                <div class="form-item"><label>메모</label><input type="text" id="edit-memo" placeholder="간단한 메모"></div>
            </div>
            <div class="btn-box">
                <button type="button" class="btn-ui">수정하기</button>
                <button type="button" class="btn-ui">삭제하기</button>
                <button type="button" class="btn-ui btn-cancel" onclick="fn_hide_edit()">취소</button>
            </div>
        </form>
    </section>

    <section class="card summary-card-layout">
        <div class="summary-blue-zone">
            <div style="font-size: 0.95em; opacity: 0.9;">Asset Name</div>
            <div style="font-size: 1.7em; font-weight: bold; margin-top: 8px;">${investmentDTO.assetName}</div>
        </div>
        <div class="summary-info-zone">
            <div class="stat-group">
                <span class="stat-tit">Total History</span>
                <span class="stat-val">${paginationInfo.totalRecordCount}건의 기록</span>
            </div>
            <div style="width: 1px; height: 50px; background: #eee;"></div>
            <div class="stat-group">
                <span class="stat-tit">Page Info</span>
                <span class="stat-val">현재 ${paginationInfo.currentPageNo} 페이지 조회 중</span>
            </div>
        </div>
    </section>

    <section class="card">
        <div class="table-header-area">📜 상세 거래 히스토리</div>
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
                <c:forEach var="item" items="${resultList}">
                    <tr class="history-row" onclick="fn_show_edit({
                        id: '${item.id}',
                        assetName: '${item.assetName}',
                        txType: '${item.txType}',
                        buyPrice: '${item.buyPrice}',
                        quantity: '${item.quantity}',
                        buyDate: '${item.buyDate}',
                        memo: '${item.memo}'
                    })">
                        <td>${item.rnum}</td>
                        <td class="${item.txType == 'BUY' ? 'type-buy' : 'type-sell'}">${item.txType}</td>
                        <td><fmt:formatNumber value="${item.buyPrice}" pattern="#,###"/></td>
                        <td>${item.quantity}</td>
                        <td>${item.buyDate}</td>
                        <td style="text-align: left; padding-left: 30px;"><c:out value="${item.memo}" default="-"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="page-nav">
            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_link_page" />
        </div>
    </section>

</div>

<script>
    function fn_link_page(pageNo) {
        location.href = "<c:url value='/history.do'/>?assetName=${investmentDTO.assetName}&pageIndex=" + pageNo;
    }

    function fn_show_edit(data) {
        $("#edit-id").val(data.id);
        $("#edit-assetName").val(data.assetName);
        $("#edit-txType").val(data.txType);
        $("#edit-buyPrice").val(data.buyPrice);
        $("#edit-quantity").val(data.quantity);
        $("#edit-buyDate").val(data.buyDate);
        $("#edit-memo").val(data.memo);

        $("#editSection").slideDown(500);
        $('html, body').animate({ scrollTop: 0 }, 500);
    }

    function fn_hide_edit() {
        $("#editSection").slideUp(400);
    }
</script>

</body>
</html>