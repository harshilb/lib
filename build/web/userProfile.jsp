
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Users</title>
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
        <a class="navbar-brand" href="userProfile.jsp">FedUni</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="userProfile.jsp"><span class="glyphicon glyphicon-dashboard"></span> Home <span class="sr-only">(current)</span></a></li>
        <li><a href="userItems.jsp"><span class="glyphicon glyphicon-th-large"></span> Items</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <p class="navbar-text">Signed in as User</p>
        <li><a href="logout.jsp">Logout <span class="glyphicon glyphicon-log-out"></span></a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<div class="container" style="margin-top: 20px;">
<%
    Class.forName("com.mysql.jdbc.Driver");
        String url="jdbc:mysql://localhost/";
        String dbName="fedLibrary";
        String username="root";
        String password="";
        Statement stmt;
        ResultSet rs;
        Connection conn=DriverManager.getConnection(url+dbName,username,password);
        String email = (String)session.getAttribute("user");
        try
        {
        String query="select * from users where email='"+email+"'";
        stmt=conn.createStatement();
        rs=stmt.executeQuery(query);
        while(rs.next())
        {
        %>
            <div class="jumbotron text-center">
                <p class="text-center">
                    
                </p>
              <h1>Welcome, <%=rs.getString("fname")%></h1>
              <p>Email address: <%=rs.getString("email")%>, Phone number: <%=rs.getString("phone")%>.</p> 
            </div>
              <%
        }
            }
        catch(Exception e)
        {
            e.printStackTrace();
            }
        %>
  <div class="row">
    <div class="col-sm-8">
      <div class="panel panel-warning">
        <!-- Default panel contents -->
        <div class="panel-heading"><strong>Borrowed items:</strong>
            <a href="userItems.jsp" class="pull-right"><button type="button" class="btn btn-danger btn-xs ">Borrow Item <span class="glyphicon glyphicon-lock"></span></button></a>
        </div>
        <!-- List group -->
       
            <%
                String query1="select items.title as title,borrowings.user as user,borrowings.date_borrowed as dateB from borrowings inner join items on items.id=borrowings.item where user='"+email+"'";
                Statement stmt1=conn.createStatement();
                ResultSet rs1=stmt1.executeQuery(query1);
                try{
                    if(rs1.next()){
                        %>
                        <ul class="list-group"><%
                            int i=1;
                            while(rs1.next()) {
                                %>
                                <li class="list-group-item"><strong><%=i+" . "%></strong><%=rs1.getString("title")%><i><small class="pull-right">borrowed on:<%=rs1.getString("dateB")%></small></i></li>
                                <%
                            }%>
                        </ul>
                           <%
                    }else{
                        String resp="<br/><div class=\"alert alert-info\" role=\"alert\"><strong>Sorry!</strong>"
                                + " No items borrowed yet.</div>";
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
        <div class="panel-heading"><strong>Comments history:</strong></div>
        <!-- List group -->
        <%
                String query2="select items.title as title,comments.comment as comment,comments.ctime as ctime from comments inner join items on items.id=comments.item where comments.user='"+email+"'";
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
                                    <h4 class="list-group-item-heading"><strong><%=rs2.getString("title")%></strong><small class="badge pull-right"><i><%=rs2.getString("ctime")%></i></small></h4>
                                    <p class="list-group-item-text"><%=rs2.getString("comment")%></p>
                                  </a>
                               <%
                            }%>
                        </div>
                           <%
                    }else{
                        String resp="<br/><div class=\"alert alert-info\" role=\"alert\"><strong>Sorry!</strong>"
                                + " No comments made yet.</div>";
                        out.println(resp);
                    }
                }catch(Exception e){
                   e.printStackTrace();
                }
            %>
        
            
      </div>
    </div>
  </div>
</div>

</body>
</html>

