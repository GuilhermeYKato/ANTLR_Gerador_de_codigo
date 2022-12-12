
public class CommandAtribuicao extends Command{
	private String id;
	private String exp;
	
	public CommandAtribuicao(String id, String exp) {
		this.id = id;
		this.exp = exp;
	}
	
	@Override
	public String generateCode() {
		return "\t"+id + " = " + exp + ";\n";
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getExp() {
		return exp;
	}
	public void setExp(String exp) {
		this.exp = exp;
	}

}
