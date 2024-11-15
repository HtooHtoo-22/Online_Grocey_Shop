package project.Controller;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import project.Model.HistoryBean;
import project.Model.HistoryModelBoxBean;
import project.Model.UserBean;
import project.Repository.HistoryRepository;

@Controller
public class HistoryController {
  
  @Autowired
  HttpSession session;

    private final HistoryRepository hrepo;

    public HistoryController(HistoryRepository hrepo) {
        this.hrepo = hrepo;
    }

    @GetMapping("/history")
    public String goHistory(HttpSession session, ModelMap map) {
        UserBean userBean = (UserBean) session.getAttribute("userInfo");
        int userId = userBean.getId();
        List<HistoryBean> history = hrepo.showHistory(userId);

        map.addAttribute("history", history);

        
        return "History";
    }
    
    @GetMapping("/orderDetails/{orderNumber}")
    public ModelAndView goOrderDetail(@PathVariable String orderNumber) {
        UserBean userBean = (UserBean) session.getAttribute("userInfo");
        int id = userBean.getId();
        
        // Get the history list based on userId and orderNumber
        List<HistoryModelBoxBean> historyList = hrepo.getOrderHistoryByUserIdAndOrderNumber(id, orderNumber);
        
        // Calculate the total amount
        double totalAmount = historyList.stream()
            .mapToDouble(HistoryModelBoxBean::getTotalPrice) // Assuming totalPrice is a numeric field in HistoryModelBoxBean
            .sum();

        // Pass the list and totalAmount to the view
        ModelAndView modelAndView = new ModelAndView("Detail");
        modelAndView.addObject("historyList", historyList);
        modelAndView.addObject("totalAmount", totalAmount);
        
        return modelAndView;
    }


}