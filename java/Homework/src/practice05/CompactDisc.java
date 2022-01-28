package practice05;

import java.util.Scanner;

public class CompactDisc extends Product {
	private String albumTitle;
	private String singer;
	public CompactDisc() {}
	public CompactDisc(int id, String comment, String productor, int price, String albumTitle, String singer) {
		super(id, comment, productor, price);
		this.albumTitle = albumTitle;
		this.singer = singer;
	}
	
	public Product add() {
		Scanner sc = new Scanner(System.in);
		Product p= super.add();
		System.out.print("앨범제목>>");
		String discTitle = sc.next();
		System.out.print("가수>>");
		String singer = sc.next();
		return new CompactDisc(p.getId(),p.getComment(),p.getProductor(),p.getPrice(),
				discTitle,singer);
	}
	
	
}