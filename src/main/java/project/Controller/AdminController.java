package project.Controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import project.Model.CategoryBean;
import project.Model.DetailBean;
import project.Model.ProductBean;
import project.Repository.AdminProductRepo;
import project.Repository.CategoryRepo;
import project.Repository.DetailRepository;
import project.Repository.PaymentRepository;
import project.Repository.ProductRepository;
import project.Service.SessionService;

@Controller
public class AdminController {
	
	@Autowired
	private CategoryRepo categoryRepository;
	
	@Autowired
	private ProductRepository productRepository;
	
	@Autowired
	private DetailRepository detailRepository;
	
	@Autowired
	private PaymentRepository paymentRepository;
	
	@GetMapping("/showAddCategory")
    public String showAddCategoryForm(Model model,HttpSession session) {
        model.addAttribute("category", new CategoryBean());
        boolean isAuthenticated = SessionService.checkSession(session, "admin");
        return isAuthenticated ? "addCategory" : "redirect:/";
       
    }
	@PostMapping("/addCategory")
    public String addCategory(
            @RequestParam("name") String name,
            @RequestParam("file") MultipartFile file,
            RedirectAttributes redirectAttributes,
            Model model) {

        CategoryBean category = new CategoryBean();
        category.setName(name);

        if (file.isEmpty()) {
            model.addAttribute("error", "Please upload a file.");
            model.addAttribute("category", category);
            return "addCategory";
        }

        try {
            category.setPhotoByte(file.getBytes());
        } catch (IOException e) {
            model.addAttribute("error", "Failed to upload photo: " + e.getMessage());
            model.addAttribute("category", category);
            return "addCategory";
        }
        
        if (categoryRepository.categoryExistName(category.getName())) {
            model.addAttribute("error", "Category with the same name already exists.");
            model.addAttribute("category", category); 
            return "addCategory";
        }

        int result = categoryRepository.addCategory(category);
        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "Category added successfully.");
            return "redirect:categoryList"; 
        } else {
            model.addAttribute("error", "Failed to add category.");
            model.addAttribute("category", category); 
            return "addCategory"; 
        }
    }
	@GetMapping("/categoryList")
    public String getAllCategories(Model model,HttpSession session) {
        List<CategoryBean> categories = categoryRepository.getAllCategories();
        categories.sort((p1, p2) -> Integer.compare(p2.getId(), p1.getId()));
        model.addAttribute("categories", categories);
        boolean isAuthenticated = SessionService.checkSession(session, "admin");
        int pendingCounts=paymentRepository.pendingCount();
        model.addAttribute("pendingCount", pendingCounts);
        return isAuthenticated ? "categoryList" : "redirect:/";
        
    }
	@GetMapping("/edit/{id}")
    public String showEditCategoryForm(@PathVariable("id") int id, Model model,HttpSession session) {
        CategoryBean category = categoryRepository.findById(id);
        if (category == null) {
            model.addAttribute("error", "Category not found.");
            return "categoryList";
        }
        model.addAttribute("category", category);
        boolean isAuthenticated = SessionService.checkSession(session, "admin");
        return isAuthenticated ? "editCategory" : "redirect:/";
       
    }

    @PostMapping("/update/{id}")
    public String updateCategory(@PathVariable("id") int id,
                                 @ModelAttribute("category") CategoryBean category,
                                 @RequestParam("file") MultipartFile file, // Added for file upload
                                 Model model) {
        CategoryBean existingCategory = categoryRepository.findById(id);

       
        if (!existingCategory.getName().equals(category.getName()) && categoryRepository.categoryExistName(category.getName())) {
            model.addAttribute("error", "Category with this name already exists.");
            return "editCategory";
        }

        
        if (!file.isEmpty()) {
            try {
                category.setPhotoByte(file.getBytes()); 
            } catch (IOException e) {
                model.addAttribute("error", "Error while uploading the file.");
                return "editCategory";
            }
        } else {
            category.setPhotoByte(existingCategory.getPhotoByte());
        }

        
        category.setId(id);
        categoryRepository.updateCategory(category);

        return "redirect:/categoryList";
    }

    @GetMapping("/deletedCategories")
    public String getDeletedCategories(Model model,HttpSession session) {
        List<CategoryBean> deletedCategories = categoryRepository.getDeletedCategories();
        model.addAttribute("deletedCategories", deletedCategories);
      boolean isAuthenticated = SessionService.checkSession(session, "admin");
        return isAuthenticated ? "deletedCategories" : "redirect:/";
       
    }

    // Soft delete category by setting status to 0
    @GetMapping("/delete/{id}")
    public String softDeleteCategory(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        categoryRepository.softDeleteById(id);
        redirectAttributes.addFlashAttribute("message", "Category deleted (soft) successfully.");
        return "redirect:/categoryList";
    }

    // Restore category by setting status back to 1
    @GetMapping("/restore/{id}")
    public String restoreCategory(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        categoryRepository.restoreById(id);
        redirectAttributes.addFlashAttribute("message", "Category restored successfully.");
        return "redirect:/deletedCategories";
    }
	
