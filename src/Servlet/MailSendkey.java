package Servlet;




import imple.imple;

import inter.inter;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbcon.dbconn;

import Bean.MailBean;

import Bean.voterbean;

 

@WebServlet("/MailSendkey")
public class MailSendkey extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public MailSendkey() {
        super();
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String otp=request.getParameter("otp");
		String to=request.getParameter("pid");
		
		
		HttpSession sess=request.getSession();
		sess.setAttribute("pid", to);


		try{
			Connection con=dbconn.create();
			Statement st=con.createStatement();
			st.executeUpdate("UPDATE vote.voterreg set otp='"+otp+"' where email='"+to+"' ");
			
		}
		catch(Exception e){
		
		System.out.println(e);
		}
		
		
		
			
			
			
			PrintWriter out=response.getWriter();
			 
			voterbean ur=new voterbean();
			ur.setEmail(to);;
			
			ur.setOtp(otp);;
			
			inter pm= new imple ();
			boolean ch=pm.ch(ur);
			
				if(ch=true){
					
				
					String subject="Welcome From public Cloud storage";
					String from ="ytpride4@gmail.com";
					String[] mail_list={to};
					String body="your key is "+otp;
					String pass="pride6789";
					
					MailBean.sendFromGMail(from, pass, mail_list, subject, body);
				
					
				 
					RequestDispatcher rd=request.getRequestDispatcher("voterlogin.jsp?email="+to);  
			        rd.include(request, response); 
					    
				}
				else{
					out.println("<body style='background-color:lavender;'>");
					out.println("<html><body><script>alert('key not send Successfully!user not give original mail id' );</script></body></html>");
				 
					RequestDispatcher rd=request.getRequestDispatcher("Error.jsp?email="+to);  
			        rd.include(request, response);
				}

		   
	}

}
