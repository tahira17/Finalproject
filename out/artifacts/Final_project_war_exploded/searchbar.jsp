<%--
  Created by IntelliJ IDEA.
  User: MAHNOOR
  Date: 6/24/2020
  Time: 4:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String destpage ="profiles.jsp";
  String seacrh = request.getParameter("searchtxt");

  if(seacrh == "login" || seacrh == "Login")
  {

    response.sendRedirect(destpage);
  }


%>