//===================ProductController==============================
    @GetMapping("/viewProducts/{categoryId}")
    public String showProductsByCategory(@PathVariable("categoryId") int categoryId, Model model,HttpSession session) {
        List<ProductBean> products = productRepository.findByCategoryId(categoryId);
        CategoryBean category = categoryRepository.findById(categoryId);
        products.sort((p1, p2) -> Integer.compare(p2.getPopularity(), p1.getPopularity()));

        model.addAttribute("productsByCategory", Map.of(category, products));
       
        model.addAttribute("category", category);
        boolean isAuthenticated = SessionService.checkSession(session, "admin");
        return isAuthenticated ? "viewProducts" : "redirect:/";
        
    }

    
    @GetMapping("/showCreateProductForm/{categoryId}")
    public String showCreateProductForm(@PathVariable("categoryId") int categoryId, Model model,HttpSession session) {
        ProductBean product = new ProductBean();
        CategoryBean category = categoryRepository.findById(categoryId);
        product.setCategory(category);
        model.addAttribute("product", product);
        model.addAttribute("category", category);
        boolean isAuthenticated = SessionService.checkSession(session, "admin");
        return isAuthenticated ? "createProduct" : "redirect:/";
        
    }
    
    @PostMapping("/createProduct")
    public String createProduct(@Validated @ModelAttribute("product") ProductBean product,
                                BindingResult bindingResult,
                                @RequestParam("file") MultipartFile file,
                                Model model,
                                RedirectAttributes redirectAttributes) {
    	System.out.println(product);

       
        if (bindingResult.hasErrors()) {
            model.addAttribute("error", "There are errors in the form submission.");
            return "createProduct";
        }

       
        if (product.getCategory() == null || product.getCategory().getId() <= 0) {
            model.addAttribute("error", "Please select a valid category.");
            return "createProduct";
        }

        
        if (file.isEmpty()) {
            model.addAttribute("error", "Please upload an image.");
            return "createProduct";
        }

        
        try {
            product.setProductPhotoByte(file.getBytes());
        } catch (IOException e) {
            model.addAttribute("error", "Error occurred while uploading the image: " + e.getMessage());
            return "createProduct";
        }

        if (productRepository.productExistName(product.getProductName())) {
            model.addAttribute("error", "Product with the same name already exists.");
            return "createProduct";
        }
        if(product.getProductUnit().equals("kg")||product.getProductUnit().equals("KG")||product.getProductUnit().equals("kG")||product.getProductUnit().equals("Kg")) {
        	product.setProductUnit("kilogram");
        }else if(product.getProductUnit().equals("g")||product.getProductUnit().equals("G")) {
        	product.setProductUnit("gram");
        }
        int productId = productRepository.createProduct(product);
        if (productId > 0) {
            redirectAttributes.addFlashAttribute("message", "Product created successfully.");
            return "redirect:/viewProducts/" + product.getCategory().getId();
        } else {
            model.addAttribute("error", "Failed to create product. Please try again.");
            return "createProduct";
        }
    }
    @GetMapping("editProduct/{id}")
    public String showEditProductForm(@PathVariable("id") int productId, Model model,HttpSession session) {
        ProductBean product = productRepository.findProductById(productId);
        if (product == null) {
            model.addAttribute("error", "Product not found");
            return "viewProducts";
        }
        model.addAttribute("product", product);
        boolean isAuthenticated = SessionService.checkSession(session, "admin");
        return isAuthenticated ? "editProduct" : "redirect:/";
        
    }
    
    @PostMapping("/updateProducts/{id}")
    public String updateProducts(@PathVariable("id") int productId,
                                 @ModelAttribute("product") ProductBean product,
                                 
                                 Model model,
                                 @RequestParam("productPhotoFile") MultipartFile file) {
        ProductBean existingProduct = productRepository.findProductById(productId);
        
        if (!existingProduct.getProductName().equals(product.getProductName()) && productRepository.productExistName(product.getProductName())) {
            model.addAttribute("error", "Product with this name already exists");
            return "editProduct";
        }

       
        if (!file.isEmpty()) {
            try {
                product.setProductPhotoByte(file.getBytes());
            } catch (IOException e) {
                model.addAttribute("error", "Error while uploading file");
                return "editProduct";
            }
        } else {
            product.setProductPhotoByte(existingProduct.getProductPhotoByte());
        }

        product.setId(productId);
        productRepository.updateProduct(product);
        return "redirect:/viewProducts/" + existingProduct.getCategory().getId();
    }
    
    @GetMapping("/deletingProduct/{id}")
    public String deleteProduct(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        ProductBean product = productRepository.findProductById(id);
        if (product != null) {
            productRepository.softDeleteProductById(id);
            int categoryId = product.getCategory().getId();
            redirectAttributes.addFlashAttribute("message", "Product deleted successfully.");
            return "redirect:/viewProducts/" + categoryId; 
        } else {
            redirectAttributes.addFlashAttribute("error", "Product not found.");
            return "redirect:/showDeletedProducts/" + product.getCategory().getId(); // Added slash
        }
    }
    
    @GetMapping("/showDeletedProducts/{categoryId}")
    public String showDeletedProducts(@PathVariable int categoryId, Model model,HttpSession session) {
        List<ProductBean> deletedProducts = productRepository.getAllDeletedProducts(categoryId);
        
        Map<CategoryBean, List<ProductBean>> deletedProductsByCategory = deletedProducts.stream()
            .collect(Collectors.groupingBy(ProductBean::getCategory));
        
        model.addAttribute("deletedProductsByCategory", deletedProductsByCategory);
        model.addAttribute("categoryId", categoryId);
        boolean isAuthenticated = SessionService.checkSession(session, "admin");
        return isAuthenticated ? "showDeletedProducts" : "redirect:/";
       
    }
    
    @GetMapping("/restoringProducts/{id}")
    public String restoredProducts(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        ProductBean product = productRepository.findProductById(id);
        if (product != null) {
            productRepository.restoreProductById(id); 
            int categoryId = product.getCategory().getId();
            redirectAttributes.addFlashAttribute("message", "Product restored successfully.");
            return "redirect:/showDeletedProducts/" + categoryId; // Added slash
        } else {
            redirectAttributes.addFlashAttribute("error", "Product not found");
            return "redirect:/showDeletedProducts";
        }
    }
