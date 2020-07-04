<%@ page import="java.sql.*" %>
<%@ page import="javax.xml.bind.DatatypeConverter" %>
<%--
  Created by IntelliJ IDEA.
  User: mano
  Date: 1/28/2020
  Time: 12:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  %>
<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  if(session.getAttribute("user")==null)

    response.sendRedirect("index.jsp");

%>
<%
  String id = request.getParameter("userId");
  String driverName = "com.mysql.jdbc.Driver";
  String connectionUrl = "jdbc:mysql://localhost:3306/";
  String dbName = "login";
  String userId = "root";
  String password = "";

  try {
    Class.forName(driverName);
  } catch (ClassNotFoundException e) {
    e.printStackTrace();
  }

  Connection connection = null;
  Statement statement = null;
  ResultSet resultSet = null;
%>

<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">

  <title></title>

  <!-- Bootstrap Core CSS -->
  <link href="../css/bootstrap.min.css" rel="stylesheet">

  <!-- MetisMenu CSS -->
  <link href="../css/metisMenu.min.css" rel="stylesheet">

  <!-- Timeline CSS -->
  <link href="../css/timeline.css" rel="stylesheet">

  <!-- Custom CSS -->
  <link href="../css/startmin.css" rel="stylesheet">

  <!-- Morris Charts CSS -->
  <link href="../css/morris.css" rel="stylesheet">

  <!-- Custom Fonts -->
  <link href="../css/font-awesome.min.css" rel="stylesheet" type="text/css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->
  <style>
    .profile-img .file {
      position: relative;
      overflow: hidden;
      margin-top: -20%;
      width: 100%;
      border: none;
      border-radius: 0;
      font-size: 15px;
      background: #212529b8;
    }
    .profile-img .file input {
      position: absolute;
      opacity: 0;
      right: 0;
      top: 0;
    }
  </style>
</head>
<body>

