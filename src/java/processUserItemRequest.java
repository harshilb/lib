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
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(urlPatterns = {"/processUserItemRequest"})
public class processUserItemRequest extends HttpServlet {

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
                out.println("<body onload=\"setTimeout(function(){document.location = 'userItems.jsp'}, 3000)\">");
                out.println("<div class=\"container\">");
                    out.println("<div class=\"row\">");
                        out.println("<div class=\"col-sm-3\">");
                        out.println("</div>");
                        out.println("<div class=\"col-sm-6\">");
                            String borrow = request.getParameter("borrow");
                            String comment = request.getParameter("comment");
                            String commentVal = request.getParameter("commentVal");
                            String item = request.getParameter("item");
                            String dateB = (new SimpleDateFormat("yyyy-MM-dd     HH:mm:ss").format(new Date()));
                            String dateR = new SimpleDateFormat("  yyyy-MM-dd     "
                            + "HH:mm:ss").format(new Date());
                            String user=request.getParameter("user");
                            String status="Borrowed";
                            
                            response.setContentType("text/html");  
                            PrintWriter pw = response.getWriter(); 
                            Connection conn=null;
                            String url="jdbc:mysql://localhost:3306/";
                            String dbName="fedLibrary";
                            String driver="com.mysql.jdbc.Driver";
                            String dbUserName="root";
                            String dbPassword="";
                            
                            if(borrow!=null){
                                try{  
                                  Class.forName(driver).newInstance();  
                                  conn = DriverManager.getConnection(url+dbName,dbUserName, dbPassword);
                                  String query="select * from borrowings where item='"+item+"' and status='"+status+"'";
                                  Statement stmt=conn.createStatement();
                                  ResultSet rs=stmt.executeQuery(query);
                                  if(rs.next()){
                                      String resp="<br/><div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong>"
                                + " Sorry the item is already lent out.</div>";
                                request.setAttribute("servletAttribute", resp);

                                RequestDispatcher view = request.getRequestDispatcher("/userItems.jsp");      
                                view.forward(request, response);
                                
                                  
                                }else{
                                      PreparedStatement pst =(PreparedStatement) 
                                          conn.prepareStatement("insert into borrowings(item,user,date_borrowed,date_to_return,status)"
                                                  + " values(?,?,?,?,?);");
                                  pst.setString(1,item);  
                                  pst.setString(2,user);        
                                  pst.setString(3,dateB);
                                  pst.setString(4,dateR);
                                  pst.setString(5,status); ;


                                  int i = pst.executeUpdate(); 
                                  if(i!=0){  
                                    out.println("<div class=\"alert alert-success\" role=\"alert\"><strong>Bravo! </strong> "
                                     + "Your request is successfull...</div>");

                                  }  
                                  else{  
                                    String resp="<br/><div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong>"
                                + " Error processing your request! Try again...</div>";
                                request.setAttribute("servletAttribute", resp);

                                RequestDispatcher view = request.getRequestDispatcher("/userItems.jsp");      
                                view.forward(request, response);
                                   }  
                                  pst.close();
                                  }
                                }
                                catch (Exception e){  
                                  pw.println(e);
                                } 
                               
                            }else if(comment!=null){
                                try{  
                                  Class.forName(driver).newInstance();  
                                  conn = DriverManager.getConnection(url+dbName,dbUserName, dbPassword);
                                  
                                      PreparedStatement pst =(PreparedStatement) 
                                          conn.prepareStatement("insert into comments(ctime,comment,item,user)"
                                                  + " values(?,?,?,?);");
                                  pst.setString(1,dateB);  
                                  pst.setString(2,commentVal);        
                                  pst.setString(3,item);
                                  pst.setString(4,user);

                                  int i = pst.executeUpdate(); 
                                  if(i!=0){  
                                    String resp="<div class=\"alert alert-success\" role=\"alert\"><strong>Success! </strong> "
                                     + "Your comment successfully saved...</div>";
                                request.setAttribute("servletAttribute", resp);

                                RequestDispatcher view = request.getRequestDispatcher("/userItems.jsp");      
                                view.forward(request, response);
                                  }  
                                  else{  
                                    String resp="<br/><div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong>"
                                + " Error saving your comment.</div>";
                                request.setAttribute("servletAttribute", resp);

                                RequestDispatcher view = request.getRequestDispatcher("/userItems.jsp");      
                                view.forward(request, response);
                                   }  
                                  pst.close();
                                  
                                }
                                catch (Exception e){  
                                  pw.println(e);
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
