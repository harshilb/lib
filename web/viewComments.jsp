
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Comments</title>
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
         <a class="navbar-brand" href="admin.jsp">FedUni</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="admin.jsp"><span class="glyphicon glyphicon-dashboard"></span> Home <span class="sr-only">(current)</span></a></li>
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
            <li class="active">Comments</li>
          </ol>
      </div>
    <div class="col-sm-12">
      <div class="panel panel-warning">
        <!-- Default panel contents -->
        <div class="panel-heading"><strong>Item comments</strong>
        </div>

        
                <%
                    try
                    {
                    Class.forName("com.mysql.jdbc.Driver");
                    String url="jdbc:mysql://localhost/";
                    String dbName="fedLibrary";
                    String username="root";
                    String password="";
                    String query="select items.title as title,comments.comment as comment,comments.ctime as ctime from comments inner join items on items.id=comments.item";
                    Connection conn=DriverManager.getConnection(url+dbName,username,password);
                    Statement stmt=conn.createStatement();
                    ResultSet rs=stmt.executeQuery(query);
                    while(rs.next())
                    {

                    %>
                    <div class="media">
                        <div class="media-left media-top">
                          <a href="#">
                              <img class="media-object img-circle img-thumbnail img-responsive" src="images/profile.jpg" alt="newLib" style="height: 100px;">
                          </a>
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading"><%=rs.getString("title") %><span class="pull-right"><small><i>[<%=rs.getString("ctime")%>]</i></small></span></h4>
                          <%=rs.getString("comment")%>
                            <form method="post" action="deleteComment">
                                <input type="text" style="display:none"name="ctime" value="<%=rs.getString("ctime")%>">
                                    <div class="btn-group" role="group" aria-label="...">
                                        <button type="submit" name="deleteComment" class="btn text-danger btn-xs">Delete</button>
                                    </div>
                            </form>
                        </div>
                      </div>
                       
                            <%
                    }
                 %>
            
              <%
                    rs.close();
                    stmt.close();
                    conn.close();
                    }
                catch(Exception e)
                {
                    e.printStackTrace();
                    }
                %>
      </div>
    </div>
  </div>
</div>

</body>
</html>


