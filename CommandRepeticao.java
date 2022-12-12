
public class CommandRepeticao extends Command{
	private String id;
	private String cond;
	
	@Override
	public String generateCode() {
		// TODO Auto-generated method stub
		String str = "\t";
		if(id == "INICIO") {
			str += "while("+cond+"){\n";
			return str;
		} else {
			str += "\n\t}\n";
			return str;
		}
		
	}
	public CommandRepeticao(String cond,String id) {
		this.id = id;
		this.cond = cond;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	

}
