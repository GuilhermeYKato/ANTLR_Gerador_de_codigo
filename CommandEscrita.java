
public class CommandEscrita extends Command{
	private String id;
	private int tipo;
	
	@Override
	public  String generateCode() {
		if(tipo == 1) return "\tprintf(\"%d\\n\","+id+");\n";
		else if(tipo == 0) {
			return "\tprintf(\"%lf\\n\","+id+");\n";
		}else {
			return "\tprintf(\"%s\\n\","+id+");\n";
		}
	}
	
	public CommandEscrita(String id, int tipo) {
		this.id = id;
		this.tipo = tipo;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
}
