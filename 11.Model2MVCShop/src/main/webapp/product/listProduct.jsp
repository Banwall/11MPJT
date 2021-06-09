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
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
    <!-- jQuery UI toolTip ��� CSS-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery UI toolTip ��� JS-->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
<script type="text/javascript">

	function fncGetList(currentPage){
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${menu}").submit();
	}
	
	$(function() {
		 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 $( "button.btn.btn-default" ).on("click" , function() {
		 	fncGetList(1);
		 });
	});
	
	$( function() {
		
		$( "td:nth-child(2)" ).on("click" , function() {
			//Debug..
			//alert(  $( this ).text().trim() );
			//alert(  $( this ).text().trim() );
			var prodNo = $(this).find('input').val()
			self.location ="/product/getProduct?prodNo="+prodNo+"&menu=${menu}";
			
			//alert("prodNo="+prodNo+"&menu=${menu}")
		});
		
		$( "td:nth-child(2)" ).css("color" , "skyblue");
		
	});
	
	$(function() {
		 
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(  "td:nth-child(6) > i" ).on("click" , function() {

			var prodNo = $(this).next().val()
			
			$.ajax( 
					{

						url : "/product/json/getProduct/"+prodNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {

							var displayValue = "<h6>"
														+"��ǰ�� : "+JSONData.prodName+"<br/>"
														+"��ǰ������ : "+JSONData.prodDetail+"<br/>"
														+"���� : "+JSONData.price+"<br/>"
														+"��ǰ�̹��� : "+JSONData.fileName+"<br/>"
														+"</h6>";
							$("h6").remove();
							$( "#"+prodNo+"" ).html(displayValue);
						}
				});
				////////////////////////////////////////////////////////////////////////////////////////////
			
		});
		
	});
	
</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
	
		<div class="page-header text-info">
			<c:if test="${ menu == 'manage' }"><h3>�ǸŻ�ǰ����</h3></c:if>
			<c:if test="${ menu == 'search' }"><h3>�ǸŻ�ǰ���</h3></c:if>
	    </div>
	    
	    <div class="row">
	    
		  <div class="col-md-6 text-left">
		    <p class="text-primary">
		    	��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    </p>
		</div>

		<div class="col-md-6 text-right">
			<form class="form-inline" name="detailForm">
			    
			<div class="form-group">
				<select class="form-control" name="searchCondition" >
				<c:if test="${ user.role == 'admin' }">
					<option value="0" ${! empty search.searchCondition && search.searchCondition== 0 ? "selected" : ""  }>��ǰ��ȣ</option>
				</c:if>
				<option value="1" ${! empty search.searchCondition && search.searchCondition== 1 ? "selected" : ""  }>��ǰ��</option>
				<option value="2" ${! empty search.searchCondition && search.searchCondition== 2 ? "selected" : ""  }>��ǰ����</option>
				</select>
			</div>
		
		<div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
			</form>
	    	</div>
	    	
		</div>


	<div class="row">
   
      <c:forEach var="product" items="${list}" >
        <div class="col-sm-6 col-md-4">
          <div class="thumbnail">
            <img src="/images/uploadFiles/${product.fileName}" width="200" height="auto">
            <div class="caption" align="center">
              <h3>${ product.prodName }</h3>
              <p>&#8361;${ product.price }</p>
              <p><a href="/product/getProduct?prodNo=${product.prodNo}&menu=search&currentPage=${search.currentPage}" class="btn btn-primary" role="button">�󼼺���</a> 
              <a href="/purchase/addPurchaseView/${ product.prodNo }" class="btn btn-default" role="button">�����ϱ�</a></p>
            </div>
          </div>
        </div>
      </c:forEach>   
        
   </div>
		


	<jsp:include page="../common/pageNavigator_new.jsp"/>

</div>
</body>
</html>
