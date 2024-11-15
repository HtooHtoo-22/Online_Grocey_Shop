package project.Model;

import java.time.LocalDate;
import lombok.Data;

@Data
public class HistoryBean {
    private String orderNumber;
    private String orderItems;
    private LocalDate orderdate;
    private String orderAddress;
    private String orderNotes; 
    private int status;
}