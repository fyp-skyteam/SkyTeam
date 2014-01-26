<%
session.removeAttribute("authenticated.user");
%>
<jsp:forward page="login.jsp" />