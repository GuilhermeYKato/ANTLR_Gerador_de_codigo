//HashMap<integer,Simbolo>
public class Simbolo {
	private String name;
	private int type;
	private String value;
	
	public static final int REAL = 0;
	public static final int INT = 1;
	
	public Simbolo (String name, String type, String value) {
		this.name= name;
		if(type.equals("INT")) this.type = INT;
		else this.type = REAL;
		this.value = value;
		
	}
	
	public String getName() {
		
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
		
	}
	public int getType() {
		
		if(type >= 0) {
			return type;
		} else {
			return -1;
		}
		
	}
	
	public void setType(int type) {
		this.type = type;
		
	}
	
	public String getValue() {
		
		return value;
	}
	
	public void setValue(String value) {
		this.value = value;
	}
	
	@Override
	public String toString() {
		return "Simbolo [name="+ this.name + " Type=" + type+ " Value="+value+"]";
	}
	
	public String generateCode() {
		String str;
		if(type == INT)
			str= "\tint " + name + ";";
		else
			str= "\tdouble " + name + ";";
		return str;
	}
	
}
