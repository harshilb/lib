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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/register"})
public class register extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     public boolean containsOnlyNumbers(String str) {
        
       //it should not be null
        if (str == null || str.length() == 0)
            return false;
        
        for (int i = 0; i < str.length(); i++) {
 
            //It should not be anything else but number
            if (!Character.isDigit(str.charAt(i)))
                return false;
        }
        
        return true;
    }
 
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
                out.println("<body onload=\"setTimeout(function(){document.location = 'login.jsp'}, 3000)\">");
                out.println("<div class=\"container\">");
                    out.println("<div class=\"row\">");
                        out.println("<div class=\"col-sm-3\">");
                        out.println("</div>");
                        out.println("<div class=\"col-sm-6\">");
                            String btnRegister = request.getParameter("register");
                            String fname=request.getParameter("fname");
                            String email=request.getParameter("email");
                            String phone=request.getParameter("phone");
                            String pass=request.getParameter("pwd");
                            if(btnRegister!=null){
                                String EMAIL_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
                                Boolean b = email.matches(EMAIL_REGEX);
                                if(phone.isEmpty()||"".equals(pass) || fname ==null || fname.isEmpty() || "".equals(email)|| email.isEmpty() || "".equals(phone)||
                                        pass.isEmpty()){ 
                                    String resp="<div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong>"
                                          + " Some fields are empty! Try again...</div>";
                                            request.setAttribute("servletAttribute", resp);
                                            
                                            RequestDispatcher view = request.getRequestDispatcher("/register.jsp");      
                                            view.forward(request, response);
                                }else{
                                    if(b==true){
                                        Boolean checkPhone=containsOnlyNumbers(phone);
                                        if(checkPhone==true){
                                            response.setContentType("text/html");  
                                                PrintWriter pw = response.getWriter(); 
                                                Connection conn=null;
                                                String url="jdbc:mysql://localhost:3306/";
                                                String dbName="fedLibrary";
                                                String driver="com.mysql.jdbc.Driver";
                                                String dbUserName="root";
                                                String dbPassword="";

                                            try{  
                                              Class.forName(driver).newInstance();  
                                              conn = DriverManager.getConnection(url+dbName,dbUserName, dbPassword);
                                              PreparedStatement pst =(PreparedStatement) 
                                                      conn.prepareStatement("insert into users(email,fname,phone,password,type)"
                                                              + " values(?,?,?,?,?);");
                                              String type="user";
                                              pst.setString(1,email);  
                                              pst.setString(2,fname);        
                                              pst.setString(3,phone);
                                              pst.setString(4,pass);
                                              pst.setString(5,type);

                                              int i = pst.executeUpdate(); 
                                              if(i!=0){  
                                                out.println("<div class=\"alert alert-success\" role=\"alert\"><strong>Thank you "+fname+"!</strong> "
                                        + "You have been registered successfully!</div>");

                                              }  
                                              else{  
                                                String resp="<br/><div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong>"
                                            + " Error during registration! Try again...</div>";
                                            request.setAttribute("servletAttribute", resp);
                                            
                                            RequestDispatcher view = request.getRequestDispatcher("/register.jsp");      
                                            view.forward(request, response);
                                               }  
                                              pst.close();
                                            }  
                                            catch (Exception e){  
                                              pw.println(e);
                                            } 
                                            
                                        }else{
                                            String resp="<br/><div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong>"
                                            + " It seems your phone number is not correct! Try again...</div>";
                                            request.setAttribute("servletAttribute", resp);
                                            
                                            RequestDispatcher view = request.getRequestDispatcher("/register.jsp");      
                                            view.forward(request, response);
                                        }
                                    }else{
                                        String resp="<div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong>"
                                          + " Email entered is not valid! Try again...</div>";
                                            request.setAttribute("servletAttribute", resp);
                                            
                                            RequestDispatcher view = request.getRequestDispatcher("/register.jsp");      
                                            view.forward(request, response);
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