//======================Detail===============================================
    
    @GetMapping("/viewDetails/{productId}")
	public String showDetialByProductId(@PathVariable ("productId")int productId,Model model,HttpSession session) {
		List<DetailBean> details=detailRepository.findByProductId(productId);
		ProductBean product=productRepository.findProductById(productId);
		details.sort((p1, p2) -> Integer.compare(p2.getId(), p1.getId()));
		model.addAttribute("details",details);
		model.addAttribute("product",product);
		boolean isAuthenticated = SessionService.checkSession(session, "admin");
        return isAuthenticated ? "viewDetails" : "redirect:/";
		
		
	}
    
    @GetMapping("/showCreateDetail/{productId}")
	public String showCreateDetailForm(@PathVariable("productId") int productId,Model model,HttpSession session) {
		DetailBean detail=new DetailBean();
		ProductBean product=productRepository.findProductById(productId);
		detail.setProduct(product);
		model.addAttribute("detail",detail);
		model.addAttribute("product",product);
		boolean isAuthenticated = SessionService.checkSession(session, "admin");
        return isAuthenticated ? "createDetail" : "redirect:/";
		
	}
    
    @PostMapping("/createDetail")
    public String createDetail(@ModelAttribute("detail") DetailBean detail, RedirectAttributes redirectAttributes) {
        
    	 if(detail.getUnit().equals("kg")||detail.getUnit().equals("KG")||detail.getUnit().equals("kG")||detail.getUnit().equals("Kg")) {
        	detail.setUnit("kilogram");
        }else if(detail.getUnit().equals("g")||detail.getUnit().equals("G")) {
        	detail.setUnit("gram");
        }
        if (detailRepository.DetailExistUnit(detail.getUnit(),detail.getProduct().getId())&&detailRepository.DetailExistPerQuantity(detail.getPerQuantity(),detail.getProduct().getId())) {
            redirectAttributes.addFlashAttribute("error", "Product with this detail already exists");
            return "redirect:/showCreateDetail/" + detail.getProduct().getId();  
        }

        int result = detailRepository.createDetail(detail);
        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "Adding details successfully");
            return "redirect:/viewDetails/" + detail.getProduct().getId();
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to create details. Please try again.");
            return "redirect:/showCreateDetail/" + detail.getProduct().getId(); 
        }
    }
    
    @GetMapping("editDetails/{id}")
    public String showEditDetailsForm(@PathVariable("id") int detailId, Model model,HttpSession session) {
        DetailBean detail = detailRepository.findByDetailId(detailId);
        if (detail == null) {
            model.addAttribute("error", "Detail not found");
            return "redirect:/viewDetails";
        }
        model.addAttribute("detail", detail);
        boolean isAuthenticated = SessionService.checkSession(session, "admin");
        return isAuthenticated ? "editDetails" : "redirect:/";
      
    }
    
    @PostMapping("/updateDetails/{id}")
    public String updateDetails(@PathVariable("id") int detailId,
                                 @ModelAttribute("detail") DetailBean detail,
                                 RedirectAttributes redirectAttributes) {
        DetailBean existingDetail = detailRepository.findByDetailId(detailId);
        
        if (existingDetail == null) {
        	redirectAttributes.addFlashAttribute("error", "Detail not found");
            return "redirect:/viewDetails";
        }
        
        detail.setId(detailId);
       detailRepository.updateDetails(detailId,detail);
       if (existingDetail.getProduct() != null) {
    	   redirectAttributes.addFlashAttribute("message", "Detail updated successfully");
           return "redirect:/viewDetails/" + existingDetail.getProduct().getId();
       } else {
    	   redirectAttributes.addFlashAttribute("error", "Product not found for this detail");
           return "redirect:/editDetails/" + detailId;
       }
    }
    
    @GetMapping("/viewDetailHistory/{productId}")
    public String showhistoryDetails(@PathVariable int productId, Model model,HttpSession session) {
        List<DetailBean> historyDetails = detailRepository.getAllHistoryDetails(productId);
        model.addAttribute("historyDetails", historyDetails);
        model.addAttribute("productId", productId);
        model.addAttribute("pdtName",detailRepository.getProductNameByProductId(productId));
        boolean isAuthenticated = SessionService.checkSession(session, "admin");
        return isAuthenticated ? "viewDetailHistory" : "redirect:/";
       
    }
    
    @GetMapping("deleteDetails/{id}")
    public String deleteDetailsForm(@PathVariable("id") int detailId, Model model) {
        // Fetch the existing detail before deleting it
        DetailBean existingDetail = detailRepository.findByDetailId(detailId);
        
        if (existingDetail == null) {
            // Handle case where the detail does not exist
            System.out.println("Detail not found with ID: " + detailId);
            return "redirect:/errorPage";  // Redirect to an error page or appropriate response
        }
        
        // Perform the deletion
        int result = detailRepository.deleteDetail(detailId);

        // After deleting, redirect to the product page using the pre-fetched product ID
        if (result > 0) {
            return "redirect:/viewDetails/" + existingDetail.getProduct().getId();
        } else {
            // Handle failure to delete
            System.out.println("Cannot delete detail with ID: " + detailId);
            return "redirect:/errorPage";  // Add a fallback in case of failure
        }
    }


}
