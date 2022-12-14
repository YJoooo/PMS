<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<%--


 --%>
 
<html>
<style>
	td{text-align:center;}
	body {
	    margin: 40px 10px;
	    padding: 0;
	    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	    font-size: 14px;
	}
	#calendar {
	   max-width: 1100px;
	   margin: 0 auto;
	}
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>

<head>
<meta charset="UTF-8">

<link href='${path}/a00_com/lib/main.css' rel='stylesheet' />
<script src='${path}/a00_com/lib/main.js'></script>
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css" >
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >

  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>PMS Calendar</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="NiceAdmin/assets/img/favicon.png" rel="icon">
  <link href="NiceAdmin/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="NiceAdmin/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="NiceAdmin/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="NiceAdmin/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="NiceAdmin/assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="NiceAdmin/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="NiceAdmin/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="NiceAdmin/assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="NiceAdmin/assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: NiceAdmin - v2.3.1
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
<script src="https://code.jquery.com/jquery-3.6.0.js" type="text/javascript"></script>
<script type="text/javascript"> 

	document.addEventListener('DOMContentLoaded', function() {
		
		// ?????? ?????? ?????? ?????? ?????? ????????? ??????
		var toDay = new Date()
		var date = toDay.toISOString().split("T")[0]
		console.log(date)
		
	    var calendarEl = document.getElementById('calendar');
		
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	      headerToolbar: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'dayGridMonth,timeGridWeek,timeGridDay'
	      },
	      initialDate: date,
	      navLinks: true, // can click day/week names to navigate views
	      selectable: true,
	      selectMirror: true,
	      select: function(arg) {
	    	  $("#regBtn").show()
	    	  $("#uptBtn").hide()
	    	  $("#delBtn").hide()
	    	  
	    	  $("#exampleModalLongTitle").text("????????????");
	    	  $("#frm01")[0].reset(); // ?????? ????????? ????????? ?????? ??????..
	    	  $("#modalBox").click(); // ????????? ??????:???????????? ?????? ???????????? ????????? ?????? ?????? ?????? ??????..
	    	  console.log("#fullcalendar ?????????#")
	    	  console.log(arg)
	    	  console.log(arg.start)
	    	  console.log(arg.end)
	    	  console.log(arg.color) // ???????????? ?????? ??????
	    	  console.log(arg.textColor) // ???????????? ?????? ??????
	    	  console.log(arg.allDay)
	    	  // arg.start.toISOString() : GMT ?????? ???????????? ?????????.
	    	  $("#frm01 [name=start]").val(arg.start.toISOString())
	    	  $("#frm01 [name=end]").val(arg.end.toISOString())
	    	  $("#frm01 [name=allDay]").val(""+arg.allDay)
	    	  $("#frm01 [name=pno]").val(pno)
	    	  // ????????? ??????????????? ?????? ??????..
	      },
	      // ?????? ???????????? ?????????, (?????? ????????? ?????? ??????/??????..)
	      eventClick: function(arg) {
	    	  $("#regBtn").hide()
	    	  $("#uptBtn").show()
	    	  $("#delBtn").show()
	    	  $("#exampleModalLongTitle").text("????????????");
	    	  $("#modalBox").click(); // ????????? ??????.. 
	    	  formData(arg.event)
	      },
	      eventDrop:function(info){
	    	  // ????????? ???????????? ???????????? ???, ?????? ??????
	    	  formData(info.event)
	   	  	  $("#frm01").attr("action","${path}/calUpdate.do");
	   	  	  $("#frm01").submit();   	  
	      },
	      eventResize:function(info){
	    	  // ??????????????? ???????????? ?????????..
	    	  formData(info.event)
	   	  	  $("#frm01").attr("action","${path}/calUpdate.do");
	   	  	  $("#frm01").submit();
	      },
	      
	      editable: true,
	      dayMaxEvents: true, // allow "more" link when too many events
	      events: function(info, successCallback, failureCallback){
	    	  // http://localhost:6080/PMS/calList.do callist
	    	  $.ajax({
	    		  type:"post",
	    		  url:"${path}/calList.do",
	    		  dataType:"json",
	    		  success:function(data){
	    			  console.log(data.callist)
	    			  successCallback(data.callist)
	    		  },
	    		  error:function(err){
	    			  console.log(err)
	    		  }
	    		  
	    	  });
	    	  
	      }
	    });

	    calendar.render();

	  });
	
		var pno = "${pno}";
	  function formData(event){
		  // ??????????????? ?????? ?????? ????????? ????????????..
	 	  $("#frm01 [name=id]").val(event.id)
	 	  $("#frm01 [name=pno]").val(pno)
	 	  $("#frm01 [name=sno]").val(event.sno)
	 	  $("#frm01 [name=title]").val(event.title)
	 	  $("#frm01 [name=start]").val(event.start.toISOString())
	 	  if(event.end!=null){
		  	$("#frm01 [name=end]").val(event.end.toISOString())
	 	  }else{
	 		 $("#frm01 [name=end]").val(event.start.toISOString())  
	 	  }
		  $("#frm01 [name=backgroundColor]").val(event.backgroundColor)
		  $("#frm01 [name=textColor]").val(event.textColor)
		  $("#frm01 [name=allDay]").val(""+event.allDay)   	  
		  $("#frm01 [name=content]").val(event.extendedProps.content)  	  
	  }
	  
