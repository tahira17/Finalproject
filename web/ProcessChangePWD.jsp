<%--
  Created by IntelliJ IDEA.
  User: mano
  Date: 2/1/2020
  Time: 10:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%
  String OldPassword = request.getParameter("OldPassword");
  String Newpass = request.getParameter("newpassword");
  String conpass = request.getParameter("conpassword");
  String destpage ="index.jsp";

  Connection con = null;
  Statement st = null;
  String pass = "";
  int id = 0;
  try {
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/login";
    con = DriverManager.getConnection(url, "root", "");
    st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from registercustomer where password= '"+ OldPassword + "'");
    if (rs.next()) {
      pass = rs.getString("password");
    }
    if(Newpass.equals(conpass))
    {
      if (pass.equals(OldPassword)) {
        st = con.createStatement();
        int i = st.executeUpdate("update registercustomer set password='"+ Newpass + "'");

        st.close();
        con.close();
        destpage="index.jsp";
      } else {

      destpage="error.jsp";

      }
/*}else{
out.println("new password and confirm new password is not matching");

}*/
      RequestDispatcher dispatcher = request.getRequestDispatcher(destpage);
      dispatcher.forward(request, response);

    }
  } catch (Exception e) {
    out.println(e);
  }
%>