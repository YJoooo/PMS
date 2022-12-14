<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>

<html>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Fine PMS</title>
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
<style>
	#chatArea{
		height:200px;overflow-y:scroll;text-align:left;
	}
	
		
	.thick{
	font-weight : 1000;
	}
	
	.tm{
	color:blue; 
	font-size:10px;
	}
	

</style>

  <!-- =======================================================
  * Template Name: NiceAdmin - v2.3.1
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
<script src="https://code.jquery.com/jquery-3.6.0.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#uptBtn").click(function(){
			$("#uptSchedule").submit()
		})
		
		var vm = new Vue({
			el:".vueel",
			data:{msg:"????????? ??????", 
				parlist:[]
			},
			methods:{
				getlist:function(){
					this.get()
				},
				get:function(){
					var vm = this
					$.ajax({
						url:"${path}/getPrjparticipant.do?pno=${param.pno}",
						dataType:"json",
						async:false,
						success:function(data){
							vm.parlist = data.parlist
							console.log("?????????")
							console.log(data.parlist)
						},
						error:function(err){
							console.log(err)
						}	
					})
				}
			}
		})
		
		$("#progress").change(function(){
			$("#show").text($(this).val()+"%")
	    });
		$("#progressReg").change(function(){
			$("#showReg").text($(this).val()+"%")
	    });
	});
	var ckClk = false;
	function chVal(sno){
		if(ckClk){
			$('#schptBtn').trigger('click')
			console.log(ckClk)	
		}
		$.ajax({
			url:"${path}/uptScheduleModal.do",
			data:"sno="+sno,
			dataType:"json",
			success:function(data){
				var data = data.schedule
				$("#sno").val(sno)
				$("#sname").val(data.sname)
				$("#status").val(data.status)
				$("#progress").val(data.progress)
				$("#startDate").val(data.startDate)
				$("#endDate").val(data.endDate)
				$("#budget").val(data.budget)
			}
		})
	}
	function regVal(){
		if($("[name=sname]").val()==""){
			alert("???????????? ??????????????????")
			$("[name=sname]").focus()
			return
		}
		$.ajax({
			url:"${path}/regScheduleModal.do",
			dataType:"json",
			success:function(data){
				var data = data.schedule
			}
		})
	}
	var auth = "${auth}"
	function delProc(){
		if(auth=="pm" || auth=="admin"){
			if(confirm("?????????????????????????")){
				var sno = $("#sno").val()
				location.href="${path}/delSchedule.do?sno="+sno
			}			
		}else{
			alert("????????? ????????????!")
		}
	}
	function delSchParti(sno, userno){
		if(confirm("?????????????????????????"))
		location.href="${path}/delSchParticipant.do?userno="+userno+"&sno="+sno
	}
	
	function schpartBtn(){
		ckClk = !ckClk
		var sno = $("#sno").val()
		console.log(ckClk)
		$.ajax({
			url:"${path}/showSchPartiInfo.do",
			data: "sno="+sno,
			dataType:"json",
			success:function(data){
				var list = data.schParInfo
				$("#inssno").val(sno)
				console.log(list)
				if(list.length==0){
					var addHTML="<tr><td colspan='5' align='center'>???????????? ????????????.</td></tr>"
				}else{
					var addHTML=""
						$(list).each(function(idx, sp){
							addHTML+="<tr onDblclick='delPart2("+sp.sno+",\""+sp.userno+"\")'><td>"+(idx+1)+"</td><td>"+sp.name+"</td>"+
								"<td>"+sp.dept+"</td><td>"+sp.position+"</td>"+
								"<td>"+sp.userno+"</td></tr>"
					});
				}
				console.log(addHTML)
				$("#schparti").html(addHTML)
			}
		}); 
	}
	
	function delPart2(sno, userno){
		if(confirm(userno+"??? ??????"+sno+"?????? ?????????????????????????"))
		// ?????? controller ??????
		location.href="${path}/delSchParticipant.do?sno="+sno+"&userno="+userno
	}
	
	function rstBtn(){
		if(ckClk){
			$('#schptBtn').trigger('click')
			console.log(ckClk)	
		}
	}
	
	var pno = "${pno}"
	var proc = "${proc}"
	var isReg = "${isReg}"
	if(isReg=="Y"){
		alert("?????? ??????!")
		location.href="${path}/goMain.do?pno="+pno		
	}
	if(proc=="upt"){
		alert("?????? ??????!")
		location.href="${path}/goMain.do?pno="+pno
	}
	if(proc=="del"){
		alert("?????? ??????!")
		location.href="${path}/goMain.do?pno="+pno
	}
