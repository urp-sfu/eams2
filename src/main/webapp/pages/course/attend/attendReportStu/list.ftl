<#include "/templates/head.ftl"/>
<table id="taskBar" ></table>
<script>
     var bar = new ToolBar('taskBar', '我的考勤报表', null, true, false);
</script>
  	<@table.table width="100%" sortable="true" id="listTable" >
  		 		<thead>
  		 			<tr align="center" class="darkColumn" >
  		 			<td width="10%">月份</td>
  		 			<#list monthList as month>
  		 				<td colspan="2" >${month}月</td>
  		 			</#list>
  		 			<td colspan="3" >总计</td>
  		 			</tr>
  		 			<tr class="grayStyle" align="center">
  		 			<td>课程</td>
  		 			<#list monthList as month>
  		 				<td>缺勤</td>
  		 				<td>迟到</td>
  		 			</#list>
  		 			<td width="8%">缺勤率（%）</td>
  		 			<td width="8%">迟到率（%）</td>
  		 			<td width="8%">出勤率（%）</td>
  		 			</tr>
  		 		</thead>
  		 		<#if taskBeans??>
  		 		<@table.tbody datas=taskBeans;task>
  		 				<td>${task.task.course.name}</td>
  		 				<#list task.monthBeans as monthBean>
  		 					<td>${monthBean.absenceCount}</td>
  		 					<td>${monthBean.latCounet}</td>
  		 				</#list>
  		 				<td>${task.percentBean.absencePer}</td>
  		 				<td>${task.percentBean.latPer}</td>
  		 				<td>${task.percentBean.totalPer}</td>
  		 		</@>
  		 		</#if>
    </@>
    
<#include "/templates/foot.ftl"/> 
 