package vo;

public class Cart {
	
	private String customerId;
	private int goodsNo;
	private int cartQuanti;
	private String updateDate;
	private String createDate;
	
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public int getCartQuanti() {
		return cartQuanti;
	}
	public void setCartQuanti(int cartQuanti) {
		this.cartQuanti = cartQuanti;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	@Override
	public String toString() {
		return "Cart [customerId=" + customerId + ", goodsNo=" + goodsNo + ", cartQuanti=" + cartQuanti
				+ ", updateDate=" + updateDate + ", createDate=" + createDate + "]";
	}

}