</script>

  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {'packages':['gantt']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Task ID');
      data.addColumn('string', 'Task Name');
      data.addColumn('date', 'Start Date');
      data.addColumn('date', 'End Date');
      data.addColumn('number', 'Duration');
      data.addColumn('number', 'Percent Complete');
      data.addColumn('string', 'Dependencies');
      	var dlist = []
		var gdata = []
		$.ajax({
			url:"${path}/getGanttData.do?pno=${param.pno}",
			dataType:"json",
			async:false,
			success:function(dt){
				var dt = dt.ganttData
				$(dt).each(function(idx, d){
					var sDate = d.startDate.replace(" ","T");
					var eDate = d.endDate.replace(" ","T");
					gdata = [String(d.sno), d.sname, new Date(sDate), new Date(eDate), null, d.progress, null]
					dlist.push(gdata)
				})
			}
		})
      	data.addRows(dlist);
      var options = {
        height: (30*dlist.length)+50,
        width:"100%",
        gantt: {
          trackHeight: 30
        }
      };

      var chart = new google.visualization.Gantt(document.getElementById('chart_div'));

      chart.draw(data, options);
    }
  </script>
</head>

<body>

  <!-- ======= Sidebar ======= -->
<jsp:include page="navi.jsp"/>

  <main id="main" class="main">
    <section class="section dashboard">
      <div class="row">

        <!-- Left side columns -->
        <div class="col-lg-8">
          <div class="row">

            <!-- Customers Card -->
            <div class="col-lg-12">

              <div class="card info-card customers-card">

                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">${title}</h5> 
					<div class="progress">
	                	<div class="progress-bar progress-bar-striped bg-success" role="progressbar" style="width: ${prog}%" aria-valuenow="36" aria-valuemin="0" aria-valuemax="100">${prog}%</div>
	              	</div>
                </div>
              </div>

            </div><!-- End Customers Card -->

            <!-- ?????? ?????? -->

     <div class="col-12">
        <div class="card recent-sales overflow-auto">

          <div class="filter">
            <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
              <li class="dropdown-header text-start">
                <h6>Filter</h6>
              </li>

              <li><a class="dropdown-item" href="#">Today</a></li>
              <li><a class="dropdown-item" href="#">This Month</a></li>
              <li><a class="dropdown-item" href="#">This Year</a></li>
            </ul>
          </div>

          <div class="card-body">
            <h5 class="card-title">?????? ?????? <span>| ????????? ??????</span></h5>

            <table class="table table-borderless datatable">
            <thead>
              	<tr>
           	    <th scope="col">??????</th>
				<th scope="col">?????????</th>
				<th scope="col">??????</th>
				<th scope="col">?????????</th>
				<th scope="col">?????????</th>
				<th scope="col">?????????</th>
				<th scope="col">??????</th>
				<th scope="col">?????????</th>
                </tr>
			</thead>
			<tbody>
				<%int cnt=0; %>
				<c:forEach var="schedule" items="${slist}">
				
				<tr data-bs-toggle="modal" data-bs-target="#basicModal">
				<th scope="row" class=""><%=++cnt %></th>
				
				<td onclick="chVal(${schedule.sno })">${schedule.sname}</td>
				<td onclick="chVal(${schedule.sno })">
					<c:if test="${schedule.status eq '??????'}">
                    	<span class="badge bg-secondary">${schedule.status}</span>
                    </c:if>
                    <c:if test="${schedule.status eq '?????????'}">
                    	<span class="badge bg-primary">${schedule.status}</span>
                    </c:if>
                    <c:if test="${schedule.status eq '??????'}">
                    	<span class="badge bg-success">${schedule.status}</span>
                    </c:if>
                    <c:if test="${schedule.status eq '??????'}">
                    	<span class="badge bg-warning">${schedule.status}</span>
                    </c:if>
                    <c:if test="${schedule.status eq '??????'}">
                    	<span class="badge bg-danger">${schedule.status}</span>
                    </c:if>
				</td>
				<td onclick="chVal(${schedule.sno })">
				<%-- <c:set var="status" value="" />
				<c:choose>
                <c:when test="${schedule.progress eq 100}">
                	<c:set var="status" value="success" /></c:when>
               	<c:when test="${schedule.progress > 50 and schedule.progress < 100}">
	               	<c:set var="status" value="warning" /></c:when>
				<c:otherwise>
					<c:set var="status" value="danger" /></c:otherwise>
                </c:choose> --%>
					<div class="progress">
	              		<c:if test="${schedule.status eq '??????'}">
	              		<div class="progress-bar bg-secondary" role="progressbar" style="width: ${schedule.progress}%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">${schedule.progress}%</div>
              			</c:if>
              			<c:if test="${schedule.status eq '?????????'}">
                		<div class="progress-bar bg-primary" role="progressbar" style="width: ${schedule.progress}%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">${schedule.progress}%</div>
              			</c:if>
              			<c:if test="${schedule.status eq '??????'}">
                		<div class="progress-bar bg-success" role="progressbar" style="width: ${schedule.progress}%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">${schedule.progress}%</div>
              			</c:if>
              			<c:if test="${schedule.status eq '??????'}">
                		<div class="progress-bar bg-warning" role="progressbar" style="width: ${schedule.progress}%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">${schedule.progress}%</div>
              			</c:if>
              			<c:if test="${schedule.status eq '??????'}">
                		<div class="progress-bar bg-danger" role="progressbar" style="width: ${schedule.progress}%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">${schedule.progress}%</div>
              			</c:if>
	              	</div>
              	</td>
				<td onclick="chVal(${schedule.sno })"><fmt:formatDate value="${schedule.startDate}" pattern="yyyy-MM-dd"/></td>
				<td onclick="chVal(${schedule.sno })"><fmt:formatDate value="${schedule.endDate}" pattern="yyyy-MM-dd"/></td>
				<td onclick="chVal(${schedule.sno })">${schedule.budget}???</td>
				<td><img src="a00_com/images/comment.png" width="30" height="30" onclick="goComment(${schedule.sno})"/></td>
				</tr>
				</c:forEach>
			</tbody>
			</table>
			<div class="text-center">
			<c:if test="${auth eq 'admin' or auth eq 'pm'}">
	   			<button type="button" id="Btn01" class="btn btn-primary" onclick="chVal(${schedule.sno })"data-bs-toggle="modal" data-bs-target="#regModal">?????? ??????</button>
			</c:if>
			</div>
   		 </div>
   		 
	</div>
