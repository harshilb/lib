/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(urlPatterns = {"/login"})
public class login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet items</title>"); 
            out.println("<meta charset=\"utf-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
            out.println("<link rel=\"stylesheet\" href=\"bootstrap/css/bootstrap.css\">");
            out.println("<script src=\"bootstrap/jquery/jquery.js\"></script>");
            out.println("<script src=\"bootstrap/js/bootstrap.js\"></script>");
            out.println("</head>");
                out.println("<body>");
                out.println("<div class=\"container\">");
                    out.println("<div class=\"row\">");
                        out.println("<div class=\"col-sm-3\">");
                        out.println("</div>");
                        out.println("<div class=\"col-sm-6\">");
                            String login = request.getParameter("login");
                            String email = request.getParameter("email");
                            String pwd=request.getParameter("pwd");
                            if(login!=null){
                                if(email.isEmpty()||"".equals(email) || pwd ==null || pwd.isEmpty()){ 
                                    String resp="<div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong>"
                                          + " Enter your username and password first!</div>";
                                            request.setAttribute("servletAttribute", resp);
                                            
                                            RequestDispatcher view = request.getRequestDispatcher("/login.jsp");      
                                            view.forward(request, response);
                                }else{
                                            response.setContentType("text/html");  
                                                Connection conn=null;
                                                String url="jdbc:mysql://localhost:3306/";
                                                String dbName="fedLibrary";
                                                String driver="com.mysql.jdbc.Driver";
                                                String dbUserName="root";
                                                String dbPassword="";

                                            try{  
                                              Class.forName(driver).newInstance();  
                                              conn = DriverManager.getConnection(url+dbName,dbUserName, dbPassword);
                                              Statement stmt=conn.createStatement();
                                              String query="select * from users where email='"+email+"'";
                                                ResultSet rs=stmt.executeQuery(query);
                                                if(rs.next()){
                                                            String pass=rs.getString("password");
                                                            String type=rs.getString("type");
                                                            System.out.println("Hey"+pass);
                                                            
                                                            if(pwd.equalsIgnoreCase(pass)==true){
                                                                    // Get the current session object, create one if necessary
                                                                    HttpSession session = request.getSession(true);
                                                                    session.setAttribute("user", email);
                                                                String resp=email;
                                            request.setAttribute("servletAttribute", resp);
                                            if("user".equals(type)){
                                                RequestDispatcher view = request.getRequestDispatcher("/userProfile.jsp");      
                                            view.forward(request, response);
                                            }else{
                                                RequestDispatcher view = request.getRequestDispatcher("/admin.jsp");      
                                            view.forward(request, response);
                                            }
                                            
                                                            }else{
                                                                String resp="<br/><div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong>"
                                            + " Incorrect password or username. Try again...</div>";
                                            request.setAttribute("servletAttribute", resp);
                                            
                                            RequestDispatcher view = request.getRequestDispatcher("/login.jsp");      
                                            view.forward(request, response);
                                                            }
                                                            System.out.println("Hey");
                                                            rs.close();
                                                    stmt.close();
                                                    conn.close();
                                                }else{
                                                   String resp="<br/><div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong>"
                                            + " You are not registered in the system. Register first...</div>";
                                            request.setAttribute("servletAttribute", resp);
                                            
                                            RequestDispatcher view = request.getRequestDispatcher("/login.jsp");      
                                            view.forward(request, response);
                                               
                                                }
                                               
                                                    }
                                                catch(Exception e)
                                                {
                                                    e.printStackTrace();
                                                    }
                                                 
                                            
                                }
                                
                            }else{
                                out.println("<div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong>"
                                        + " You have accessed this page wrongly!</div>");
                            }
                        out.println("</div>");
                        out.println("<div class=\"col-sm-3\">");
                        out.println("</div>");
                    out.println("</div>");
                out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
