package com;

import dao.CustomerRegistrationDAO;
import pojo.CustomerRegistration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * Created by mano on 1/31/2020.
 */
@WebServlet(name = "CustomerRegistrationServlet")
public class CustomerRegistrationServlet extends HttpServlet {
    CustomerRegistration cust = new CustomerRegistration();
    CustomerRegistrationDAO custdao = new CustomerRegistrationDAO();
    String destpage ="/otp.jsp";
    String resultMessage = "";
    private String host;
    private String port;
    private String user;
    private String pass;



    public void init() {

        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(true);


        Random rand = new Random();
        int i = (int) (new Date().getTime()/1000);
        int otp = rand.nextInt(900000) + 100000+ i;
        session.setAttribute("otp",otp);



        String recipient = request.getParameter("email");
        String subject = "Mahnoor Khan From CD Service ";
        StringBuffer content = new StringBuffer("<html> CD Services<br>");
        content.append("<h1>You are successfully added to our team</h1><br>"+ "<h1>Your Code is</h1>" +"<h1>"+otp+"</h1>");
        content.append("<h2>Thank you for joining CD Services</h2><br>");
        content.append("<img src=\\\"cid:image2\\\" width=\"15%\" height=\"15%\" /><br>");
        content.append("<h3>--CEO Mahnoor Khan--</h3>");
        content.append("</html>");

        Map<String, String> inlineImages = new HashMap<String, String>();
        inlineImages.put("image2", "D:\\semester 7\\Design Project part-1\\new interface 3\\pages\\login\\images\\bg-01.jpg");






        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmpassword = request.getParameter("confirmpassword");
        String registration = request.getParameter("registration");
        String gender = request.getParameter("gender");

        session.setAttribute("firstname",firstname);
        session.setAttribute("lastname",lastname);
        session.setAttribute("email",email);
        session.setAttribute("password",password);
        session.setAttribute("confirmpassword",confirmpassword);
        session.setAttribute("registration",registration);
        session.setAttribute("gender",gender);

        cust.setFirstname(firstname);
        cust.setLastname(lastname);
        cust.setEmail(email);
        cust.setPassword(password);
        cust.setConfirmpassword(confirmpassword);
        cust.setRegistration(registration);
        cust.setGender(gender);


        try {
            // custdao.checkEmail(email);
            EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content.toString(), inlineImages);
            resultMessage = "The e-mail was sent successfully";
        }
        catch (Exception ex) {

            ex.printStackTrace();
            resultMessage = "There were an error: " + ex.getMessage();


        }finally {
            request.setAttribute("Message", resultMessage);

        }


        destpage = "/otp.jsp";

        RequestDispatcher dispatcher = request.getRequestDispatcher(destpage);
        dispatcher.forward(request, response);

        request.getSession(false);
    }








    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
