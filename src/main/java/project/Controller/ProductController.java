package project.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.Model.CategoryBean;
import project.Model.PaymentMethod;
import project.Model.ProductBean;
import project.Model.UserBean;
import project.Repository.PaymentMethodRepository;
import project.Repository.ProductRepo;
import project.Service.SessionService;

@Controller

public class ProductController {
	
	@Autowired
	private ProductRepo productRepo;
	
	@GetMapping("/cart")
	public String showCart(Model model,HttpSession session) {
		
		boolean result=SessionService.checkSession(session, "userInfo");
		if(result) {
			return "cart";
		}else {
			return "redirect:/";
		}
	    
	}
	@PostMapping("/updateFavorites/{productId}")
	public ResponseEntity<String> updateFavorite(@PathVariable int productId, HttpSession session) {
		
	    // Check if the user is logged in by retrieving the UserBean from the session
		//ProductRepo productRepo=new ProductRepo();
	    UserBean uBean = (UserBean) session.getAttribute("userInfo");
	    //int productId=Integer.parseInt(productid);
	    System.out.println(productId);
	    if (uBean == null) {
	        // Return HTTP 401 Unauthorized if the user is not logged in
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not logged in");
	    }

	    // Get the user's ID from the UserBean
	    int userId = uBean.getId();

	    try {
	    	
	        // Inject the ProductRepo via Spring's @Autowired (avoid manual instantiation)
	        int result = productRepo.updateFavourite(productId, userId);  // Assuming it's autowired
	        
	        if (result == 1) {
	            // Successfully added to favorites (HTTP 201 Created)
	            return ResponseEntity.status(HttpStatus.CREATED).body("Added to favorites");
	        } else if (result == 0) {
	            // Successfully removed from favorites (HTTP 200 OK)
	            return ResponseEntity.ok("Removed from favorites");
	        } else {
	            // Return an appropriate response if there's an unexpected result
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Unable to update favorite status");
	        }
	    } catch (Exception e) {
	        // Log the exception and return HTTP 500
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred while updating favorites");
	    }
	}
	@GetMapping("/favourite")
	public String showFav(HttpSession session,Model model) {
		UserBean userBean=(UserBean) session.getAttribute("userInfo");
		int userId=userBean.getId();
		List<ProductBean> favList=productRepo.showFavProducts(userId);
		model.addAttribute("favoriteList", favList);
		System.out.println(userId);
		System.out.println(favList);
		boolean result=SessionService.checkSession(session, "userInfo");
		if(result) {
			return "favorite";
		}else {
			return "redirect:/";
		}
		
	}
	
	@GetMapping("/unfavorite")
	public String unFav(@RequestParam("id")int productId,HttpSession session) {
		UserBean userBean=(UserBean) session.getAttribute("userInfo");
		int userId=userBean.getId();
		System.out.println(productId+" "+userId);
		int i=productRepo.unFavorite(productId, userId);
		if(i>0) {
			return "redirect:favourite";
		}
		return "fail";
	}
	@GetMapping("/search")
	public String showSearchProduct(@RequestParam("search")String searchWords,Model model,HttpSession session) {
		List<ProductBean> searchList=productRepo.searchProducts(searchWords);
			model.addAttribute("SearchedProducts", searchList);
			boolean result=SessionService.checkSession(session, "userInfo");
			if(result) {
				model.addAttribute("SearchedWords", searchWords);
				return "search";
			}else {
				return "redirect:/";
			}
	}
	@GetMapping("/category")
	public String goCategory( Model model,HttpSession session) {
		List<CategoryBean> categoryList=productRepo.showAllCategory();
		int categoriesPerPage = 3;
		 Map<CategoryBean, Integer> categoryPages = new HashMap<>();
		    for (int i = 0; i < categoryList.size(); i++) {
		        int pageNumber = (i / categoriesPerPage) + 1;
		        categoryPages.put(categoryList.get(i), pageNumber);
		    }
		boolean result=SessionService.checkSession(session, "userInfo");
		if(result) {
			
			model.addAttribute("categoryPages", categoryPages);
			return "userCategory";
		}else {
			return "redirect:/";
		}
		
	}
	
	@GetMapping("/checkout")
	public String go_order(HttpSession session,Model model) {
		UserBean uBean = (UserBean) session.getAttribute("userInfo");
		model.addAttribute("userInfo", uBean);
		PaymentMethodRepository paymentRepo=new PaymentMethodRepository();
		List<PaymentMethod> paymentList=paymentRepo.getAllPaymentMethod();
		model.addAttribute("paymentList", paymentList);
		boolean result=SessionService.checkSession(session, "userInfo");
		if(result) {
			
			return "checkout";
		}else {
			return "redirect:/";
		}
		
	}
}
