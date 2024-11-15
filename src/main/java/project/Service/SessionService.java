package project.Service;

import javax.servlet.http.HttpSession;



public class SessionService {
	 public static boolean checkSession(HttpSession session, String name) {
	        if (session != null && session.getAttribute(name) != null) {
	            return true;
	        } else {
	            System.out.println("Session attribute not found");
	            return false;
	        }
	    }
}
