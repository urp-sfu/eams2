<#include "/templates/head.ftl"/>
 <BODY LEFTMARGIN="0" TOPMARGIN="0">
  <form name="commonForm" action="${actionName}" method="post" onsubmit="return false;">
    <input type="hidden" name="method" value="${methodValue}"/>
    <input type="hidden" name="teachTaskId" value="${RequestParameters["teachTaskId"]}"/>
    <input type="hidden" name="stdId" value="${stdId?if_exists}"/>
    <input type="hidden" name="flag" value="search"/>
  </form>
  <table  width="100%" cellpadding="0" cellspacing="0">
    <tr>
      <td  class="infoTitle" style="height:22px;" >
       <BR>
      </td>
    </tr>
    <tr>
      <td align="center" colspan="4" class="contentTableTitleTextStyle" bgcolor="#ffffff">
          <B><@bean.message key="info.action.success"/></B>
      </td>
   </tr>
   <tr>
     <td id="errorTD"><font color="green">
           <@html.errors />
      <#if RequestParameters.messages?exists>
      <#list RequestParameters.messages?split(",") as message>
         <#if (message?length>2)><@bean.message key="${message}"/></#if>&nbsp;
      </#list>
      </#if>
      </font>
      <BR><BR>
      </td>
   </tr>
   <tr>
         <td style="font-size:12px">该页面将在一秒钟后自动跳转，如果没有自动跳转，请点击
         <a href="javascript: document.commonForm.submit();" >这里</a>
         </td>
   </tr>
  </table>
  <script>  
	setTimeout('document.commonForm.submit()',1000); 
  </script>
 </body>
<#include "/templates/foot.ftl"/>