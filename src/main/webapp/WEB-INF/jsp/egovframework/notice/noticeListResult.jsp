<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table border="1" class="table">
    <thead class="table-light">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성일</th>
            <th>작성자</th>
        </tr>
    </thead>
    <tbody class="table-group-divider">
        <c:forEach var="notice" items="${noticeList}" varStatus="status">
            <tr>
                <td>${start + status.count}</td>
                <td class="notice-link" style="cursor: pointer;" data-uuid="${notice.noticeUuid}">
                    ${notice.noticeTitle}
                </td>
                <td>
                    <fmt:parseDate value="${notice.registryDate}" pattern="yyyy-MM-dd" var="parsedDateTime" type="both"/>
                    <fmt:formatDate pattern="yyyy-MM-dd" value="${parsedDateTime}" />
                </td>
                <td>${notice.writeId}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty noticeList}">
            <tr>
                <td colspan="4">등록된 공지사항이 없습니다.</td>
            </tr>
        </c:if>
    </tbody>
</table>

<nav aria-label="Page navigation example">
    <ul class="pagination justify-content-center">
        <c:forEach var="pageNo" begin="1" end="${repeat}">
            <li class="page-item ${page == pageNo ? 'active' : ''}">
                <a class="page-link" href="javascript:fn_go_page('${pageNo}');">${pageNo}</a>
            </li>
        </c:forEach>
    </ul>
</nav>