</script>
</head>
<body>
<jsp:include page="navi.jsp"/>
<main id="main" class="main">
<div id='calendar'></div>
<h2 data-toggle="modal" id="modalBox"  
	data-target="#exampleModalCenter" style="display:none;">????????? ??????</h2>

<!-- 
????????? data-target="#exampleModalCenter"??? ??? DOM??? ?????????,
???????????? ??????..



?????? ??? ??????.. -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">?????????</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body">
		<form id="frm01" class="form"  method="get">
			<input type="hidden" name="id" value="0"/>
			<input type="hidden" name="pno" value="0"/>
			<input type="hidden" name="sno" value="0"/>
	     <div class="row">
	      <div class="col">
	        <input type="text" class="form-control" placeholder="?????? ??????" 
	        	 data-bs-toggle="tooltip"  title="?????? ??????" name="title">
	      </div>
	      <div class="col">
	        <select name="allDay" class="form-control"   data-bs-toggle="tooltip"  title="????????????">
	        	<option value="false">??????</option>
	        	<option value="true">??????</option>
	        </select>
	      </div>      	      
	     </div>
	     <div class="row">
	      <div class="col">
	        <input type="text" class="form-control"  data-bs-toggle="tooltip"  title="?????????" name="start">
	      </div>
	      <div class="col">
	        <input type="text" class="form-control"  data-bs-toggle="tooltip"  title="?????????" name="end">
	      </div>
	     </div>
	     <div class="row">
	      <div class="col"> 
	        <input type="color" class="form-control"  data-bs-toggle="tooltip"  title="????????????" 
	        	value="#0099cc" name="backgroundColor">
	      </div>
	      <div class="col">
	        <input type="color" class="form-control"   data-bs-toggle="tooltip"  title="????????????" 
	        	value="#ccffff" name="textColor">
	      </div>
	     </div>	   
	     <div class="row">
	      <div class="col">
	        <textarea name="content" rows="7"  class="form-control" 
	        	 data-bs-toggle="tooltip"  placeholder="?????? ??????"  title="??????" ></textarea>
	      </div>
	     </div>	 	     
	         
	    </form> 
      </div>
      <div class="modal-footer"> 
        <button type="button" id="regBtn" class="btn btn-primary">????????????</button>
        <button type="button" id="uptBtn" class="btn btn-info">????????????</button>
        <button type="button" id="delBtn" class="btn btn-danger">????????????</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
      <script type="text/javascript">
      	$("#regBtn").click(function(){
      		if(confirm("?????????????????????????")){
      			$("#frm01").attr("action","${path}/calInsert.do");
      			$("#frm01").submit();
      		}
      	});
      	$("#uptBtn").click(function(){ // calUpdate.do  http://localhost:7080/PMS/calUpdate.do
      		if(confirm("?????????????????????????")){
      			$("#frm01 [name=pno]").val(1)
      			$("#frm01 [name=sno]").val(1)
      			$("#frm01").attr("action","${path}/calUpdate.do");
      			$("#frm01").submit();
      		}
      	});
      	$("#delBtn").click(function(){
      		if(confirm("?????????????????????????")){
      			$("#frm01").attr("action","${path}/calDelete.do");
      			$("#frm01").submit();
      		}
      	});

      </script>
    </div>
  </div>
</div>

  <!-- Vendor JS Files -->
  <script src="NiceAdmin/assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="NiceAdmin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="NiceAdmin/assets/vendor/chart.js/chart.min.js"></script>
  <script src="NiceAdmin/assets/vendor/echarts/echarts.min.js"></script>
  <script src="NiceAdmin/assets/vendor/quill/quill.min.js"></script>
  <script src="NiceAdmin/assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="NiceAdmin/assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="NiceAdmin/assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="NiceAdmin/assets/js/main.js"></script>
	<script type="text/javascript">

	</script>
	</main>
</body>
</html>