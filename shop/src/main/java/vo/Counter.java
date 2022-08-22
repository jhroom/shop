package vo;

public class Counter {
	
	private String countDate;
	private int countNum;
	
	public String getCountDate() {
		return countDate;
	}
	public void setCountDate(String countDate) {
		this.countDate = countDate;
	}
	public int getCountNum() {
		return countNum;
	}
	public void setCountNum(int countNum) {
		this.countNum = countNum;
	}
	
	@Override
	public String toString() {
		return "Counter [countDate=" + countDate + ", countNum=" + countNum + "]";
	}
	
}