</div>
            <!-- ???????????? -->

<!-- ?????????(PM??????) -->
       <div class="modal fade" id="basicModal" tabindex="-1">
         <div class="modal-dialog">
           <div class="modal-content">
                  <!-- ?????? ?????? -->
				      <div class="modal-header">
				        <h5 class="modal-title">?????? ??????</h5>
				        <button type="button" id="closeBtn" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="rstBtn()"></button>
				      </div>
				      <!-- ?????? ?????? sname, status, progress, startDate, endDate, budget -->
			      <div class="modal-body">
			      <!-- ?????? ???????????? form ?????? ??????, input ????????? -->
			      	<c:if test="${auth eq 'admin' or auth eq 'pm'}">
			  		<form id="uptSchedule" class="row g-3 needs-validation" action="${path}/uptScheduleByPM.do" novalidate>
			  		</c:if>
			  		<c:if test="${auth eq 'um' or auth eq 'user'}">
			  		<form id="uptSchedule" class="row g-3 needs-validation" action="${path}/uptSchedule.do" novalidate>
			  		</c:if>
			  		<input type="hidden" id="sno" name="sno" value=""/>
			  		<c:if test="${auth eq 'admin' or auth eq 'pm'}">
			             <div class="row mb-3" style="padding-top:15px;">
			             
			               <label for="inputText" class="col-sm-2 col-form-label">?????????</label>
			               <div class="col-sm-10">
			               	<div class="input-group has-validation">
			                 <input type="text" id="sname" name="sname" class="form-control" placeholder="?????????" required>
			                 <div class="invalid-feedback">
			                    ?????? ?????? ???????????????.
			                 </div>
		                    </div>
			               </div>
			             </div>
			             <div class="row mb-3">
			               <label for="inputText" class="col-sm-2 col-form-label">??????</label>
			               <div class="col-sm-10">
			                 <select class="form-select" id="status" name="status">
			                      <option value="??????">??????</option>
			                      <option value="?????????">?????????</option>
			                      <option value="??????">??????</option>
			                      <option value="??????">??????</option>
			                      <option value="??????">??????</option>
			                 </select>
			               </div>
			             </div>
	             </c:if>
			             <div class="row mb-3">
			               <label for="inputText" class="col-sm-2 col-form-label">?????????</label>
			               <div class="col-sm-10">
			                 <input type="range" id="progress" name="progress" class="form-range" min="0" max="100" step="5" value="0"><p id="show" align="center"></p>
			               </div>
			             </div>
			       <c:if test="${auth eq 'admin' or auth eq 'pm'}">
						<div class="row mb-3">
			               <label for="inputText" class="col-sm-2 col-form-label">?????????</label>
			               <div class="col-sm-10">
			               <div class="input-group has-validation">
			                 <input type="date" id="startDate" name="startDate_s" class="form-control" required>
			                 <div class="invalid-feedback">
				                    ?????? ?????? ???????????????.
				             </div>
				            </div>
			               </div>
			             </div>
			             <div class="row mb-3">
			               <label for="inputText" class="col-sm-2 col-form-label">?????????</label>
			               <div class="col-sm-10">
			               	<div class="input-group has-validation">
			                 <input type="date" id="endDate" name="endDate_s" class="form-control" required>
			                 <div class="invalid-feedback">
				                    ?????? ?????? ???????????????.
				             </div>
			                </div>
			               </div>
			             </div>
			             <div class="row mb-3">
			               <label for="inputText" class="col-sm-2 col-form-label">??????</label>
			               <div class="col-sm-10">
			               	<div class="input-group has-validation">
			                 <input type="number" id="budget" name="budget" class="form-control" min="0" step="10000" required>
				               <div class="invalid-feedback">
				                    ?????? ?????? ???????????????.
				               </div>
			               	</div>
			               </div>
			             </div>
			            </c:if>
			             <div class="row mb-3">
			               <div class="col-sm-12">
			                 <div class="accordion accordion-flush" id="accordionSchParti">
				                <div class="accordion-item">
				                  <h2 class="accordion-header" id="flush-headingTwo">
				                    <button class="accordion-button collapsed card-title" type="button" id="schptBtn" onclick="schpartBtn()" data-bs-toggle="collapse" data-bs-target="#SchPartiInfo" aria-expanded="false" aria-controls="SchPartiInfo">
				                      ???????????????
				                    </button>
				                  </h2>
				                    <div id="SchPartiInfo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="accordionSchParti">
				                      <div class="accordion-body">
						               <table class="table table-striped">
						                <thead>
						                  <tr>
						                    <th scope="col">#</th>
						                    <th scope="col">??????</th>
						                    <th scope="col">??????</th>
						                    <th scope="col">??????</th>
						                    <th scope="col">????????????</th>
						                  </tr>
						                </thead>
						                <tbody id=schparti>
						                </tbody>
						              </table>
						              <c:if test="${auth eq 'admin' or auth eq 'pm'}">
						              	<div class="text-center">
						              	  <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addSchparti">????????? ??????</button>
						              	</div>
						              </c:if>
						              </div>
				                    </div>
				                    
				                  </div>
				                </div>
			               </div>
			             </div>
			       
			              <div class="row mb-3">
			               <div class="text-end">
			                
			             	<button type="submit" class="btn btn-primary">??????</button>
			             	<c:if test="${auth eq 'admin' or auth eq 'pm'}">
			             	<button type="button" onclick="delProc()" id="delBtn" class="btn btn-danger">??????</button>
			             	</c:if>
		             	   </div>
			              </div>
			              </div>
			              </form>
            </div>
			     <!-- ?????? ?????? -->      
				      <!-- <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">??????</button>
				      </div> -->
           </div>
         </div>

