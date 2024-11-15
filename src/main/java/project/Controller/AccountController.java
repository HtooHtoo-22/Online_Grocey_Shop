package project.Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.Model.CategoryBean;
import project.Model.LoginBean;
import project.Model.ProductBean;
import project.Model.UserBean;
import project.Repository.AccountRepo;
import project.Repository.ProductRepo;
import project.Service.BlankProfilePhoto;
import project.Service.SessionService;

@Controller
public class AccountController {

//======================================Register========================================================
	@GetMapping("/")
	public ModelAndView viewLogin() {
		return new ModelAndView("login","loginBean",new LoginBean());
	}
	
	
	@RequestMapping("/registration")
	public ModelAndView viewRegister() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("register");
		mv.addObject("user", new UserBean());
		return mv;
	}
	
	@PostMapping("/register")
	public String doRegister(@ModelAttribute("user")UserBean bean,Model model,HttpSession session) throws IOException {
		AccountRepo repo=new AccountRepo();
		boolean result=repo.checkUniqueEmail(bean.getEmail());
		if(result) {
			boolean phResult=repo.checkUniquePhone(bean.getPhone());
			if(phResult) {
				session.setAttribute("userProfile", bean);
				return "profilepicture";
			}else {
				model.addAttribute("EmailDuplicateError","This Phone Number with  account already exists");
				return "register";
			}
			
		}else {
			model.addAttribute("EmailDuplicateError","Email with this account already exists");
			return "register";
		}
		
	}
	@PostMapping("/changeProfile")
	public String changeProfile(@RequestParam("file")MultipartFile file,Model model) throws IOException {
		byte[]b=file.getBytes();
		String changePhoto=Base64.getEncoder().encodeToString(b);
		model.addAttribute("changePhoto", changePhoto);
		return "profilepicture";
	}
	
	@PostMapping("/createAccount")
	public String createAccount(HttpSession session,@RequestParam("photo")String photo,Model model) throws IOException {
		UserBean bean=(UserBean) session.getAttribute("userProfile");
		System.out.println(bean+" "+photo);
		byte[]photoByte=BlankProfilePhoto.chooseProfile(photo, bean.getGender());
		bean.setPhotoByte(photoByte);
		AccountRepo repo=new AccountRepo();
		repo.registerForUser(bean);
//		model.addAttribute("Name", bean.getName());
//		model.addAttribute("photo", bean.get64());
		session.invalidate();
		return "redirect:/";
	}
//=====================================Login==============================================================
	@PostMapping("/login")
	public String doLogin(@ModelAttribute("loginBean")LoginBean lBean,Model model,HttpSession session,RedirectAttributes redirectAttributes) {
		AccountRepo repo=new AccountRepo();
		boolean result=repo.checkEmail(lBean.getEmail());
		if(result) {
			UserBean uBean=repo.checkPassword(lBean.getEmail(),lBean.getPassword());
			if(uBean!=null) {
				session.setAttribute("userInfo", uBean);
				ProductRepo pRepo=new ProductRepo();
				List<CategoryBean> cList=pRepo.showAllCategory();
				if(cList!=null) {
					model.addAttribute("category", cList);
					redirectAttributes.addFlashAttribute("message", "Login SuccessFul");
				}
				return "redirect:myhome";
			}else {
				String adminRole=repo.adminCheckPassword(lBean.getEmail(), lBean.getPassword());
				System.out.println(adminRole);
				if(adminRole!=null) {
					if(adminRole.equals("System Admin")) {
						session.setAttribute("admin", "sa");
						String adminName=repo.adminGetName(lBean.getEmail());
						
						session.setAttribute("adminName",adminName );
						return "redirect:/admin";
					}else if(adminRole.equals("Admin")) {
						
						session.setAttribute("admin", "a");
						String adminName=repo.adminGetName(lBean.getEmail());
						
						session.setAttribute("adminName",adminName );
						return "redirect:/admin";
					}else {
						return null;
					}
					
				}else {
					model.addAttribute("WrongPassword","Incorrect Password!");
					return "login";
				}				
			}
		}else {
			model.addAttribute("EmailNotFound","Invalid Email!");
			return "login";
		}
	}
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	@GetMapping("/adminLogOut")
	public String adminLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
