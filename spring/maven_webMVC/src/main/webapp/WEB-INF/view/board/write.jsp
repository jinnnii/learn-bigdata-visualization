<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="border border-info p-4 rounded">
	<h5>게시판 새글쓰기</h5>

	<hr class="featurette-divider">

	<form action="" method="POST">
		<div class="form-group">
			<label for="id">아이디</label> <input type="text" class="form-control"
				id="id" aria-describedby="idHelp" name="id" value="user1" readonly>
		</div>

		<div class="form-group">
			<label for="subject">제목</label> <input type="text"
				class="form-control" id="subject" name="subject" autofocus>
		</div>

		<div class="form-group">
			<label for="content">내용</label>
			<textarea class="form-control" id="content" rows="10" name="content"></textarea>
		</div>

		<div class="form-group">
			<label for="exampleFormControlFile1">첨부 파일</label> <input type="file"
				class="form-control-file" id="exampleFormControlFile1">
		</div>

		<div class="my-4 text-center">
			<button type="submit" class="btn btn-primary">
				<i class="material-icons align-middle">create</i> <span
					class="align-middle">새글등록</span>
			</button>
			<button type="reset" class="btn btn-primary ml-3">
				<i class="material-icons align-middle">clear</i> <span
					class="align-middle">초기화</span>
			</button>
			<button type="button" class="btn btn-primary ml-3"
				onclick="location.href = '/board/boardList.html';">
				<i class="material-icons align-middle">list</i> <span
					class="align-middle">글목록</span>
			</button>
		</div>
	</form>

</div>