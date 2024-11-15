package project.Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.Model.AdminBean;
import project.Model.CategoryBean;
import project.Model.CreateAdminBean;
import project.Model.DashboardCounts;
import project.Model.Payment;
import project.Model.PaymentMethod;
import project.Model.ProductBean;
import project.Model.UserBean2;
import project.Repository.AdminRepository;
import project.Repository.CategoryRepo;
import project.Repository.PaymentMethodRepository;
import project.Repository.PaymentRepository;
import project.Repository.ProductRepository;
import project.Repository.UserRepository;
import project.Service.SessionService;



@Controller
public class SystemAdminController {
	 private final ProductRepository productRepository = new ProductRepository();
	    private final CategoryRepo categoryRepository = new CategoryRepo();
	    private final UserRepository userRepository = new UserRepository();
	    private final PaymentRepository paymentRepository = new PaymentRepository();
	    private final AdminRepository adminRepo=new AdminRepository();
	    private final PaymentMethodRepository paymentMethodRepo=new PaymentMethodRepository();

	    @GetMapping("/admin")
	    public String showDashboard(Model model,HttpSession session) {
	        DashboardCounts counts = new DashboardCounts();
	        counts.setProductCount(productRepository.count());
	        counts.setCategoryCount(categoryRepository.count());
	        counts.setCustomerCount(userRepository.countActiveUsers());
	        counts.setOrderCount(paymentRepository.count());
	        
	        List<ProductBean> topProducts = productRepository.getTopSellingProducts(5);
	        String adminName=(String) session.getAttribute("adminName");
	        model.addAttribute("adminName", adminName);
	        model.addAttribute("topProducts", topProducts);
	        model.addAttribute("productCount", counts.getProductCount());
	        model.addAttribute("categoryCount", counts.getCategoryCount());
	        model.addAttribute("customerCount", counts.getCustomerCount());
	        model.addAttribute("orderCount", counts.getOrderCount());
	        counts.setPendingOrderCount(paymentRepository.pendingCount());
	        model.addAttribute("pendingCount", counts.getPendingOrderCount());
	        System.out.println(counts.getPendingOrderCount());
	        boolean isAuthenticated = SessionService.checkSession(session, "admin");
	        return isAuthenticated ? "admin" : "redirect:/";
	       // Ensure your view file is named admin.jsp
	    }
	    @GetMapping("/sales-data-weekdays")
	    public ResponseEntity<Map<String, Object>> getSalesDataByWeekday() {
	        Map<String, Double> salesData = paymentRepository.getSalesDataByWeekday();
	        
	        List<String> labels = new ArrayList<>(salesData.keySet());
	        List<Double> values = new ArrayList<>(salesData.values());
	        
	        Map<String, Object> response = new HashMap<>();
	        response.put("labels", labels);
	        response.put("data", values);
	        
	        return ResponseEntity.ok(response);
	    }
	    @GetMapping("/adminProductList")
	    public String getAdminProductList(Model model, HttpSession session,
	                                      @RequestParam(value = "page", defaultValue = "0") int page) {
	        List<ProductBean> products = productRepository.getAllProducts();
	        
	        // Sort products by popularity
	        products.sort((p1, p2) -> Integer.compare(p2.getPopularity(), p1.getPopularity()));
	        
	        int pageSize = 5; // Number of products per page
	        int totalProducts = products.size();
	        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
	        
	        // Get sublist for the current page
	        int fromIndex = page * pageSize;
	        List<ProductBean> paginatedProducts = products.stream()
	            .skip(fromIndex)
	            .limit(pageSize)
	            .collect(Collectors.toList());
	        
	        // Pass the paginated products directly to the model
	        model.addAttribute("products", paginatedProducts);
	        model.addAttribute("categories", categoryRepository.getAllCategories());
	        model.addAttribute("currentPage", page);
	        model.addAttribute("totalPages", totalPages);
	        int pendingCounts=paymentRepository.pendingCount();
	        model.addAttribute("pendingCount", pendingCounts);
	        boolean isAuthenticated = SessionService.checkSession(session, "admin");
	        return isAuthenticated ? "adminProductList" : "redirect:/";
	      
	    }
	    @GetMapping("/adminSearch")
	    public String searchProducts(@RequestParam("query") String query,
	                                 @RequestParam(value = "categoryId", required = false) Integer categoryId,
	                                 Model model) {

	        System.out.println("Search Query: " + query);
	        System.out.println("Category ID: " + categoryId);

	        // Perform the search
	        List<ProductBean> searchResults = productRepository.searchProducts(query, categoryId);

	        // Create a temporary category for search results
	        CategoryBean searchCategory = new CategoryBean();
	        searchCategory.setName("Search Results");

	        // Check the search results
	        System.out.println("Number of search results: " + searchResults.size());

	        // Prepare the map for the view
	        Map<CategoryBean, List<ProductBean>> productsByCategory = Map.of(searchCategory, searchResults);
	        
	        // Add attributes to the model
	        model.addAttribute("productsByCategory", productsByCategory);
	        model.addAttribute("searchQuery", query);
	        model.addAttribute("categoryId", categoryId);
	        model.addAttribute("showCreateProduct", categoryId != null);
	        model.addAttribute("showRestoreProduct", categoryId != null);

	        return "viewProducts"; // Redirect to viewProducts.jsp
	    }
	    @GetMapping("/allorder")
	    public String getAllOrders(Model model,HttpSession session) {
	        Map<String, List<Payment>> groupedOrders = paymentRepository.getAllOrdersGroupedByStatus();
	        System.out.println(groupedOrders);
	        model.addAttribute("groupedOrders", groupedOrders);
	        boolean isAuthenticated = SessionService.checkSession(session, "admin");
	        return isAuthenticated ? "orders" : "redirect:/";
	       
	    }
	    
