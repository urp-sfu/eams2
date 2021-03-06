<#include "/templates/head.ftl"/> 
<body>
	<table id="taskBar"></table>
    <@table.table width="100%" sortable="true" id="listTable" headIndex="1">
  	<form name="taskListForm" id="taskListForm" action="" method="post" onsubmit="return false;" >
	    <input type="hidden" name="taskIds" value="${taskIds!}">
	    <tr bgcolor="#ffffff" onKeyDown="javascript:enterQuery(event)">
	      <td align="center" width="3%">
	        <img src="${static_base}/images/action/search.png"  align="top" onClick="query()" alt="<@bean.message key="info.filterInResult"/>"/>
	      </td>
	      <td><input style="width:100%" type="text" name="attendStatic.student.code" value="${RequestParameters['attendStatic.student.code']?if_exists}"/></td>
	      <td><input style="width:100%" type="text" name="attendStatic.student.name" value="${RequestParameters['attendStatic.student.name']?if_exists}"/></td>
	      <td ><input style="width:100%" type="text" name="adminClass.name" value="${RequestParameters['adminClass.name']?if_exists}"/></td>
	      <td ><input style="width:100%" type="text" name="attendStatic.student.firstMajor.name" value="${RequestParameters['attendStatic.student.firstMajor.name']?if_exists}"/></td>
	      <td ><input style="width:100%" type="text" name="attendStatic.task.seqNo" value="${RequestParameters['attendStatic.task.seqNo']?if_exists}"/></td>
	      <td ><input style="width:100%" type="text" name="attendStatic.course.name" value="${RequestParameters['attendStatic.course.name']?if_exists}"/></td>      
	      <td><input style="width:100%" type="text" name="attendStatic.department.name" value="${RequestParameters['attendStatic.department.name']?if_exists}"/></td>
	      <td><input style="width:100%" type="text" name="teacher.name" value="${RequestParameters['teacher.name']?if_exists}"/></td>
	      <td><input style="width:100%" type="text" name="attenddate" value="${RequestParameters['attenddate']?if_exists}"/></td>
	      <td><input style="width:100%" type="text" name="attendStatic.attendtime" value="${RequestParameters['attendStatic.attendtime']?if_exists}"/></td>
	      <td>
	      	<select name="attendStatic.attendtype" value="${RequestParameters['attendStatic.attendtype']?if_exists}" style="width:100%">
      			<option value="" >全部</option>
     			<option<#if RequestParameters['attendStatic.attendtype']?? && RequestParameters['attendStatic.attendtype']='1'> selected</#if> value="1">出勤</option>
		   		<option<#if RequestParameters['attendStatic.attendtype']?? && RequestParameters['attendStatic.attendtype']='2'> selected</#if> value="2">缺勤</option>
		   		<option<#if RequestParameters['attendStatic.attendtype']?? && RequestParameters['attendStatic.attendtype']='3'> selected</#if> value="3">迟到</option>
		   		<option<#if RequestParameters['attendStatic.attendtype']?? && RequestParameters['attendStatic.attendtype']='4'> selected</#if> value="4">早退</option>
		   		<option<#if RequestParameters['attendStatic.attendtype']?? && RequestParameters['attendStatic.attendtype']='5'> selected</#if> value="5">请假</option>
	     	</select>
	      </td>
	    </tr>
  	</form>
  	<@table.thead>
  	  <@table.selectAllTd id="attendStaticId" />
      <@table.sortTd id="attendStatic.student.code" text="学生学号"/>
      <@table.sortTd id="attendStatic.student.name" text="学生姓名"/>
      <@table.sortTd id="" text="班级名称"/>
      <@table.sortTd id="attendStatic.student.firstMajor.name" text="专业名称"/>
      <@table.sortTd id="attendStatic.task.seqNo" text="课程序号"/>
      <@table.sortTd id="attendStatic.course.name" text="课程名称"/>
      <@table.sortTd id="attendStatic.department.name" text="上课院系"/>
      <@table.sortTd id="attendStatic.task.arrangeInfo.teachers[0].name" text="上课教师"/>
      <@table.sortTd id="attendStatic.attenddate" text="考勤日期"/>
      <@table.sortTd id="attendStatic.attendtime" text="考勤时间"/>
      <@table.sortTd id="attendStatic.attendtype" text="考勤类型"/>
    </@>    
    <@table.tbody datas=attendStatics;attendStatic>
      <@table.selectTd id="attendStaticId" value=attendStatic.id/>
      <td>${(attendStatic.student.code)!}</td>
      <td>${(attendStatic.student.name)!}</td>
      <td>
      <#assign adminClasses = attendStatic.student.adminClasses/>
      <#list adminClasses as adminClass>
      	${(adminClass.name)!}
      </#list>
      </td>
      <td>${(attendStatic.student.firstMajor.name)!}</td>
      <td>${(attendStatic.task.seqNo)!}</td>
      <td>${(attendStatic.course.name)!}</td>
      <td>${(attendStatic.department.name)!}</td>
      <td>
      <#assign teachers = attendStatic.task.arrangeInfo.teachers/>
      <#list teachers as teacher>
      	${(teacher.name)!}
      </#list>
      </td>
      <td>${(attendStatic.attenddate?string('yyyy-MM-dd'))!}</td>
      <td>${(attendStatic.attendtime)!}</td>
      <td>
      <#if attendStatic.attendtype=='1'>
      	出勤
      <#elseif attendStatic.attendtype=='2'>
      	缺勤
      <#elseif attendStatic.attendtype=='3'>
       	 迟到
      <#elseif attendStatic.attendtype=='4'>
      	早退
      <#elseif attendStatic.attendtype=='5'>
      	请假
      </#if>
      </td>
    </@>
    </@>
  	<script language="javascript">
  	function submit(form){
  	form.submit();
  	}
	var bar = new ToolBar('taskBar', '学生考勤明细列表', null, true, false);
	bar.setMessage('<@getMessage/>');
	var menu = bar.addMenu('修改考勤状态', null);
	menu.addItem('出勤', 'editAttendtype(1)');
	menu.addItem('缺勤', 'editAttendtype(2)');     
	menu.addItem('迟到', 'editAttendtype(3)');
	menu.addItem('请假', 'editAttendtype(5)');
	function editAttendtype(attendtype){
       var form = document.getElementById("taskListForm");
       ids = getSelectIds("attendStaticId");
       if(ids=="") {alert("请选择考勤信息");return;}
       form.action = "?method=editAttendtype&attendStaticIds=" + ids+"&attendtype="+attendtype+"&taskIds=${taskIds!}";
       form.submit();
    }
    function enterQuery(event) {if (portableEvent(event).keyCode == 13)query();}
    function query(pageNo,pageSize,orderBy){
        var form = document.getElementById("taskListForm");
        form.action="?method=showDetailList";
        form.target = "_self";
        //transferParams(parent.document.taskForm,form,null,false);
        goToPage(form,pageNo,pageSize,orderBy);
    }
 	</script>
</body>
<#include "/templates/foot.ftl"/>