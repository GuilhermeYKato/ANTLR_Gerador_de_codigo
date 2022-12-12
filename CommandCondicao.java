import java.util.ArrayList;

public class CommandCondicao extends Command {
	private String condition;
	private ArrayList<Command> listTrue;
	private ArrayList<Command> listFalse;
	
	@Override
	public String generateCode() {
		String str= "\tif (" + condition + "){\n";
		for(Command cmd: listTrue) {
			str+="\t"+ cmd.generateCode();
			
		}
		str+="\t}\n";
		if(listFalse.size()>0) {
			str+= "\telse {\n";
			for(Command cmd: listFalse) {
				str+="\t" + cmd.generateCode();
			}
			str+="\t}\n";
		}
		
		return str;
	}
	public CommandCondicao(String id,ArrayList<Command> verdade,ArrayList<Command> falso) {
		this.condition = id;
		this.listTrue = verdade;
		this.listFalse = falso;
	}

	
}