<div id="wrapper">

  <!-- Navigation -->
  <nav class="navbar navbar-inverse navbar-fixed-top"  role="navigation" style="background-color:#008B8B; border-color:#008B8B ;">
    <div class="navbar-header">
      <a class="navbar-brand" href="index.html">
        <div style="color:white; font-size:30px">CD Services</b></div>
      </a>
    </div>

    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
      <span class="sr-only"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>



    <ul class="nav navbar-right navbar-top-links" style="background-color:#008B8B;" >
      <li class="dropdown navbar-inverse"style="background-color:#008B8B;">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#"style="background-color:#008B8B;">
          <i class="fa fa-bell fa-fw" style="color:white;"></i> <b class="caret" style="color:white;"></b>
        </a>
        <ul class="dropdown-menu dropdown-alerts">
          <li>
            <a href="#">
              <div>
                <i class="fa fa-twitter fa-fw"></i> 3 New messages
                <span class="pull-right text-muted small">12 minutes ago</span>
              </div>
            </a>
          </li>




        </ul>
      </li>
      <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="background-color:#008B8B; color:white;">
          <i class="fa fa-user fa-fw" style="color:white;"></i> <%

          String email=(String)session.getAttribute("email");

          out.print(email);

        %><b class="caret" style="color:white;"></b>
        </a>
        <ul class="dropdown-menu dropdown-user">
          <li><a href="customerprofile.jsp"><i class="fa fa-user fa-fw"></i> User Profile</a>
          <li class="divider"></li>
          <li><a href="/LogoutServlet"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
          </li>
        </ul>
      </li>
    </ul>
  </nav>
  <!-- /.navbar-top-links -->

  <div class="navbar-default sidebar" role="navigation">
    <div class="sidebar-nav navbar-collapse">
      <ul class="nav" id="side-menu">
        <br>
        <br>
        <br>
        <br>

        <li>
          <a href="customerdashboad.jsp"><i class="fa fa-table fa-fw"></i>Create Profile</a>
        </li>
        <li>
          <a href="customerprofile.jsp"><i class="fa fa-table fa-fw"></i>Create Profile</a>
        </li>
        <li>
          <a href="customerinfo.jsp"><i class="fa fa-user fa-fw"></i>View General info</a>
        </li>
        <li>
          <a href="placeorder.jsp"><i class="fa fa-shopping-cart fa-fw"></i>Place Order</a>
        </li>
      </ul>
    </div>
  </div>
  <div id="page-wrapper">
    <div class="container-fluid">
      <div class="row">
        <div class="col-lg-12">
          <h1 class="page-header"> Customer Dashboard</h1>
        </div>
        <!-- /.col-lg-12 -->
      </div>
      <!-- /.row -->
      <div class="row">
        <div class="col-lg-12">
          <div class="row">
            <div class="col-sm-3"><!--left col-->
              <br>
              <br>
              <br>
              <br>







            </div><!--/col-3-->
            <div class="col-sm-9">
              <ul class="nav nav-tabs">


                <li class="active"><a data-toggle="tab" href="#home"><p class="text-info"><b>General Information</b></p></a></li>



              </ul>
              <br>
              <div class="row">
                <div class="col-md-9">
                </div>
                <div class="col-md-3">

                </div>
              </div>
              <br>
              <div class="row">
                <div class="col-md-12">
                  <table  cellpadding="20" cellspacing="3" border="1" style="border: thick; color: #838b8b">
                    <tr>

                    </tr>
                    <tr bgcolor="149792" style="color: #FFFFFF ;">
                      <td><b>Image</b></td>
                      <td><b>Description</b></td>
                      <td><b>Skills</b></td>
                      <td><b>Phone</b></td>
                      <td><b>Cnic</b></td>
                      <td><b>Email</b></td>
                      <td><b>Address</b></td>
                      <td><b>Edit Profile</b></td>


                    </tr>
                    <%

                      try{
                        connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
                        statement=connection.createStatement();
                        String sql ="SELECT * FROM customer where email='"+email+"'";

                        resultSet = statement.executeQuery(sql);
                        while(resultSet.next()){
                          Blob blob = resultSet.getBlob("image");
                          //  byte byteArray[] = blob.getBytes(1, (int)blob.length());
                          //  response.setContentType("image/gif/png/jpg/jpeg");

                          int myblobLength = (int) blob.length();
                          byte[] myblobAsBytes = blob.getBytes(1, myblobLength);
                          String qrCodeDisplay = DatatypeConverter.printBase64Binary(myblobAsBytes);


                          //   OutputStream os = response.getOutputStream();
                          // os.write(byteArray);
                          //os.flush();
                          //os.close();
                    %>
                    <tr>
                      <td><img style="width:100px" src="data:image/jpg;base64, <%=qrCodeDisplay%>"/></td>
                      <td><%=resultSet.getString("firstname") %></td>
                      <td><%=resultSet.getString("lastname") %></td>
                      <td><%=resultSet.getString("phone") %></td>
                      <td><%=resultSet.getString("cnic") %></td>
                      <td><%=resultSet.getString("email") %></td>
                      <td><%=resultSet.getString("address") %></td>
                      <td><a href="CustomerUpdate.jsp?id=<%=resultSet.getString("id")%>">Edit Profile?</a></td></td>


                    </tr>

                    <%
                        }

                      } catch (Exception e) {
                        e.printStackTrace();
                      }
                    %>
                  </table>






                </div>
              </div>





            </div><!--/col-9-->
          </div><!--/row-->
        </div>
      </div>


    </div>

  </div>

</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="../js/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="../js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="../js/metisMenu.min.js"></script>

<!-- Morris Charts JavaScript -->
<script src="../js/raphael.min.js"></script>
<script src="../js/morris.min.js"></script>
<script src="../js/morris-data.js"></script>

<!-- Custom Theme JavaScript -->
<script src="../js/startmin.js"></script>

</body>
</html>
