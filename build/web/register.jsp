<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.IOException"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Register</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
  <script src="bootstrap/jquery/jquery.js"></script>
  <script src="bootstrap/js/bootstrap.js"></script>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
        <a class="navbar-brand" href="index.jsp">FedUni</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li ><a href="index.jsp"><span class="glyphicon glyphicon-dashboard"></span> Home <span class="sr-only">(current)</span></a></li>
        <li><a href="items.jsp"><span class="glyphicon glyphicon-th-large"></span> Items</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li class="active"><a href="register.jsp"><span class="glyphicon glyphicon-cog"></span> Register</a></li>
        <li><a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<div class="container" style="margin-top: 80px;">
  <div class="row">
      <div class="col-sm-12">
          <ol class="breadcrumb">
            <li><a href="home.jsp">Home</a></li>
            <li class="active">Registration</li>
          </ol>
      </div>
    <div class="col-sm-3">
    </div>
    <div class="col-sm-6">
        <h1 class="page-header text-center text-info" style="margin-top: 0px;">Registration</h1>
        <form method="post" action="register">
            <div class="form-group">
              <label for="email">Email address <span class="text-danger">*</span></label>
              <input type="email" class="form-control input-sm" id="email" name="email">
            </div>
             <div class="form-group">
              <label for="fname">Full Name <span class="text-danger">*</span></label>
              <input type="text" class="form-control input-sm" id="fname" name="fname">
            </div>
             <div class="form-group">
              <label for="phone">Phone Number <span class="text-danger">*</span></label>
              <input type="text" class="form-control input-sm" id="phone" name="phone">
            </div>
            <div class="form-group">
                <label for="pwd">Password <span class="text-danger">*</span></label>
              <input type="password" class="form-control input-sm" id="pwd" name="pwd">
            </div>
            <div class="form-group text-center">
                <button type="submit" class="btn btn-info btn-sm" name="register"><strong>Register <span class="glyphicon glyphicon-floppy-save"></span></strong></button>
            </div>
             <%
                String servletAttribute = (String)request.getAttribute("servletAttribute");                   
                if(servletAttribute==null){
                }else{
                   out.print(servletAttribute); 
                }
            %>  
          </form>
        
        
    </div>
    <div class="col-sm-3"> 
    </div>
  </div>
</div>

</body>
</html>
