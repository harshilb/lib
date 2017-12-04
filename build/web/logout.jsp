
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Fed Uni</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
  <script src="bootstrap/jquery/jquery.js"></script>
  <script src="bootstrap/js/bootstrap.js"></script>
</head>
<% out.println("<body onload=\"setTimeout(function(){document.location = 'index.jsp'}, 3000)\">");%>
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
        <li><a href="admin.jsp"><span class="glyphicon glyphicon-dashboard"></span> Home <span class="sr-only">(current)</span></a></li>
        <li ><a href="adminItems.jsp"><span class="glyphicon glyphicon-th-large"></span> Items</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li class="active"><a href="logout.jsp">Logout</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<div class="container" style="margin-top: 80px;">
  <div class="row">
      <div class="col-sm-12">
          <ol class="breadcrumb">
            <li><a href="admin.jsp">Home</a></li>
            <li class="active">Logout</li>
          </ol>
      </div>
      <div class="col-sm-3"></div>
    <div class="col-sm-6" >
        <div class="alert alert-success" role="alert"> Logged out successfully.</div>
      <div class="col-sm-3"></div>
  </div>
</div>

</body>
</html>


