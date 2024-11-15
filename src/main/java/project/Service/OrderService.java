package project.Service;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Service;

@Service
public class OrderService {
	// Method to generate a unique order number using timestamp
    public String generateOrderNumber() {
        // Format to generate order number based on current date and time
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        Date now = new Date();  // Get current date and time

        // Create the order number, e.g., "ORD-20241016123045"
        return "ORD-" + formatter.format(now);  
    }
}