<!-- ?????? ????????? ?????? -->
<script type="text/javascript">
	var proc = "${proc}"
  	if(proc=="insParSch"){
  		alert("${param.userno} ?????? ??????!")
  		location.href="${path}/goMain.do?pno=${param.pno}"
  	}
	if(proc=="delParSch"){
		alert("${param.userno} ?????? ??????!")
		location.href="${path}/goMain.do?pno=${pno}"
	}
</script>        
		      <div class="modal fade" id="addSchparti" tabindex="-1">
			       <div class="modal-dialog modal-dialog-centered">
			         <div class="modal-content">
			           <div class="modal-header">
			             <h5 class="modal-title">?????? ????????? ??????</h5>
			             <button type="button" class="btn-close" data-bs-toggle="modal" data-bs-target="#basicModal"></button>
			           </div>
			           <br>
			           <div class="modal-body">
						 <form class="row g-3 needs-validation" action="${path}/insSchParticipant.do" novalidate>
						 	<input type="hidden" name="pno" value="${param.pno}">
						 	<input type="hidden" name="sno" id="inssno" value="">
			                <div class="col-sm-12">
			                  <div class="form-floating mb-3">
			                  	<table class="table table-striped datatable">
					                <thead>
					                  <tr>
					                    <th scope="col">   </th>
					                    <th scope="col">??????</th>
					                    <th scope="col">??????</th>
					                    <th scope="col">??????</th>
					                    <th scope="col">UserNo</th>
					                  </tr>
					                </thead>
					                <tbody>
					                <c:forEach var="sp" items="${schPlist}">
					                  <tr>
					                    <td><input type="radio" value="${sp.userno}" name="userno"></td>
					                    <td>${sp.name}</td>
					                    <td>${sp.position}</td>
					                    <td>${sp.dept}</td>
					                    <td>${sp.userno}</td>
					                  </tr>
					                </c:forEach>
					                </tbody>
					            </table>
			                  </div>
			                </div>
			                <div class="text-center">
			                  <button type="submit" class="btn btn-primary">??????</button>
			                </div>
			              </form>
			           	</div>
			          </div>
			       	</div>
			       
		         </div>
		         
