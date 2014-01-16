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
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="assets/jquery/ico/favicon.png">

    <title>GeoIntel</title>

    <!-- Bootstrap core CSS -->
    <link href="assets/bootstrap/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
  </head>
  
  <body style="padding-top: 50px; padding-bottom: 20px">
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">GeoIntel</a>
        </div>
       <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
          </ul>
        </div><!--/.nav-collapse -->
    </div>
 <div class="row">
  <div class="col-md-4"></div>
  <div class="col-md-4">
      <%if (!errorMsg.equals("")) { %>
      <div class="alert alert-danger"><center><%=errorMsg%></center></div>
      <%}%>
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
        
        
      </form>
  </div>
  <div class="col-md-4"></div>
</div>

    <script src=assets/jquery/js/jquery.jss"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
