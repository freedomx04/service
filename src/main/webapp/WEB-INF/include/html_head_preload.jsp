<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%
String contextPath = request.getContextPath();
for (String path : com.hongmeng.service.common.utils.PageUtils.cssFiles) {
	com.hongmeng.service.common.utils.ServletUtils.includeCss(out, request, contextPath + "/" + path);
}
for (String path : com.hongmeng.service.common.utils.PageUtils.jsFiles) {
	com.hongmeng.service.common.utils.ServletUtils.includeJs(out, request, contextPath + "/" + path);
}
%>
