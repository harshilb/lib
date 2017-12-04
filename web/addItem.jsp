
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.IOException"%>
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
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid" >
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
         <a class="navbar-brand" href="admin.jsp">FedUni</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li ><a href="admin.jsp"><span class="glyphicon glyphicon-dashboard"></span> Home <span class="sr-only">(current)</span></a></li>
        <li class="dropdown active">
            <a class="dropdown-toggle" data-toggle="dropdown" href="adminItems.jsp"><span class="glyphicon glyphicon-th-large"></span> Items
            <span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="addItem.jsp"><span class="glyphicon glyphicon-plus"></span> Add item</a></li>
              <li><a href="viewComments.jsp"><span class=" glyphicon glyphicon-comment"></span> View Comments</a></li>
              <li><a href="adminItems.jsp"><span class=" glyphicon glyphicon-search"></span> View Items</a></li>
            </ul>
        </li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <p class="navbar-text">Signed in as Admin</p>
        <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<div class="container" style="margin-top: 80px;">
  <div class="row">
      <div class="col-sm-12">
          <ol class="breadcrumb">
            <li><a href="admin.jsp">Home</a></li>
            <li class="active">Item Registration</li>
          </ol>
      </div>
    <div class="col-sm-3">
    </div>
    <div class="col-sm-6">
        <%
            String servletAttribute = (String)request.getAttribute("servletAttribute");
            if(servletAttribute==null){
                
            }else{
               out.print(servletAttribute); 
            }
            
        %>  
        <h1 class="page-header text-center text-info" style="margin-top: 0px;">Add Item</h1>
        <form method="post" action="saveItem">
            <div class="form-group">
              <label for="title">Title  <span class="text-danger">*</span></label>
              <input type="text" class="form-control input-sm" id="title" name="title">
            </div>
             <div class="form-group">
              <label for="author">Author  <span class="text-danger">*</span></label>
              <input type="text" class="form-control input-sm" id="author" name="author">
            </div>
            <div class="form-group">
              <label for="publisher">Publisher  <span class="text-danger">*</span></label>
              <input type="text" class="form-control input-sm" id="publisher" name="publisher">
            </div>
            <div class="form-group">
              <label for="publishdate">Publish Date  <span class="text-danger">*</span></label>
              <input type="text" class="form-control input-sm" id="publishdate" name="publishdate">
            </div>
            <div class="form-group">
              <label for="isbn">ISBN  <span class="text-danger">*</span></label>
              <input type="text" class="form-control input-sm" id="isbn" name="isbn">
            </div>
            <div class="form-group">
              <label for="description">Description  <span class="text-danger">*</span></label>
              <input type="text" class="form-control input-sm" id="description" name="description">
            </div>
            <div class="form-group">
              <label for="category">Category  <span class="text-danger">*</span></label>
              <input type="text" class="form-control input-sm" id="category" name="category">
            </div>
            <div class="form-group text-center">
                <button type="submit" class="btn btn-warning btn-sm" name="saveItem"><strong>Save <span class="glyphicon glyphicon-ok"></span></strong></button>
            </div> 
          </form>
         <br/><br/><br/><br/>
        
    </div>
    <div class="col-sm-3">    
       
    </div>
       
  </div>
</div>

</body>
</html>