<!-- ?????????(????????????) -->
       <div class="modal fade" id="regModal" tabindex="-1">
         <div class="modal-dialog">
           <div class="modal-content">
                  <!-- ?????? ?????? -->
				      <div class="modal-header">
				        <h5 class="modal-title">?????? ??????</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <!-- ?????? ?????? sname, status, progress, startDate, endDate, budget -->
			      <div class="modal-body">
			      <!-- ?????? ???????????? form ?????? ??????, input ????????? -->
			  		<form id="regSchedule" class="row g-3 needs-validation" action="${path}/regSchedule.do" novalidate>
			  			<input type="hidden" name="pno" value="${param.pno}">
			  			<input type="hidden" name="state" value="????????????"/>
			  			<input type="hidden" name="writer" value="??????"/>

			             <div class="row mb-3" style="padding-top:15px;">
			               <label for="inputText" class="col-sm-2 col-form-label">?????????</label>
			               <div class="col-sm-10">
			               	<div class="input-group has-validation">
			                 <input type="text" id="snameReg" name="sname" class="form-control" placeholder="?????????" required>
			                 <div class="invalid-feedback">
			                    ?????? ?????? ???????????????.
			                 </div>
		                    </div>
			               </div>
			             </div>
			             <div class="row mb-3">
			               <label for="inputText" class="col-sm-2 col-form-label">??????</label>
			               <div class="col-sm-10">
			                 <select class="form-select" id="statusReg" name="status">
			                      <option value="??????" selected>??????</option>
			                      <option value="?????????">?????????</option>
			                      <option value="??????">??????</option>
			                      <option value="??????">??????</option>
			                      <option value="??????">??????</option>
			                 </select>
			               </div>
			             </div>
			             <div class="row mb-3">
			               <label for="inputText" class="col-sm-2 col-form-label">?????????</label>
			               <div class="col-sm-10">
			                 <input type="range" id="progressReg" name="progress" class="form-range" min="0" max="100" step="5" value="0"><p id="showReg" align="center"></p>
			               </div>
			             </div>
						<div class="row mb-3">
			               <label for="inputText" class="col-sm-2 col-form-label">?????????</label>
			               <div class="col-sm-10">
			               <div class="input-group has-validation">
			                 <input type="date" id="startDateReg" name="startDate_s" class="form-control" required>
			                 <div class="invalid-feedback">
				                    ?????? ?????? ???????????????.
				             </div>
				            </div>
			               </div>
			             </div>
			             <div class="row mb-3">
			               <label for="inputText" class="col-sm-2 col-form-label">?????????</label>
			               <div class="col-sm-10">
			               	<div class="input-group has-validation">
			                 <input type="date" id="endDateReg" name="endDate_s" class="form-control" required>
			                 <div class="invalid-feedback">
				                    ?????? ?????? ???????????????.
				             </div>
			                </div>
			               </div>
			             </div>
			             <div class="row mb-3">
			               <label for="inputText" class="col-sm-2 col-form-label">??????</label>
			               <div class="col-sm-10">
			               	<div class="input-group has-validation">
			                 <input type="number" id="budgetReg" name="budget" class="form-control" min="0" step="10000" value="0" required>
			               	 <div class="invalid-feedback">
				                    ?????? ?????? ???????????????.
				             </div>
				            </div>
			               </div>
			             </div>
			             
			             <div class="row">
			             	<button type="submit" class="btn btn-primary">??????</button>
			             </div>
			             </form>
			           </div>
			           
			     <!-- ?????? ?????? -->      
				      <!-- <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">??????</button>
				      </div>	 -->
           </div>
         </div>
       </div>

            <!-- Gantt Chart -->
            <div class="col-12">
              <div class="card">
                <div class="card-body">
                  <h5 class="card-title">???????????? <span>?????????</span></h5>
                  <c:if test="${not empty slist}">
					<div id="chart_div"></div>
				  </c:if>
				  <c:if test="${empty slist}">
				  	<h3 align="center">????????? ??????????????????.</h3>
				  </c:if>
          		</div>
          	  </div>
          	</div>
          </div>
        </div><!-- End Left side columns -->

        <!-- Right side columns -->
        <div class="col-lg-4">

          <!-- Recent Activity -->
          <div class="card">
            <div class="filter">
              <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
              <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                <li class="dropdown-header text-start">
                  <h6>????????????</h6>
                </li>

                <li><a class="dropdown-item" href="${path}/goTimeline.do?pno=${param.pno}&title=${param.title}">???????????? ?????????</a></li>
              </ul>
            </div>

            <div class="card-body">
              <h5 class="card-title">???????????? <span>| ${title}<br></span>
              <span style="color:#8c8c8c; font-size:12px;">?????? ?????? 15????????? ????????? ??????</span></h5>

              <div class="activity">       
                                 
                <c:forEach var="t" items="${tmlist}" begin="0" end="14" varStatus="status">
                
                <c:choose>
                <c:when test="${t.state == '????????????'}">
                 <div class="activity-item d-flex">
                  <div class="activite-label">${t.calTime }</div>
                  <i class='bi bi-circle-fill activity-badge text-primary align-self-start'></i>            
                  <div class="activity-content">#${t.sname } <span class="thick">??????</span>??? ?????????????????????.</div>
                </div><!-- End activity item-->
                </c:when>
              <%-- 
               <c:when test="${t.state == '????????????'}">
                 <div class="activity-item d-flex">
                  <div class="activite-label">${t.calTime}</div>
                  <i class='bi bi-circle-fill activity-badge text-danger align-self-start'></i>
                  <div class="activity-content">${t.sname } <span class="thick">??????</span>??? ?????????????????????.</div>
                  </div><!-- End activity item-->               
                </c:when>
                
                 <c:when test="${t.state == '????????????'}">
                 <div class="activity-item d-flex">
                  <div class="activite-label">${t.calTime}</div>
                   <i class='bi bi-circle-fill activity-badge text-success align-self-start'></i>
                  <div class="activity-content">${t.sname } <span class="thick">??????</span>??? ?????????????????????.</div>
                  </div><!-- End activity item-->               
                </c:when>
             --%>      
                <c:when test="${t.state == '????????????'}">
                 <div class="activity-item d-flex">                 
                  <div class="activite-label">${t.calTime }</div>
                  <i class='bi bi-circle-fill activity-badge text-warning align-self-start'></i>
                  <div class="activity-content">${t.writer}?????? #${t.sname } ????????? <span class="thick">?????????</span>??? ?????????????????????.</div>
                </div><!-- End activity item-->               
                </c:when>

                <c:when test="${t.state == '????????????'}">
                 <div class="activity-item d-flex">
                  <div class="activite-label">${t.calTime}</div>
                  <i class='bi bi-circle-fill activity-badge text-danger align-self-start'></i>
                  <div class="activity-content">#${t.sname } ????????? <span class="thick">?????????</span>??? ?????????????????????.</div>
                  </div><!-- End activity item-->               
                </c:when>
                
                
                 <c:otherwise>                
                <div class="activity-item d-flex">
                  <div class="activite-label">${t.calTime}</div>
                   <i class='bi bi-circle-fill activity-badge text-success align-self-start'></i>
                  <div class="activity-content">#${t.sname } ????????? <span class="thick">?????????</span>??? ?????????????????????.</div>
                </div><!-- End activity item-->
                
                


            
                </c:otherwise>  
                </c:choose>
                </c:forEach>

       <%-- Timeline Circle Color
       => Red   
       <i class='bi bi-circle-fill activity-badge text-danger align-self-start'></i>
       => Green   
       <i class='bi bi-circle-fill activity-badge text-success align-self-start'></i>
       => Yellow
       <i class='bi bi-circle-fill activity-badge text-danger align-self-start'></i>
       => Blue
       <i class='bi bi-circle-fill activity-badge text-primary align-self-start'></i>
       => Sky Blue
       <i class='bi bi-circle-fill activity-badge text-info align-self-start'></i>
       => DarkGreen
       <i class='bi bi-circle-fill activity-badge text-muted align-self-start'></i>
       --%>

              </div>

            </div>

          </div><!-- End Recent Activity -->
          
           <!-- ????????? chart -->
           <div class="card">
                 <!-- Radial Bar Chart -->
              <div class="StatusCntChart card-body" id="radialBarChart">
              <h5 class="card-title">???????????? ????????????<span><br></span>
              <span style="color:#8c8c8c; font-size:12px;">???? ????????? ???????????????!</span></h5>
              <script> 
              var ratio = []
              var schstatus = []

				$.ajax({
					url:"${path}/getSchStatus.do?pno=${param.pno}",
					dataType:"json",
					async:false,
					success:function(data){						
						var data = data.stRatio
						$(data).each(function(idx, d){
							ratio.push(Number(d.stRatio))
							schstatus.push(d.status)
						})
					}
				})
                document.addEventListener("DOMContentLoaded", () => {
                  new ApexCharts(document.querySelector(".StatusCntChart"), {
                    series: ratio,
                    chart: {
                      height: 250,
                      type: 'radialBar',
                      toolbar: {
                        show: true
                      }
                    },
                    plotOptions: {
                      radialBar: {
                        dataLabels: {
                          name: {
                            fontSize: '22px',
                          },
                          value: {
                            fontSize: '16px',
                          },
                          total: {
                            show: true,
                            label: 'STATUS',
                            formatter: function(w) {
                              // By default this function returns the average of all series. The below is just an example to show the use of custom formatter function
                              return 
                            }
                          }
                        }
                      }
                    },
                    labels: schstatus,
                  }).render();
                });
              </script>
              <!-- End Radial Bar Chart -->  
					
                </div>

            </div><!-- ????????? chart End -->
          

              <!-- ????????? Accordion without outline borders -->
          <div class="card">
            <div class="card-body">
              <div class="vueel">
              <div class="accordion accordion-flush" id="accordionFlushExample">
                <div class="accordion-item">
                  <h2 class="accordion-header" id="flush-headingOne">
                    <button class="accordion-button collapsed card-title" type="button" @click="getlist" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                      ????????? <span>| Today</span>
                    </button>
                  </h2>
                  <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
	               <div class="accordion-body">
		               <table class="table table-striped">
		                <thead>
		                  <tr>
		                    <th scope="col">#</th>
		                    <th scope="col">Name</th>
		                    <th scope="col">Dept</th>
		                    <th scope="col">Position</th>
		                    <th scope="col">Email</th>
		                  </tr>
		                </thead>
		                <tbody>
		                  <tr v-for="(p, idx) in parlist">
		                    <th scope="row">{{idx+1}}</th>
		                    <td>{{p.name}}</td>
		                    <td>{{p.dept}}</td>
		                    <td>{{p.position}}</td>
		                    <td>{{p.email}}</td>
		                  </tr>
		                </tbody>
		              </table>
		              <c:if test="${auth eq 'admin'}">
		              <div class="col-lg-12" align="center">
			      	  	<button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addparti">????????? ??????</button>
			        </div>
			        </c:if>
			        <c:if test="${auth eq 'pm'}">
		              <div class="col-lg-12" align="center">
			      	  	<button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addparti">????????? ??????</button>
			        </div>
			        </c:if>
			        </div>
                    </div>
                    
                  </div>
                </div>
               </div>
			</div>
