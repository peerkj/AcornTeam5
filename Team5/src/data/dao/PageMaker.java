package data.dao;

public class PageMaker {
	private int perpage = 10;
	private int perBlock = 5;
	private int totalCount;
	private int currentPage;
	private int totalPage;
	private int startPage;
	private int endPage;
	private int start;
	private int end;
	
	QnaDao db = new QnaDao();
	
	public int getTotalCount() {
		totalCount = db.getTotalCount();
		return totalCount;
	}
		
	public int getTotalPage(int totalCount) {
		totalPage = totalCount/perpage+(totalCount%perpage>0?1:0);		
		return totalPage;
	}
	
	public int getCurrentPage(String pageNum, int totalPage) {
		if(pageNum==null)
			currentPage=1;
		else
			currentPage = Integer.parseInt(pageNum);
		
		if(currentPage>totalPage)
			currentPage = totalPage;
		
		return currentPage;
	}	
	
	public int getStartPage(int currentPage) {
		startPage = (currentPage-1)/perBlock*perBlock+1;
		return startPage;
	}
	
	public int getEndPage(int startPage, int totalPage) {
		endPage = startPage+perBlock-1;
		
		if(endPage>totalPage)
			endPage=totalPage;
		
		return endPage;
	}
	
	public int getStart(int currentPage) {
		start = (currentPage-1)*perpage+1;
		return start;
	}
	
	public int getEnd(int start, int totalCount) {
		end = start+perpage-1;
		
		if(end> totalCount)
			end = totalCount;
		
		return end;
	}
	
}