	    @PostMapping("/approve/{id}")
	    public String approveOrder(@PathVariable int id) {
	        paymentRepository.approvedOrderByid(id);
	        paymentRepository.substractQuantityAndIncreasePopularity(id);
	        return "redirect:/allorder"; 
	    }

	    @PostMapping("/cancel/{id}")
	    public String cancelOrder(@PathVariable int id) {
	        paymentRepository.softDeleteById(id);
	        return "redirect:/allorder";
	    }
	    @GetMapping("/editOrder/{id}")
		public String showEditOrderForm(@PathVariable ("id")int id,Model model) {	
			Payment order=paymentRepository.getAllOrdersById(id);
			if(order==null) {
				model.addAttribute("error","Orders not found");
				return"all";
			}
			model.addAttribute("order",order);
			return "editOrder";
		}
	    @PostMapping("updateOrder/{orderId}")
		public String updateOrder(@PathVariable ("orderId") int orderId,
													@ModelAttribute ("order")Payment order,
													Model model){
			order.setOrderId(orderId);
			paymentRepository.updateOrders(order);
			return "redirect:/allorder";
		}
	    @GetMapping("/deleteOrder/{id}")
		public String deletepayment(@PathVariable ("id")int id,Model model) {	
			int result=paymentRepository.deletePayment(id);
			if(result>0) {
				model.addAttribute("error","Orders not found");
				return"redirect:/allorder";
			}
			return null;
		}
	    @GetMapping("/viewOrderDetails/{id}")
	    @ResponseBody
	    public Map<String, Object> viewOrderDetails(@PathVariable("id") int id) {
	        Map<String, Object> response = new HashMap<>();
	        Payment order = paymentRepository.getAllOrdersById(id);  

	        if (order != null) {
	            List<Payment> orderItems = paymentRepository.getAllOrderItems(order.getOrderId());  
	            String transactionImageBase64 = order.getBase64(); 
	            response.put("order", order);
	            response.put("orderItems", orderItems);
	            response.put("transactionImageBase64", transactionImageBase64);

	            System.out.println("Order Items: " + orderItems); 
	        } else {
	            response.put("error", "Order not found.");
	        }
	        return response;
	    }
	    @GetMapping("/deletingOrder/{id}")
	    public String deleteOrder(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
	    	System.out.println("Hello "+id);
	    	Payment order=new Payment();
	     order.setId(id);
	        int result = paymentRepository.deletingOrders(order);
	        if (result > 0) {
	            redirectAttributes.addFlashAttribute("message", "order deleted successfully.");
	        } else {
	            redirectAttributes.addFlashAttribute("error", "No order found with that ID.");
	        }
	        return "redirect:/allorder";
	    }
////////////////////////Users////////////////////////////////////////////////////
	    @GetMapping("/users")
	    public String listUsers(Model model,HttpSession session) {
	        UserRepository userRepo = new UserRepository();
	        List<UserBean2> users = userRepo.getAllUsers();
	        model.addAttribute("users", users);
	        boolean isAuthenticated = SessionService.checkSession(session, "admin");
	        int pendingCounts=paymentRepository.pendingCount();
	        model.addAttribute("pendingCount", pendingCounts);
	        return isAuthenticated ? "userList" : "redirect:/";
	        
	    }
	   
