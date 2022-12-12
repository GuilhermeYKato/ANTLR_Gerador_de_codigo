
public class CommandLeitura extends Command{
	private String id;
	private int type;
	@Override
	public  String generateCode() {
		if(type == 1) {
			return "\tscanf(\"%d\",&"+id+");\n";
		}else {
			return "\tscanf(\"%lf\",&"+id+");\n";
		}
		
		
	}
	
	public CommandLeitura(String id,int type){
		this.id= id;
		this.type = type;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