//==========================================My Profile====================================================
	@GetMapping("/myprofile")
	public String showProfile(Model model,HttpSession session) {
		 boolean isAuthenticated = SessionService.checkSession(session, "userInfo");
	        return isAuthenticated ? "myprofile" : "redirect:/";
	    // Return the view, the message will be available if set
	}

	
	@GetMapping("/myhome")
	public String goHome(Model model,HttpSession session) {
		ProductRepo repo=new ProductRepo();
		List<CategoryBean>categoryList=repo.showAllCategory();
		int categoriesPerPage = 3;
		 Map<CategoryBean, Integer> categoryPages = new HashMap<>();
		    for (int i = 0; i < categoryList.size(); i++) {
		        int pageNumber = (i / categoriesPerPage) + 1;
		        categoryPages.put(categoryList.get(i), pageNumber);
		    }
		//model.addAttribute("category", cList);
		List<ProductBean> popularList=repo.getPopularItems();
		popularList.sort((p1, p2) -> Integer.compare(p2.getPopularity(), p1.getPopularity()));
		model.addAttribute("popularList", popularList);
		boolean result=SessionService.checkSession(session,"userInfo");
		if(result) {
			model.addAttribute("categoryPages", categoryPages);
			return "index";
		}else {
			return "redirect:/";
		}
		
	}
	
	@PostMapping("/changeProfile1")
	public String changeProfile1(@RequestParam("file")MultipartFile file,HttpSession session) throws IOException {
		byte[]b=file.getBytes();
		UserBean uBean=(UserBean)session.getAttribute("userInfo");
		AccountRepo repo=new AccountRepo();
		int i=repo.changeProfilePicture(b, uBean.getId());
		if(i>0) {
			uBean.setPhotoByte(b);
			session.setAttribute("userInfo", uBean);
			return "redirect:myprofile";
		}else {
			System.out.println("Cannot change profile");
			return null;
		}
		
	}
	
	@PostMapping("/home")
	public String returnHome(@RequestParam("name")String name,HttpSession session) {
		if(name!=null) {
			UserBean uBean=(UserBean)session.getAttribute("userInfo");
			AccountRepo repo=new AccountRepo();
			int i=repo.changeName(name, uBean.getId());
			if(i>0) {
				uBean.setName(name);
				session.setAttribute("userInfo", uBean);
				return "redirect:myhome";
			}else {
				System.out.println("Changing Name Error ");
				return null;
			}
		}else {
			return "home";
		}
		
		
	}
	
	@PostMapping("/changePassword")
	public String filloldPassword(HttpSession session) {
		 boolean isAuthenticated = SessionService.checkSession(session, "userInfo");
	        return isAuthenticated ? "filloldpassword" : "redirect:/";
		
	}
	
	@PostMapping("/checkpassword")
	public String checkPassword(@RequestParam("oldPassword123")String password,@RequestParam("email")String email,Model model,HttpSession session) {
		AccountRepo repo=new AccountRepo();
		UserBean bean=repo.checkPassword(email, password);
		if(bean!=null) {
			 boolean isAuthenticated = SessionService.checkSession(session, "userInfo");
		        return isAuthenticated ? "fillnewpassword" : "redirect:/";
			
		}else {
			model.addAttribute("wrongpassword", "Wrong Password");
			boolean isAuthenticated = SessionService.checkSession(session, "userInfo");
	        return isAuthenticated ? "filloldpassword" : "redirect:/";
			
		}
		
	}
	@PostMapping("/changenewpassword")
	public String changeNewPassword(@RequestParam("password") String newpassword, 
	                                 HttpSession session, 
	                                 RedirectAttributes redirectAttributes) {
	    UserBean uBean = (UserBean) session.getAttribute("userInfo");
	    AccountRepo repo = new AccountRepo();
	    int i = repo.changePassword(newpassword, uBean.getId());
	    if (i > 0) {
	        uBean.setPassword(newpassword);
	        session.setAttribute("userInfo", uBean);
	        redirectAttributes.addFlashAttribute("message", "Password changed successfully!"); // Set flash attribute
	        return "redirect:myprofile"; // Redirect to myprofile
	    } else {
	        System.out.println("Changing Password Error");
	        // Optionally, you could add an error message or handle the error differently
	        return null; // Or handle the error appropriately
	    }
	}

//=============================================ProductList========================================
	//@GetMapping("/productlist")
	//public String goProductList(HttpSession session,HttpServletRequest request) {
		//List<CategoryBean> cList=(List<CategoryBean>) session.getAttribute("category");
		//session.setAttribute("category", cList);
//		ProductRepo pRepo=new ProductRepo();
//		List<Integer> idList=pRepo.showAllCategoryId();
//		session.setAttribute("IdList", idList);
	//	return "productlist1";
//	}
	@GetMapping("/productlist")
    public String showCategories(@RequestParam(defaultValue = "1") int pageNumber,Model model,HttpSession session) {
		ProductRepo pRepo=new ProductRepo();
		int categoriesPerPage = 3;
		List<CategoryBean> categories = pRepo.showPaginatedCategories(pageNumber, categoriesPerPage);
        Map<Integer, List<ProductBean>> productsByCategory = new HashMap<>();
        int totalPages=pRepo.getTotalPages();
        if (pageNumber < 1) {
            pageNumber = 1; // Reset to the first page if the page number is less than 1
        } else if (pageNumber > totalPages && totalPages > 0) {
            pageNumber = totalPages; // Reset to the last page if the page number exceeds total pages
        }

        
        for (CategoryBean category : categories) {
            List<ProductBean> products = pRepo.showAllProductByCategoryId(category.getId());
            productsByCategory.put(category.getId(), products);
            System.out.println(products);
        }
        
        model.addAttribute("categories", categories);
        model.addAttribute("productsByCategory", productsByCategory);
        model.addAttribute("pageNumber", pageNumber);
        model.addAttribute("totalPages", totalPages);
       
        model.addAttribute("hasPrevious", pageNumber > 1);
        model.addAttribute("hasNext", pageNumber < totalPages);
        boolean isAuthenticated = SessionService.checkSession(session, "userInfo");
        return isAuthenticated ? "productlist" : "redirect:/";
    }
	
}
