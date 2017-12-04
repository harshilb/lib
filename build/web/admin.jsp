
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
        <li class="active"><a href="admin.jsp"><span class="glyphicon glyphicon-dashboard"></span> Home <span class="sr-only">(current)</span></a></li>
        <li><a href="adminItems.jsp"><span class="glyphicon glyphicon-th-large"></span> Items</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <p class="navbar-text">Signed in as Admin</p>
        <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
    <div class="container" style="margin-top: 100px;">
  <div class="row">
    <div class="col-sm-8">
      <div class="panel panel-warning">
        <!-- Default panel contents -->
        <div class="panel-heading"><strong>Registered users</strong></div>

        <!-- Table -->
        <table class="table table-hover">
            <thead>
              <tr>
                <th>#</th>
                <th>Email</th>
                <th>Full Name</th>
                <th>Phone No</th>
                <th>Options</th>
              </tr>
            </thead>
            <tbody>
                <%
                    Class.forName("com.mysql.jdbc.Driver");
                    String url="jdbc:mysql://localhost/";
                    String dbName="fedLibrary";
                    String username="root";
                    String password="";
                    String query="select * from users";
                    Connection conn=DriverManager.getConnection(url+dbName,username,password);
                    try
                    {
                    
                    Statement stmt=conn.createStatement();
                    ResultSet rs=stmt.executeQuery(query);
                    int i=1;
                    while(rs.next())
                    {

                    %>
                        
                        <tr>
                            <td><%=i+"." %></td>
                            <td><%=rs.getString("email") %></td>
                            <td><%=rs.getString("fname") %></td>
                            <td><%=rs.getString("phone") %></td>
                            <td>
                                <div class="btn-group" role="group" aria-label>
                                    <form method="post" action="deleteUser">
                                        <input type="text" style="display:none"name="email" value="<%=rs.getString("email")%>">
                                        <button type="button" class="btn text-success btn-xs">Edit</button>
                                        <button type="subimt" name="deleteUser" class="btn text-danger btn-xs">Delete</button>
                                    </form>
                                  </div>
                            </td>
                        </tr>
                            <%
                                i++;
                    }
                 %>
            </tbody>
          </table>
              <%
                    
                    }
                catch(Exception e)
                {
                    e.printStackTrace();
                    }
                %>
      </div>
    </div>
    <div class="col-sm-4">
        <%
            String servletAttribute = (String)request.getAttribute("servletAttribute");                   
            if(servletAttribute==null){
            }else if(servletAttribute.equals("admin@gmail.com ")){
            
            }else{
               out.print(servletAttribute); 
            }
        %>  
      <div class="panel panel-warning">
        <!-- Default panel contents -->
        <div class="panel-heading"><strong>Latest comments</strong></div>

        <!-- Table -->
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
                                <div class="list-group-item">
                                <form method="post" action="deleteComment">
                                    <input type="text" style="display:none"name="ctime" value="<%=rs2.getString("ctime")%>">
                                    <h4 class="list-group-item-heading"><strong class="text-primary"><%=rs2.getString("title")%></strong><small class="badge pull-right"><i><%=rs2.getString("ctime")%></i></small></h4>
                                    <p class="list-group-item-text"><%=rs2.getString("comment")%></p>
                                    <p class="list-group-item-text ">
                                        <div class="btn-group  pull-right" role="group" aria-label="...">
                                            <button type="submit" name="deleteComment" class="btn btn-danger btn-xs">Delete</button>
                                        </div>
                                    </p>
                                </form>
                                </div>
                               <%
                            }%>
                        </div>
                           <%
                    }else{
                        String resp="<br/><div class=\"alert alert-info\" role=\"alert\"><strong>Hi!</strong>"
                                + " No comment so far.</div>";
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