<script type="text/javascript">
	var proc = "${proc}"
  	if(proc=="insParPrj"){
  		alert("${param.userno} ?????? ??????!")
  		location.href="${path}/goMain.do?pno=${param.pno}"
  	}
</script>        
		      <div class="modal fade" id="addparti" tabindex="-1">
			       <div class="modal-dialog modal-dialog-centered">
			         <div class="modal-content">
			           <div class="modal-header">
			             <h5 class="modal-title">???????????? ????????? ??????</h5>
			             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			           </div>
			           <br>
			           <div class="modal-body">
						 <form class="row g-3 needs-validation" action="${path}/insParPrj.do?pno=${param.pno}" novalidate>
						 	<input type="hidden" name="pno" value="${param.pno}">
			                <div class="col-sm-12">
			                  <div class="form-floating mb-3">
			                  	<table class="table table-striped datatable">
					                <thead>
					                  <tr>
					                    <th scope="col">   </th>
					                    <th scope="col">??????</th>
					                    <th scope="col">??????</th>
					                    <th scope="col">??????</th>
					                    <th scope="col">UserNo</th>
					                  </tr>
					                </thead>
					                <tbody>
					                <c:forEach var="a" items="${alist}">
					                  <tr>
					                    <td><input type="radio" value="${a.userno}" name="userno"></td>
					                    <td>${a.name}</td>
					                    <td>${a.position}</td>
					                    <td>${a.dept}</td>
					                    <td>${a.userno}</td>
					                  </tr>
					                </c:forEach>
					                </tbody>
					            </table>
			                  </div>
			                </div>
			                <div class="text-center">
			                  <button type="submit" class="btn btn-primary">??????</button>
			                </div>
			              </form>
			           	</div>
			          </div>
			       	</div>
			       
		         </div>
              
             </div><!--????????? End Accordion without outline borders -->
        
          <!-- ?????? -->
          <div class="card">
            <div class="card-body">
             <h5 class="card-title">?????? <span>| Today</span></h5>
                           <!-- Floating Labels Form -->
              <form class="row g-3">
                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" id="id" value="${name} (${dept})" readonly>
                    <label for="id">????????????(?????????)</label>
                  </div>
                </div>
                <div class="col-12">
                  <div class="form-floating">
                  <div>?????? ??????</div>
                   <div class="form-control" id="chatArea">
                    <div id="chatMessageArea"></div>
                   </div> 
                  </div>
                </div>
                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" id="msg">
                    <label for="msg">????????? ??????</label>
                  </div>
                </div>
                <div class="text-center">
                  <button type="button" id="enterBtn" class="btn btn-primary">?????? ??????</button>
                  <button type="button" id="exitBtn" class="btn btn-danger">?????? ?????????</button>
                  <button type="button" id="sndBtn" class="btn btn-success">????????? ??????</button>
                </div>
              </form><!-- End floating Labels Form -->
             
          </div>
        </div><!-- End ?????? -->

      </div>
      <c:if test="${auth eq 'pm'}">
      <div class="col-lg-12" align="center">
      <button type="button" class="btn btn-outline-dark btn-sm" data-bs-toggle="modal" data-bs-target="#projectoption"><i class="bx bx-wrench"></i> ???????????? ??????/??????</button>
      </div>
      </c:if>
      <c:if test="${auth eq 'admin'}">
      <div class="col-lg-12" align="center">
      <button type="button" class="btn btn-outline-dark btn-sm" data-bs-toggle="modal" data-bs-target="#projectoption"><i class="bx bx-wrench"></i> ???????????? ??????/??????</button>
      </div>
      </c:if>
      
      <div class="modal fade" id="projectoption" tabindex="-1">
	       <div class="modal-dialog modal-dialog-centered">
	         <div class="modal-content">
	           <div class="modal-header">
	             <h5 class="modal-title">???????????? ??????/??????</h5>
	             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	           </div>
	           <br>
	           <div class="modal-body">
				 <form class="row g-3 needs-validation" action="${path}/updateProject.do" novalidate>
				 	<input type="hidden" name="pno" value="${param.pno}">
				 	<%-- <div class="row mb-3">
	                  <label class="col-sm-2 col-form-label">PM??????</label>
	                  <div class="col-sm-10">
	                    <input type="text" class="form-control" value="${pmno}" readonly>
	                  </div>
	               	</div> --%>
	                <div class="col-md-8">
	                  <div class="form-floating">
	                    <input type="text" class="form-control" id="floatingName" name="title" placeholder="???????????????" value="${title}" required>
	                    <label for="floatingName">???????????????</label>
		                  <div class="invalid-feedback">
		                    ?????? ???????????? ?????????.
		                  </div>
	                  </div>
	                </div>
	                <div class="col-sm-4">
	                  <div class="form-floating mb-3">
	                    <select name="dept" class="form-select" id="floatingDept" aria-label="Dept">
	                      <option value="?????????">?????????</option>
	                      <option value="?????????">?????????</option>
	                      <option value="?????????">?????????</option>
	                      <option value="????????????">????????????</option>
	                      <option value="???????????????">???????????????</option>
	                      <option value="????????????">????????????</option>
	                      <option value="?????????">?????????</option>
	                      <option value="???????????????">???????????????</option>
	                    </select>
	                    <label for="floatingDept">??????</label>
	                  </div>
	                </div>
	                <div class="text-center">
	                  <button type="submit" class="btn btn-warning">???????????? ??????</button>
	                  <button type="button" class="btn btn-danger" onclick="deletePrj()">???????????? ??????</button>
	                </div>
	              </form>
	              <script type="text/javascript">
	              	function deletePrj(){
	          			if(confirm("?????????????????????????\n????????? ????????? ??? ????????????!!!")){
	          				location.href="${path}/deleteProject.do?pno=${param.pno}"
	          			}
		          	}
		          	var proc = "${proc}"
		          	if(proc=="uptprj"){
		          		alert("????????????!")
		          		location.href="${path}/goMain.do?pno=${param.pno}"
		          	}
	              </script>
	           	</div>
	          </div>
	       	</div>
	       
      </div>
      </div>
    </section>

  </main><!-- End #main -->