	    // Show the edit user form
	    @GetMapping("/edituser/{id}")
	    public String showEditUserForm(@PathVariable("id") int id, Model model,HttpSession session) {
	        UserRepository repo = new UserRepository();
	        UserBean2 user = repo.getUserById(id);
	        model.addAttribute("user", user);
	        boolean isAuthenticated = SessionService.checkSession(session, "admin");
	        return isAuthenticated ? "edituser" : "redirect:/";
	       
	    }

	    // Update user information
	    @PostMapping("/updateUser")
	    public String updateUser(@ModelAttribute("user") UserBean2 user) {
	        UserRepository repo = new UserRepository();
	        repo.updateUser(user);
	        return "redirect:/users"; 
	    }

	    // Soft delete a user
	    @GetMapping("/deleteuser/{id}")
	    public String deleteUser(@PathVariable("id") int id) {
	        UserRepository repo = new UserRepository();
	        repo.deleteUser(id);
	        return "redirect:/users"; // Changed to redirect to the correct endpoint
	    }

	    // Restore a deleted user
	    @GetMapping("/restoreuser/{id}") 
	    public String restoreUser(@PathVariable("id") int id) {
	        UserRepository repo = new UserRepository();
	        repo.restoreUser(id);
	        return "redirect:/deletedUsers"; // Redirect to the deleted users list
	    }

