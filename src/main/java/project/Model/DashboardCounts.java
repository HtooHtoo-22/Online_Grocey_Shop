package project.Model;

import lombok.Data;

@Data
public class DashboardCounts {

	 private long productCount;
	    private long categoryCount;
	    private long customerCount;
	    private long orderCount;
	    private long pendingOrderCount;
}
