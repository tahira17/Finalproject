<%@page import="com.sun.xml.internal.bind.CycleRecoverable.Context"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Insert</title>
</head>
<body>
<%
  String dbURL = "jdbc:mysql://localhost:3306/login";
  String dbUser = "root";
  String dbPass = "";
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs=null;

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
//out.print("First Name :"+fname+"myloc="+myloc);
  try{

    DriverManager.registerDriver(new com.mysql.jdbc.Driver());
    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

    pstmt = conn.prepareStatement("insert into paymentmethod (cash,credit,accountno,cardno,expmonth,expdate,expyear,cvv,amount,email) " + "values (?,?,?,?,?,?,?,?,?,?)");



    pstmt.setString(1, cash);
    pstmt.setString(2, credit);
    pstmt.setString(3, accountno);
    pstmt.setString(4, cardno);
    pstmt.setString(5, expmonth);
    pstmt.setString(6, expdate);
    pstmt.setString(7, expyear);
    pstmt.setString(8, cvv);
    pstmt.setString(9, amount);
    pstmt.setString(10, email);

    int count = pstmt.executeUpdate();
    if(count>0)
    {
      out.println("insert successfully");
    }
    else
    {
      out.println("not successfully");
    }
  }
  catch(Exception ex)
  {
    ex.printStackTrace();
  }
  finally{
    try{
      if(rs!=null){
        rs.close();
        rs= null;
      }
      if(pstmt !=null)
      {
        pstmt.close();
        pstmt=null;
      }
      if(conn!=null)
      {
        conn.close();
        conn=null;
      }
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }

    RequestDispatcher dispatcher = request.getRequestDispatcher("PaymentMethod.jsp");
    dispatcher.forward(request, response);


  }




%>
</body>
</html>