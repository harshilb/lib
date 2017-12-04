
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Search</title>
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
<div class="container" style="margin-top: 80px;">
  <div class="row">
      <div class="col-sm-12">
          <ol class="breadcrumb">
            <li><a href="admin.jsp">Home</a></li>
            <li class="active">Search Results</li>
          </ol>
      </div>
    <div class="col-sm-12">
        <h4 class="page-header text-center text-info" style="margin-top: 0px;">Your search results</h4>

        <div class="col-sm-3"></div>
        <div class="col-sm-6">
                <%  
                    String btnSearch = request.getParameter("search");
                    String searchParameter=request.getParameter("searchParameter");
                    if(btnSearch!=null){
                        if(searchParameter==null || searchParameter.equals("") ||"".equals(searchParameter)){
                            %>
                                <div class="alert alert-danger" role="alert">Error! Search parameter can't be null or empty! Try again...</div>
                            <%
                        }else{
                    try
                    {
                    Class.forName("com.mysql.jdbc.Driver");
                    String url="jdbc:mysql://localhost/";
                    String dbName="fedLibrary";
                    String username="root";
                    String password="";
                    String query="select * from items where title like '%"+searchParameter+"%' or id like '%"+searchParameter+"%' or"
+ " author like'%"+searchParameter+"%' or publisher like '%"+searchParameter+"%' or isbn like '%"+searchParameter+"%' or description like '%"+searchParameter+"%'"
+ "or category like '%"+searchParameter+"%' or status like '%"+searchParameter+"%'";
                    Connection conn=DriverManager.getConnection(url+dbName,username,password);
                    Statement stmt=conn.createStatement();
                    ResultSet rs=stmt.executeQuery(query);
                    if(rs.next()){

                    while(rs.next())
                    {

                    %>
                    <div class="media">
                        <div class="media-left media-top">
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading page-header text-primary"><strong><%=rs.getString("title") %></strong><span class="pull-right"><small><i>[<%=rs.getString("publishdate")%>]</i></small></span></h4>
                           <small><i>Author: <%=rs.getString("author")%>, </i></small><small><i>Publisher: <%=rs.getString("publisher")%></i></small><br/>
                           <%=rs.getString("description")%> <span class="label label-info"><small><i>[Status: <%=rs.getString("status")%>]</i></small></span>
                        </div>
                      </div>
                       
                            <%
                    }
                }else{
                %>
                <div class="alert alert-info" role="alert"><strong>Sorry.</strong> We dint find anything matching that parameter, try something else...</div>
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
            }
        }else{
        %>
        <div class="alert alert-danger" role="alert">You need to type a keyword first and then hit search!</div>
        <%
        }
     %>
        </div>
       <div class="col-sm-3"></div>
    </div>
  </div>
</div>

</body>
</html>