<script type="text/javascript">
function goSchedule(){
	location.href="${path}/goSchedule.do"
}


function goComment(sno){
	location.href="${path}/commentList.do?sno="+sno+"&pno="+"${param.pno}";
	
}
var wsocket;
$(document).ready(function(){
	$("#enterBtn").click(function(){
		if(confirm("????????? ???????????????.")){
			conn();
		}
	});
	$("#exitBtn").click(function(){
		if(confirm("????????? ?????????????????????????")){
			wsocket.send("msg:"+$("#id").val()+":?????? ?????? ????????????.")
			wsocket.close();
		}
	});
});
function conn(){
	wsocket = new WebSocket("ws:220.73.54.156:8080/${path}/chat-ws.do")
	wsocket.onopen=function(evt){ 
		wsocket.send("msg:"+$("#id").val()+":?????? ??????????????????.")
	}
	// ???????????? ?????? ???, ???????????? ?????????
	wsocket.onmessage=function(evt){
		var msg = evt.data
		console.log(msg)
		if(msg.substring(0,4)=="msg:"){
			var revMsg = msg.substring(4)
			$("#chatMessageArea").append(revMsg+"<br>")	
			$("#chatArea").scrollTop(ma+=20);
			console.log("chatArea??????:"+ma)
		}
	}
	var ma = parseInt($("#chatMessageArea").height());	
	// ????????? ?????? ????????? ???
	wsocket.onclose=function(){
		alert($("#id").val()+"?????? ???????????????.")
		$("#chatMessageArea").empty();
	}		
}
$("#msg").keyup(function(){
	if(event.keyCode==13){
		wsocket.send("msg:"+$("#id").val()+":"+$(this).val())
		$(this).val("").focus()
	}
});
// ?????? ????????? ???????????? ????????? ??????
$("#sndBtn").click(function(){
	wsocket.send("msg:"+$("#id").val()+":"+$("#msg").val())
	$("#msg").val("").focus()				
});

</script>

  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">
    <div class="copyright">
      &copy; Copyright <strong><span>PMS</span></strong>. All Rights Reserved
    </div>
    <div class="credits">
      <!-- All the links in the footer should remain intact. -->
      <!-- You can delete the links only if you purchased the pro version. -->
      <!-- Licensing information: https://bootstrapmade.com/license/ -->
      <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
      Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

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
  


</body>

</html>