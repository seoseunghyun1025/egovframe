<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항 작성</title>
	<script src="/js/jquery.min.js"></script>
</head>
<body>
	<h2>공지사항 작성</h2>
    
    <form action="/notice/insertNotice.do" method="POST" enctype="multipart/form-data">
        <table border="1">
            <tr>
                <th>작성자 ID</th>
                <td><input type="text" name="writeId" required></td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="noticeTitle" required></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="noticeContent" rows="10" cols="50" required></textarea></td>
            </tr>
            <tr><td id="fileIndex">
				<input type="file" name="file" />
			<div>  
			 <button id="fileAdd_btn" class="btn btn-primary" type="button">파일추가+</button>
			</div>
			</td></tr>
        </table>
        <br>
        <button type="submit">등록</button>
        <a href="/notice/noticeList.do">취소</a>
    </form>
   	<script type="text/javascript">
        $(document).ready(function() {
            var fileIndex = 1;
            $("#fileAdd_btn").on("click", function(e) {
                e.preventDefault();
                var fileHtml = "<div class='file-item'>" +
                               "<input type='file' name='file_" + fileIndex + "' /> " +
                               "<button type='button' class='fileDel_btn'>삭제</button>" +
                               "</div>";
                $("#fileIndex").append(fileHtml);
                fileIndex++;
            });
            
            $(document).on("click", ".fileDel_btn", function(e) {
                e.preventDefault();
                $(this).parent().remove();
            });
        });
    </script>
</body>
</html>