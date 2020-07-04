<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%! String driverName ="com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/login";%>
<%!String user = "root";%>
<%!String psw = "";%>
<%
  String id = request.getParameter("id");
  String cash = request.getParameter("cash");
  String credit = request.getParameter("credit");
  String accountno = request.getParameter("accountno");
  String cardno = request.getParameter("cardno");
  String expmonth = request.getParameter("expmonth");
  String expdate = request.getParameter("expdate");
  String expyear = request.getParameter("expyear");
  String cvv = request.getParameter("cvv");
  String amount = request.getParameter("amount");
  String email = request.getParameter("email");

  if(email != null)
  {
    Connection con = null;
    PreparedStatement ps = null;
    try
    {
      Class.forName(driverName);
      con = DriverManager.getConnection(url,user,psw);
      String sql="Update paymentmethod set id=?,cash=?,credit=?,accountno=?,cardno=?,expmonth=?,expdate=?,expyear=?,cvv=?,amount=?,email=? where id="+id ;
      ps = con.prepareStatement(sql);
     ps.setString(1,id);
      ps.setString(2, cash);
      ps.setString(3, credit);
      ps.setString(4, accountno);
      ps.setString(5, cardno);
      ps.setString(6, expmonth);
      ps.setString(7, expdate);
      ps.setString(8, expyear);
      ps.setString(9, cvv);
      ps.setString(10, amount);
      ps.setString(11, email);
      int i = ps.executeUpdate();
      if(i > 0)
      {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/PaymentMethod.jsp");
        dispatcher.forward(request, response);
      }
      else
      {
        out.print("There is a problem in updating Record.");
      }
    }
    catch(SQLException sql)
    {
      request.setAttribute("error", sql);
      out.println(sql);
    }



  }
%>