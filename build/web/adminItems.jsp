
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Admin</title>
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
        <li><a href="admin.jsp"><span class="glyphicon glyphicon-dashboard"></span> Home <span class="sr-only">(current)</span></a></li>\
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
            <li class="active">Items</li>
            
          </ol>
      </div>
    <div class="col-sm-12">
        <h4 class="page-header text-center text-info" style="margin-top: 0px;">Registered items</h4>
      <div class="panel panel-info">
        <!-- Default panel contents -->
        <div class="panel-heading"><strong>Registered items</strong>
            <a href="addItem.jsp" class="pull-right"><button type="button" class="btn text-primary btn-xs "><span class="glyphicon glyphicon-plus"></span> Add Item</button></a>
            <a href="viewComments.jsp" class="pull-right" style="margin-right: 10px;"><button type="button" class="btn text-info btn-xs "><span class="glyphicon glyphicon-comment"></span> View Comments</button></a>
        </div>

        <!-- Table -->
        <table class="table table-hover">
            <thead>
              <tr>
                <th class="bg-warning">Item ID</th>
                <th class="bg-warning">Title</th>
                <th class="bg-warning">Author</th>
                <th class="bg-warning">Publisher</th>
                <th class="bg-warning">Publish Date</th>
                <th class="bg-warning">ISBN</th>
                <th class="bg-warning">Description</th>
                <th class="bg-warning">Status</th>
                <th class="bg-warning">Category</th>
                <th class="bg-warning">Options</th>
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
                    while(rs.next())
                    {
                        String query1="select * from borrowings where item='"+rs.getInt("id")+"' and status='Borrowed'";
                                  Statement stmt1=conn.createStatement();
                                  ResultSet rs1=stmt1.executeQuery(query1);
                    %>
                        
                        <tr>
                            <td><span class="label label-warning"><%=rs.getInt("id") %> .</span></td>
                            <td><%=rs.getString("title") %></td>
                            <td><%=rs.getString("author") %></td>
                            <td><%=rs.getString("publisher") %></td>
                            <td><%=rs.getString("publishdate") %></td>
                            <td><%=rs.getString("isbn") %></td>
                            <td><%=rs.getString("description") %></td>
                            <td><% if(rs1.next()){
                            out.println("Borrowed") ;%><span class="glyphicon glyphicon-ok text-info"</span><%
                            }else{out.println("Available");%><span class="glyphicon glyphicon-refresh text-warning"</span><%}%></td>
                            <td><%=rs.getString("category") %></td>
                            <td>
                                <div class="btn-group" role="group" aria-label="...">
                                    <form method="post" action="deleteItem">
                                        <input type="text" style="display:none"name="item" value="<%=rs.getString("id")%>">
                                        <button type="button" class="btn text-success btn-xs">Edit</button>
                                        <button type="subimt" name="deleteItem" class="btn text-danger btn-xs">Delete</button>
                                    </form>
                                  </div>
                            </td>
                        </tr>
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


