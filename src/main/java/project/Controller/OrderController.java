package project.Controller;

import java.io.IOException;
import java.util.Base64;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import project.Model.OrderBean;
import project.Model.OrderRequestDTO;
import project.Model.UserBean;
import project.Repository.OrderRepository;
import project.Service.OrderService;

@RestController
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private HttpSession session;
    

    @PostMapping(value = "/update_order", consumes = "application/json", produces = "application/json")
    public ResponseEntity<Void> updateOrder(@RequestBody OrderRequestDTO orderRequest) throws IOException {
    	Double totalAmount=orderRequest.getTotalAmount();
    	int paymentId=orderRequest.getPaymentId();
    	String orderNote=orderRequest.getOrderNote();
        String orderNumber = orderService.generateOrderNumber();
        // Setting the order number for each cart item and address bean
        for (OrderBean item : orderRequest.getCartItems()) {
            item.setOrderNumber(orderNumber);
        }
        orderRequest.getAddress().setOrderNumber(orderNumber);
        
     // Assuming you have access to the HttpSession object
        UserBean userBean = (UserBean) session.getAttribute("userInfo");

        if (userBean != null) {
        	int orderId = orderRepository.insertOrder(userBean, orderRequest.getAddress(),orderNote);
        	 byte[] screenshotBytes = orderRequest.getScreenshot();
             if (screenshotBytes == null && orderRequest.getBase64Screenshot() != null) {
                 screenshotBytes = Base64.getDecoder().decode(orderRequest.getBase64Screenshot());
             }
        	int i=orderRepository.insertPaymentTable(orderId, paymentId,totalAmount,screenshotBytes);
        	if(i>0) {
        		 for (OrderBean item : orderRequest.getCartItems()) {
                     int orderItemId=orderRepository.insertOrderItem(item, orderId); // Insert order item into the database
                     
                 }
        	}
        	
        	// Save the cart items to the database
           
        } else {
            System.out.println("User is not logged in or session expired");
        }


        // Save the order and address details to the database
       // orderRepository.insertOrder(new UserBean(), orderRequest.getAddress());
        
        

        

        return ResponseEntity.ok().build();
    }
    
    
    }

  