	    // List all deleted users
	    @GetMapping("/deletedUsers") 
	    public String listDeletedUsers(Model model,HttpSession session) {
	        UserRepository repo = new UserRepository();
	        List<UserBean2> deletedUsers = repo.getDeletedUsers(); 
	        model.addAttribute("deletedUsers", deletedUsers);
	        boolean isAuthenticated = SessionService.checkSession(session, "admin");
	        return isAuthenticated ? "restoreUser" : "redirect:/";
	        
	    }
	    //========================Admin Management======================================
	    @GetMapping("/admins")
	    public String listAdmins(Model model,HttpSession session) {
	        List<AdminBean> admins = adminRepo.getAllAdmins();
	        model.addAttribute("admins", admins);
	        boolean isAuthenticated = SessionService.checkSession(session, "admin");
	        int pendingCounts=paymentRepository.pendingCount();
	        model.addAttribute("pendingCount", pendingCounts);
	        return isAuthenticated ? "adminList" : "redirect:/";
	       
	    }
	    @GetMapping("/editadmin/{id}")
	    public String editAdmin(@PathVariable("id") int id, Model model,HttpSession session) {
	        AdminBean admin = adminRepo.getAdminById(id); 
	        model.addAttribute("admin", admin);
	        boolean isAuthenticated = SessionService.checkSession(session, "admin");
	        return isAuthenticated ? "editadmin" : "redirect:/";
	        
	    }
	    @PostMapping("/updateAdmin")
	    public String updateAdmin(@ModelAttribute("admin") AdminBean admin) {
	        adminRepo.updateAdmin(admin);
	        return "redirect:/admins";  
	    }
	    @GetMapping("/deleteadmin/{id}")
	    public String deleteAdmin(@PathVariable("id") int id) {
	        adminRepo.deleteAdmin(id);
	        return "redirect:/admins";
	    }
	    @GetMapping("/deletedadmin")
	    public String listDeletedAdmins(Model model,HttpSession session) {
	        List<AdminBean> deletedAdmins = adminRepo.getDeletedAdmins();
	        model.addAttribute("deletedAdmins", deletedAdmins);
	        boolean isAuthenticated = SessionService.checkSession(session, "admin");
	        return isAuthenticated ? "adminrestore" : "redirect:/";
	        
	    }
	    @GetMapping("/restoreadmin/{id}") 
	    public String restoreAdmin(@PathVariable("id") int id) {
	        adminRepo.restoreAdmin(id);
	        return "redirect:/admins"; 
	    }
	    @RequestMapping(value="/createadminregister",method = RequestMethod.GET)
	    public ModelAndView showRegister(Model model) {
	      CreateAdminBean bean = new CreateAdminBean();
	      return new ModelAndView("createadminregister","admin",bean);
	    }
	    @PostMapping("/save")
	    public String saveAdmin(@ModelAttribute("admin") CreateAdminBean admin, Model m) {
	        boolean checkUserEmail=adminRepo.checkUserUniqueEmail(admin.getEmail());
	        boolean checkAdminEmail=adminRepo.checkAdminUniqueEmail(admin.getEmail());
	        if(checkUserEmail&&checkAdminEmail) {
	        	boolean checkName=adminRepo.checkUniqueName(admin.getName());
	        	if(checkName) {
	        		int i = adminRepo.saveAdmin(admin);
	    	        if (i > 0) {
	    	            return "redirect:/admins"; 
	    	        } else {
	    	            m.addAttribute("error", "Insert Failed");
	    	            return "createadminregister"; 
	    	        }
	        	}else {
	        		m.addAttribute("error", "Name is already in use. Please use a different name.");
		        	 return "createadminregister"; 
	        	}
	        	
	        }else {
	        	 m.addAttribute("error", "Email is already in use. Please use a different email.");
	        	 return "createadminregister"; 
	        }
	        
	    }
	    //====================Payment Method=================================
	    @GetMapping("/paymentMethodList")
		public String getAllPaymentMethod(Model model,HttpSession session) {
			List<PaymentMethod> payment_method_names=paymentMethodRepo.getAllPaymentMethod();
			
			model.addAttribute("payment_method_names",payment_method_names);
			int pendingCounts=paymentRepository.pendingCount();
	        model.addAttribute("pendingCount", pendingCounts);
			 boolean isAuthenticated = SessionService.checkSession(session, "admin");
		        return isAuthenticated ? "paymentMethodList" : "redirect:/";
			
		}
	    @GetMapping("/showCreatePaymentMethod")
		public String showCreatePaymentMethod(Model model,HttpSession session) {
			model.addAttribute("paymentMethod",new PaymentMethod());
			 boolean isAuthenticated = SessionService.checkSession(session, "admin");
		        return isAuthenticated ? "createPaymentMethod" : "redirect:/";
			
		}
	    @PostMapping("createPaymentMethod")
		public String createPaymentMethod(
										@RequestParam("payment_method_name") String payment_method_name,
										@RequestParam("file") MultipartFile file,
										@RequestParam("logoFile") MultipartFile logoFile,
										RedirectAttributes redirectAttributes,
										Model model) {
			
			PaymentMethod paymentMethod=new PaymentMethod();
			if(file.isEmpty()) {
				model.addAttribute("error", "Please upload a QR code file.");
		            model.addAttribute("paymentMethod", paymentMethod);
		            return "createPaymentMethod";
			}
			
			try {
				paymentMethod.setQr_code(file.getBytes());
			} catch (IOException e) {
				 model.addAttribute("error", "Failed to upload QR code:  " + e.getMessage());
				 model.addAttribute("paymentMethod", paymentMethod);
		         return "createPaymentMethod";
			}
			
			if(logoFile.isEmpty()) {
				model.addAttribute("error", "Please upload a logo.");
		            model.addAttribute("paymentMethod", paymentMethod);
		            return "createPaymentMethod";
			}
			
			try {
				paymentMethod.setLogo(logoFile.getBytes());
			} catch (IOException e) {
				 model.addAttribute("error", "Failed to upload logo:  " + e.getMessage());
				 model.addAttribute("paymentMethod", paymentMethod);
		         return "createPaymentMethod";
			}
			
			paymentMethod.setPayment_method_name(payment_method_name);
			if(paymentMethodRepo.paymentMethodExistName(payment_method_name)) {
				model.addAttribute("error","paymentmethod with the same name already exists.");
				model.addAttribute("paymentMethod", paymentMethod);
				return "createPaymentMethod";
			}
			if(paymentMethodRepo.createPaymentMethod(paymentMethod)>0) {
				redirectAttributes.addFlashAttribute("message","Paymentmethod created successfully.");
				return "redirect:/paymentMethodList"; 
			}else {
				model.addAttribute("error","Failed to create paymentmethod .");
				model.addAttribute("paymentMethod", paymentMethod);
				return "createPaymentMethod";
			}
		}
	    @GetMapping("/editPayment/{id}")
		public String showEditPaymentMethodForm(@PathVariable("id") int id, Model model,HttpSession session) {
		    PaymentMethod paymentMethod = paymentMethodRepo.getById(id);
		    if (paymentMethod == null) {
		        model.addAttribute("error", "Payment Method not found.");
		        
		        return "paymentMethodList";
		    }
		    model.addAttribute("paymentMethod", paymentMethod);
		    boolean isAuthenticated = SessionService.checkSession(session, "admin");
	        return isAuthenticated ? "editPaymentMethod" : "redirect:/";
		   
		}
		@PostMapping("/updatePayment/{id}")
		public String updatePaymentMethod(@PathVariable("id") int id,
		                                  @ModelAttribute("paymentMethod") PaymentMethod paymentMethod,
		                                  @RequestParam("file") MultipartFile file,
		                                  @RequestParam("logoFile") MultipartFile logoFile,
		                                  Model model) throws IOException {
		   
		    PaymentMethod existingPaymentMethod = paymentMethodRepo.getById(id);
		    if (existingPaymentMethod == null) {
		        model.addAttribute("error", "Payment Method not found.");
		        return "paymentMethodList";
		    }
		    	    if (!existingPaymentMethod.getPayment_method_name().equals(paymentMethod.getPayment_method_name()) &&
		        paymentMethodRepo.paymentMethodExistName(paymentMethod.getPayment_method_name())) {
		        model.addAttribute("error", "Payment method with this name already exists.");
		        return "editPaymentMethod";
		    	    }
		  
		    if (!file.isEmpty()) {
		        try {
		            paymentMethod.setQr_code(file.getBytes());
		            paymentMethod.setLogo(file.getBytes());
		        } catch (IOException e) {
		            model.addAttribute("error", "Error while uploading QR code.");
		            return "editPaymentMethod"; // Return to the edit form
		        }
		    }else {
		    	paymentMethod.setQr_code((existingPaymentMethod.getQr_code()));
		    	paymentMethod.setLogo(existingPaymentMethod.getLogo());
	        }
		    
		    if (!logoFile.isEmpty()) {
		        try {
		            paymentMethod.setLogo(logoFile.getBytes());
		        } catch (IOException e) {
		            model.addAttribute("error", "Error while uploading logo.");
		            return "editPaymentMethod"; // Return to the edit form
		        }
		    }else {
		    	paymentMethod.setQr_code((existingPaymentMethod.getQr_code()));
	        }
		    
		    
		    
//		    byte[]qr=file.getBytes();
//    byte[]logo=logoFile.getBytes();
//		    paymentMethod.setQr_code(qr);
//		    paymentMethod.setLogo(logo);
		    System.out.println(paymentMethod.getPayment_method_name());
		    paymentMethod.setId(id);
		    paymentMethodRepo.updatePaymentMethod(paymentMethod);
		    return "redirect:/paymentMethodList"; 
		}
		
		
		@GetMapping("/deletedPaymentMethods")
		public String showDeletedPaymentMethods(Model model,HttpSession session) {
		    List<PaymentMethod> deletedPaymentMethods = paymentMethodRepo.getDeletedPaymentMethods();
		    model.addAttribute("deletedPaymentMethods", deletedPaymentMethods);
		    boolean isAuthenticated = SessionService.checkSession(session, "admin");
	        return isAuthenticated ? "deletedPaymentMethods" : "redirect:/";
			
		}
		@GetMapping("/deletePayment/{id}")
	    public String softDeletePaymentMethod(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
		 paymentMethodRepo.softDeleteById(id);
	     redirectAttributes.addFlashAttribute("message", "Paymentmethod deleted (soft) successfully.");
	    return "redirect:/paymentMethodList";
	    }
		@GetMapping("/restorePayment/{id}")
	    public String restorePaymentMethod(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
		 PaymentMethod paymentMethod = paymentMethodRepo.getById(id);
		 if (paymentMethod == null || paymentMethod.getStatus() == 1) {
		        redirectAttributes.addFlashAttribute("error", "PaymentMethod not found or already active.");
		        return "redirect:/deletedPaymentMethods";
		    }
		 	paymentMethodRepo.restoreById(id);
	        redirectAttributes.addFlashAttribute("message", "PaymentMethod restored successfully.");
	        return "redirect:/deletedPaymentMethods";
	    }
}	
