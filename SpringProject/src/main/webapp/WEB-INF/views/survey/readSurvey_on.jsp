<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<div class="container mt-5">
	<div class="row tm-content-row">
		<div class="tm-block-col tm-col-account-settings-show">
			<div class="tm-bg-primary-dark tm-block tm-block-settings">
				<form id="voteform" method="post" class="tm-signup-form row"> <!-- action 추가 ?? 생략 ??-->
					<input type="hidden" id="survey_seq" name="survey_seq" value="${survey.survey_seq}">
					<div class="form-group col-lg-4 fa-2x">
						<label class="tm-block-title" for="Title">Title</label>
					</div>
					<div class="form-group col-lg-8">
						<label for="TitleEL">${ survey.title }</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="form-group col-lg-4">
						<label for="Writer">Writer</label>
					</div>
					<div class="form-group col-lg-8">
						<label for="WriterEL">${ survey.name }</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="form-group col-lg-4">
						<label for="Period">기간</label>
					</div>
					<div class="form-group col-lg-8">
						<label for="PeriodEL"> 
						<fmt:formatDate value="${ survey.reg_date }" pattern="yy-MM-dd" /> 
						~ <fmt:formatDate value="${ survey.end_date }" pattern="yy-MM-dd" />
						</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="col-12">
						<h2 class="tm-block-title">목록</h2>
						<div class="form-group col-lg-12">
							<!-- 동적으로 설문지 보기 생성 or 그래프 출력 -->
							<c:forEach items="${ survey.surveyItemList }" var="item" varStatus="status">
								<label class="tm-hide-sm">
									<span style="vertical-align: super;">${ status.count } - ${ item.content }</span>
									&nbsp;&nbsp;
									<input name=itemSeq type="radio"
									class="form-control validate" value="${ item.survey_item_seq }"
									style="display: inline-block">
								</label><br>
							</c:forEach>
						</div>
					</div>
					<div class="col-12">
						<div class="form-group col-lg-3" style="float:left;">
						<c:choose>
							<c:when test="${ survey.member_seq eq pageContext.request.userPrincipal.principal.member_seq }">
								<button type="submit" id="surveyClose" class="btn btn-primary text-uppercase btn-show">마감</button>
							</c:when>
							<c:otherwise>
							<s:authorize ifAllGranted="ROLE_ADMIN">
								<button type="button" id="surveyClose" class="btn btn-primary text-uppercase btn-show">마감</button>
							</s:authorize>
							</c:otherwise>
						</c:choose>	
						<c:if test="${ survey.member_seq eq pageContext.request.userPrincipal.principal.member_seq}">
							<button type="button" id="surveyRemove" class="btn btn-primary text-uppercase btn-show">삭제</button>
						</c:if>
						</div>
						<div class="form-group col-lg-3" style="float:right;">
							<button type="button" id="surveyVote" class="btn btn-primary text-uppercase btn-show">투표</button>
							<button type="button" id="surveyHome" class="btn btn-primary text-uppercase btn-show">홈</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	
	$("surveyHome").on("click", function() {
		event.preventDefault();
		location.herf="/survey/main";
	});
	$("surveyVote").on("click", function() {
		event.preventDefault();
		var form = $("#voteform")[0];
		$(form).attr("action", "readSurvey_on");

		$(form).submit();
	});
	$("surveyClose").on("click", function() {
		event.preventDefault();
		var form = $("#voteform")[0];
		$(form).attr("action", "closeSurvey");
		$(form).submit();
	});
	$("surveyRemove").on("click", function() {
		event.preventDefault();
		var form = $("#voteform")[0];
		$(form).attr("action", "removeSurvey");
		$(form).submit();
	});
</script>