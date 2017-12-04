

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Online Library System</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
  <script src="bootstrap/jquery/jquery.js"></script>
  <script src="bootstrap/js/bootstrap.js"></script>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" style="margin-bottom: 0px;">
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
        <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-dashboard"></span> Home <span class="sr-only">(current)</span></a></li>
        <li><a href="items.jsp"><span class="glyphicon glyphicon-th-large"></span> Items</a></li>
      </ul>
        <form class="navbar-form navbar-left" role="search" method="post" action="searchResults.jsp">
            <div class="form-group">
              <div class="input-group">
                <input type="text" class="form-control" name="searchParameter" placeholder="search">
                <span class="input-group-btn">
                    <button class="btn btn-info" type="submit" name="search"><span class="glyphicon glyphicon-search"></span></button>
                </span>
              </div><!-- /input-group -->
            </div>
         </form>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="register.jsp"><span class="glyphicon glyphicon-cog"></span> Register</a></li>
        <li><a href="login.jsp">Login <span class="glyphicon glyphicon-log-in"></span></a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
    <div id="myCarousel" class="carousel slide" style="margin-top: 0px;">
      <ol class="carousel-indicators">
          <li  data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li  data-target="#myCarousel" data-slide-to="1"></li>
          <li  data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner">
          <div class="item active">
              <img src="images/1.jpg" alt="image1" class="img-responsive" style="width:100%;height:30%;">
             
          </div>
          <div class="item">
              <img src="images/2.jpg" alt="image2" class="img-responsive" style="width:100%;height:30%;"/>
              
          </div>
          <div class="item">
              <img src="images/3.jpg" alt="image " class="img-responsive" style="width:100%;height:30%;"/>
              
          </div>
      </div>
        <a class="carousel-control left" href="#myCarousel" data-slide="prev">
            <span class="icon-prev"></span>
        </a>
        <a class="carousel-control right" href="#myCarousel" data-slide="next">
            <span class="icon-next"></span>
        </a>
  </div>   
    

  
<div class="container" style="margin-top: 20px;">
<div class="alert alert-info text-center" role="alert"  style="opacity: 0.9;filter: alpha(opacity=50); /* For IE8 and earlier */">
    <h1>Welcome to FedUni Online Library System</h1>
</div>
  <div class="row">
    <div class="col-sm-4">
      <div class="panel panel-warning">
        <!-- Default panel contents -->
        <div class="panel-heading"><strong>Latest items</strong></div>
        <div class="panel-body">
         
        </div>
        <!-- List group -->
        <ul class="list-group">
            <%
                Class.forName("com.mysql.jdbc.Driver");
            String url="jdbc:mysql://localhost/";
            String dbName="fedLibrary";
            String username="root";
            String password="";
            String query="select * from items";
            Connection conn=DriverManager.getConnection(url+dbName,username,password);
            try
            {
            
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(query);
            while(rs.next())
            {
            %>

            <li class="list-group-item"><strong class="label label-primary"><%=rs.getString("id")+".</strong> "+" &nbsp &nbsp  &nbsp "+rs.getString("title") %></li>
            
             <%
            }
              
                }
            catch(Exception e)
            {
                e.printStackTrace();
                }
            %>
        </ul>
      </div>
    </div>
    <div class="col-sm-4">
        <div class="panel panel-warning">
        <!-- Default panel contents -->
        <div class="panel-heading"><strong>Latest comments</strong></div>
      <%
                String query2="select items.title as title,comments.comment as comment,comments.ctime as ctime from comments inner join items on items.id=comments.item";
                Statement stmt2=conn.createStatement();
                ResultSet rs2=stmt2.executeQuery(query2);
                try{
                    if(rs2.next()){
                        %>
                        <div class="list-group"><%
                            int i=1;
                            while(rs2.next()) {
                                %>
                                <a href="#" class="list-group-item">
                                    <h4 class="list-group-item-heading"><strong><%=rs2.getString("title")%></strong><small class="label label-info pull-right text-muted"><i><%=rs2.getString("ctime")%></i></small></h4>
                                    <p class="list-group-item-text"><%=rs2.getString("comment")%></p>
                                  </a>
                               <%
                            }%>
                        </div>
                           <%
                    }else{
                        String resp="<br/><div class=\"alert alert-info\" role=\"alert\"><strong>Hi!</strong>"
                                + " No comment made so far.</div>";
                        out.println(resp);
                    }
                }catch(Exception e){
                   e.printStackTrace();
                }
            %>
        </div>
    </div>
    <div class="col-sm-4">
        <div class="panel panel-warning">
        <!-- Default panel contents -->
        <div class="panel-heading"><strong>News and events</strong></div> 
        <ul class="media-list">
            <li class="media">
              
              <div class="media-body">
                  <h4 class="media-heading"><strong>Library going online</strong></h4>
                   Fed Uni Library is going totally online where you can borrow books online.
              </div>
            </li>
            <li class="media">
              
              <div class="media-body">
                  <h4 class="media-heading"><strong>Better infrastructure</strong></h4>
                    More capacity for more books in the campus library now.
              </div>
            </li>
        </ul>
        </div>
    </div>
  </div>
</div>

</body>
</html>

