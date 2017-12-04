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
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;


@WebServlet(urlPatterns = {"/deleteItem"})
public class deleteItem extends HttpServlet {

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
                out.println("<body onload=\"setTimeout(function(){document.location = 'adminItems.jsp'}, 3000)\">");
                out.println("<div class=\"container\">");
                    out.println("<div class=\"row\">");
                        out.println("<div class=\"col-sm-3\">");
                        out.println("</div>");
                        out.println("<div class=\"col-sm-6\">");
                            String deleteItem = request.getParameter("deleteItem");
                            String item=request.getParameter("item");
                            if(deleteItem!=null){
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


                                   String sql="delete from items where id=?";
                                   String sql1="delete from borrowings where item=?";
                                   String sql2="delete from comments where item=?";

                                  try{
                                  PreparedStatement pst,pst1,pst2; 
                                  pst=conn.prepareCall(sql1);
                                  pst.setString(1,item);
                                  pst.execute();
                                  pst1=conn.prepareCall(sql2);
                                  pst1.setString(1,item);
                                  pst1.execute();
                                  pst2=conn.prepareCall(sql);
                                  pst2.setString(1,item);
                                  pst2.execute();
                                      String resp="<br/><div class=\"alert alert-success\" role=\"alert\"><strong>Success!</strong>"
                                    + " Item  deleted successfully.</div>";
                                    request.setAttribute("servletAttribute", resp);

                                    RequestDispatcher view = request.getRequestDispatcher("/adminItems.jsp");      
                                    view.forward(request, response);
                                  
                                  }
                                  catch(Exception e)
                                      
                                  {
                                  pw.println(e);
                                  }

                                }  
                                catch (Exception e){  
                                  pw.println(e);
                                }   
                                        
                                    
                                }else{
                                String resp="<br/><div class=\"alert alert-Error\" role=\"alert\"><strong>Error!</strong>"
                                    + " Page accessed wrongly.</div>";
                                    request.setAttribute("servletAttribute", resp);

                                    RequestDispatcher view = request.getRequestDispatcher("/adminItems.jsp");      
                                    view.forward(request, response);
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
