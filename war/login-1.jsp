<%
String errorMsg = request.getParameter("errorMsg");

// if this page is not forwarded, errorMsg would be null, we set it to an empty
// String to prevent displaying null
if (errorMsg == null) {
  errorMsg = "";
}
%>

<!DOCTYPE html>
<html lang="en">
  
      <form name="login_form" class="form-signin" method="post" action="authenticate.jsp">
        <h2 class="form-signin-heading">Please sign in</h2>
        <input type="text" name="username" class="form-control" placeholder="Email address" autofocus>
        <input type="password" name="password" class="form-control" placeholder="Password">
        <br/>
        <label class="checkbox">
            <input type="checkbox" value="remember-me"> Remember me
        </label>
        <br/>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Log in</button>
        <%=errorMsg%>
        
      </form>

 
  </body>
</html>
