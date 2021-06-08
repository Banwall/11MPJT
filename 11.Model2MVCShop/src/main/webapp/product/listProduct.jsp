<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<html>
<head>
<title><c:if test="${menu == 'manage' }">
			��ǰ��� ��ȸ
		</c:if>
		<c:if test="${ menu == 'search' }">
			��ǰ�˻�
	</c:if>
</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	function fncGetList(currentPage){
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}
	
	$( function() {
		
		$( "td.ct_btn01:contains('�˻�')").on("click", function() {
			
			fncGetList(1);
			
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			//Debug..
			//alert(  $( this ).text().trim() );
			//alert(  $( this ).text().trim() );
			var prodNo = $(this).find('input').val()
			self.location ="/product/getProduct?prodNo="+prodNo+"&menu=${menu}";
			
			alert("prodNo="+prodNo+"&menu=${menu}")
		});
		
	});
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=${ menu }" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						<c:if test="${menu == 'manage' }">
							��ǰ����
						</c:if>
						<c:if test="${ menu == 'search' }">
							��ǰ��� ��ȸ
						</c:if>
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<c:if test="${ user.role == 'admin' }">
					<option value="0" ${! empty search.searchCondition && search.searchCondition== 0 ? "selected" : ""  }>��ǰ��ȣ</option>
				</c:if>
				<option value="1" ${! empty search.searchCondition && search.searchCondition== 1 ? "selected" : ""  }>��ǰ��</option>
				<option value="2" ${! empty search.searchCondition && search.searchCondition== 2 ? "selected" : ""  }>��ǰ����</option>
			</select>
			<input type="text" name="searchKeyword" value="${search.searchKeyword }" class="ct_input_g" style="width:200px; height:19px" />
		</td>
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetList('1');">�˻�</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >��ü ${ resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b"><c:choose>
								<c:when test="${ user.role == 'user' || empty user }">
	
								</c:when>
								<c:otherwise>
									�����
								</c:otherwise>
						      </c:choose>
		</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
		<c:forEach var="purchase" items="${list}">
		<c:set var="product" value="${product}"/>
		<c:set var="i" value="${i+1}"/>
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
				<td align="left">
				<c:choose>
				<c:when test="${user.userId == 'admin'}">
					<%-- ///////////////////////////////////////////////////////////////////////////////////////////////////
					<a href="/product/getProduct?prodNo=${purchase.prodNo}&menu=${menu}">${purchase.prodName}</a>
					/////////////////////////////////////////////////////////////////////////////////////////////////// --%>
					${purchase.prodName}
					<input type="hidden" id="prodNo" value="${purchase.prodNo}"/>
				</c:when>
				<c:otherwise>
					<c:choose>
					<c:when test="${ empty product.proTranCode }">
							<a href="/product/getProduct?prodNo=${purchase.prodNo}&menu=${ menu }">${purchase.prodName}</a>
					</c:when>
					<c:otherwise>
						${purchase.prodName}
					</c:otherwise>
					</c:choose>
				</c:otherwise>
				</c:choose>
				</td>
		<td></td>
		<td align="left">${ purchase.price }</td>
		<td></td>
		<td align="left"><c:choose>
							<c:when test="${user.role == 'user' || empty user}">

							</c:when>
							<c:otherwise>
							${ purchase.regDate}
							</c:otherwise>
						</c:choose>
		</td>
		<td></td>
		<td align="left">
		 	<c:choose>
		 		<c:when test="${user.userId == 'admin'}">
		 			<c:if test="${empty product.proTranCode}">
		 				�Ǹ���
		 			</c:if>
		 			<c:if test="${ product.proTranCode == '1' }">
		 				���ſϷ�
		 				
		 				<c:if test="${ menu == 'manage' }">
		 					<a href="/updateTranCodeByProd.do?prodNo=${product.prodNo }&proTranCode=2">����ϱ�</a>
		 				</c:if>
		 			</c:if>
		 			<c:if test="${ product.proTranCode == '2' }">
		 				�����
		 			</c:if>
		 			<c:if test="${ product.proTranCode == '3' }">
		 			<c:choose>
		 				<c:when test="${ menu == 'manage' }">
		 					��ۿϷ�
		 				</c:when>
		 				<c:otherwise>
		 					������
		 				</c:otherwise>
		 			</c:choose>
		 			</c:if>
		 		</c:when>
		 		<c:otherwise>
		 			<c:choose>
		 				<c:when test="${empty product.proTranCode}">
		 					�Ǹ���
		 				</c:when>
		 				<c:otherwise>
		 					������
		 				</c:otherwise>
		 			</c:choose>
		 		</c:otherwise>
		 	</c:choose>
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	
	</c:forEach>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<input type="hidden" id="currentPage" name="currentPage" value=""/>
		<td align="center">
			<jsp:include page="../common/pageNavigator.jsp"/>
		</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
