<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%--
  Created by IntelliJ IDEA.
  User: MAHNOOR
  Date: 7/3/2020
  Time: 10:53 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">

  <title></title>

  <!-- Bootstrap Core CSS -->
  <link href="../../css/bootstrap.min.css" rel="stylesheet">

  <!-- MetisMenu CSS -->
  <link href="../../css/metisMenu.min.css" rel="stylesheet">

  <!-- Timeline CSS -->
  <link href="../../css/timeline.css" rel="stylesheet">

  <!-- Custom CSS -->
  <link href="../../css/startmin.css" rel="stylesheet">

  <!-- Morris Charts CSS -->
  <link href="../../css/morris.css" rel="stylesheet">

  <!-- Custom Fonts -->
  <link href="../../css/font-awesome.min.css" rel="stylesheet" type="text/css">

  <style>

    body{
      background-size: cover;
    }
    .box {
      width: 60%;
      margin: 0 auto;
      background: rgba(255,255,255,255);
      padding: 35px;
      border: 2px solid #fff;
      border-radius: 20px/50px;
      text-align: center;
    }

    .button {
      font-size: 1em;
      padding: 10px;
      color: #fff;
      border: 2px solid ;
      border-radius: 20px/50px;
      text-decoration: none;
      transition: all 0.3s ease-out;
    }


    .overlay {
      position: fixed;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
      background: rgba(0, 0, 0, 0.7);
      transition: opacity 500ms;
      visibility: hidden;
      opacity: 0;
    }
    .overlay:target {
      visibility: visible;
      opacity: 1;
    }

    .popup {
      text-align: center;
      margin: 70px auto;
      padding: 20px;
      background: #fff;
      border-radius: 5px;
      width: 50%;
      position: relative;
      transition: all 5s ease-in-out;
    }

    .popup h2 {
      margin-top: 0;
      color: #333;
      font-family: Tahoma, Arial, sans-serif;
    }
    .popup .close {
      position: absolute;
      top: 20px;
      right: 30px;
      transition: all 200ms;
      font-size: 30px;
      font-weight: bold;
      text-decoration: none;
      color: #333;
    }
    .popup .close:hover {
      color: #06D85F;
    }
    .popup .content {
      max-height: 30%;
      overflow: auto;
    }

    @media screen and (max-width: 900px){
      .box{
        width: 70%;
      }
      .popup{
        width: 100%;
      }
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
          <i class="fa fa-user fa-fw" style="color:white;"></i>    <%
          if(session.getAttribute("email")!=null) {
            String email1 = (String) session.getAttribute("email");

            out.print(email1);
          }
        %><b class="caret" style="color:white;"></b>
        </a>
        <ul class="dropdown-menu dropdown-user">
          <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
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
          <h1 class="page-header">Check-Out</h1>
        </div>
        <!-- /.col-lg-12 -->
      </div>
      <!-- /.row -->
      <div class="row">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
          <%
            Connection conn = null;
            Statement statement = null;
            ResultSet resultSet = null;
            String dbURL = "jdbc:mysql://localhost:3306/login";
            String dbUser = "root";
            String dbPass = "";

            String email = (String) session.getAttribute("email");

            try{
              DriverManager.registerDriver(new com.mysql.jdbc.Driver());
              conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
              statement=conn.createStatement();
              String sql ="SELECT id FROM paymentmethod where email='"+email+"'";

              resultSet = statement.executeQuery(sql);
              while(resultSet.next()){


          %>



          <button type="submit"><a  href="PaymentUpdate.jsp?id=<%=resultSet.getString("id") %>" class="btn btn-success" style="background-color:#008B8B;" > <span>Edit Payment Method?</span></a></button>




          <%


              }
              conn.close();
            }

            catch (Exception e)
            {
              e.printStackTrace();
            }

          %>

          <h3>Please Select payment method.</h3>
        </div>

      </div>
      </br>
      </br>

      <div class="row">

        <div class="col-sm-12">



          <div class="tab-content">

            <form action="PaymentInsert.jsp" method="post">
              <div class="row">
                <div class="col-lg-4">


                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="cash" id="gridRadios1" value="Cash on Delivery">
                    <label class="form-check-label" for="gridRadios1">
                       Cash on delivery
                    </label>
                  </div>
                </div>
                <div class="col-lg-8">
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="credit" id="gridRadios2" value="Cash From Account" >
                    <label class="form-check-label" for="gridRadios2">
                     Account Information
                    </label>
                  </div>
                  </br>

                  <div class="form-group">
                    <label for="cc_name">Account No</label>
                    <input type="text" class="form-control" id="cc_name"  maxlength="20"  name="accountno" title="Please enter which Match the Account No." >
                  </div>

                  <div class="form-group">
                    <label>Card Number</label>
                    <input type="text" class="form-control" autocomplete="off" maxlength="20" pattern="\d{16}" name="cardno" title="Credit card number" >
                  </div>
                  <div class="form-group row">
                    <label class="col-md-12">Card Exp. Month</label>
                    <div class="col-md-4">
                      <select class="form-control" name="expmonth" size="0">
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                      </select>
                    </div>
                    <label class="col-md-12">Card Exp. Date</label>
                    <div class="col-md-4">
                      <select class="form-control" name="expdate" size="0">
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                      </select>
                    </div>
                    <label class="col-md-12">Card Exp. Year</label>
                    <div class="col-md-4">
                      <select class="form-control" name="expyear" size="0">
                        <option>2018</option>
                        <option>2019</option>
                        <option>2020</option>
                        <option>2021</option>
                        <option>2022</option>
                      </select>
                    </div>
                    <label class="col-md-12">Three digits at back of your card</label>
                    <div class="col-md-4">
                      <input type="text" class="form-control" name="cvv" autocomplete="off" maxlength="3" pattern="\d{3}" title="Three digits at back of your card" required="" placeholder="CVC">
                    </div>
                  </div>
                  <div class="row">
                    <label class="col-md-12">Amount</label>
                  </div>
                  <div class="form-inline">
                    <div class="input-group">
                      <div class="input-group-prepend"><span class="input-group-text">pkr</span></div>
                      <input type="text" class="form-control text-right" name="amount" id="exampleInputAmount" placeholder="39">
                      <div class="input-group-append"><span class="input-group-text">.00</span></div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="cc_name">Your Email</label>
                    <input type="text" class="form-control"  name="email" value="<%
                         String email1 = (String) session.getAttribute("email");
                    out.print(email1); %>"maxlength="20"  name="email" title="">
                  </div>
                  <hr>
                  <div class="form-group row">
                    <div class="col-md-6">
                      <button type="reset" class="btn btn-default btn-lg ">Cancel</button>
                      <button type="submit" class="btn btn-success btn-lg" >Confirm Order</button>


                    </div>



                  </div>

                </div>
              </div>

            </form>
          </div>
        </div>
      </div>


    </div>
  </div>
</div>



<script src="../../js/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="../../js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="../../js/metisMenu.min.js"></script>

<!-- Morris Charts JavaScript -->
<script src="../../js/raphael.min.js"></script>
<script src="../../js/morris.min.js"></script>
<script src="../../js/morris-data.js"></script>

<!-- Custom Theme JavaScript -->
<script src="../../js/startmin.js"></script>

</body>
</html>
