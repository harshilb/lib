
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
        <li><a href="userProfile.jsp"><span class="glyphicon glyphicon-dashboard"></span> Home <span class="sr-only">(current)</span></a></li>
        <li  class="active"><a href="userItems.jsp"><span class="glyphicon glyphicon-th-large"></span> Items</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <p class="navbar-text">Signed in as User</p>
        <li><a href="logout.jsp">Logout <span class="glyphicon glyphicon-log-out"></span></a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<div class="container" style="margin-top: 80px;">
  <div class="row">
      <div class="col-sm-12">
          <ol class="breadcrumb">
            <li><a href="admin.jsp">Home</a></li>
            <li class="active">Items</li>
          </ol>
      </div>
    <div class="col-sm-12">
         <%
            String servletAttribute = (String)request.getAttribute("servletAttribute");
            if(servletAttribute==null){
                
            }else{
               out.print(servletAttribute); 
            }
            
        %>  
        <h4 class="page-header text-info text-center" style="margin-top: 0px;">Items</h4>
        
      <div class="panel panel-warning">
        <!-- Default panel contents -->
        <div class="panel-heading"><strong>Registered items</strong>
        </div>

        <!-- Table -->
        <table class="table table-hover">
            <thead>
              <tr>
                <th>Item ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Publisher</th>
                <th>Publish Date</th>
                <th>ISBN</th>
                <th>Description</th>
                <th>Status</th>
                <th>Category</th>
                <th>Options</th>
              </tr>
            </thead>
            <tbody>
                
                <%
                    try
                    {
                    Class.forName("com.mysql.jdbc.Driver");
                    String url="jdbc:mysql://localhost/";
                    String dbName="fedLibrary";
                    String username="root";
                    String password="";
                    String query="select * from items";
                    Connection conn=DriverManager.getConnection(url+dbName,username,password);
                    Statement stmt=conn.createStatement();
                    ResultSet rs=stmt.executeQuery(query);
                    //int user = (int)session.getAttribute("user_id");
                    String email = (String)session.getAttribute("user");
                    while(rs.next())
                    {
                        
                    
                    String query1="select * from borrowings where item='"+rs.getInt("id")+"' and status='Borrowed'";
                                  Statement stmt1=conn.createStatement();
                                  ResultSet rs1=stmt1.executeQuery(query1);
                                  
                    %>
            
            <form method="post" action="processUserItemRequest">
                        <tr>
                            <input type="text" style="display:none;" name="item" value="<%=rs.getInt("id") %>"/>
                            <input type="text" style="display:none" name="user" value="<%=email%>"/>
                            <td><span class="label label-warning"><%=rs.getInt("id") %>. </span></td>
                            <td><%=rs.getString("title") %></td>
                            <td><%=rs.getString("author") %></td>
                            <td><%=rs.getString("publisher") %></td>
                            <td><%=rs.getString("publishdate") %></td>
                            <td><%=rs.getString("isbn") %></td>
                            <td><%=rs.getString("description") %></td>
                            <td><% if(rs1.next()){
                            out.println("Borrowed") ;
                            }else{out.println("Available");}%></td>
                            <td><%=rs.getString("category") %></td>
                            <td>
                                <div class="btn-group" role="group" aria-label="...">
                                    <button type="submit" name="borrow" class="btn text-info btn-xs">Borrow</button>
                                    <textarea name="commentVal" cols="2" rows="1"></textarea>
                                        <button type="submit" name="comment"  class="btn btn-info text-primary btn-xs">Comment</button>
                                  </div>
                            </td>
                            
                        </tr>
            </form>
                            <%
                    }
                 %>
            </tbody>
          </table>
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

