import java.util.HashMap;
import java.util.ArrayList;

public class SymbolTable {
	private HashMap<String,Simbolo> table;
	
	// Inicia a tabela de simbolos
	public SymbolTable() {
		table = new HashMap<String, Simbolo>();
	}
	
	// Adiciona um elemento na tabela de simbolos
	public void add(Simbolo symbol) {
		table.put(symbol.getName(), symbol);
		
	}
	
	// Checa se existe o elemento
	public boolean exists(String name) {
		/*
		Simbolo x;
		x=table.get(name);
		if(x != null) {
			System.out.println(x.getType());
		}
		*/
		
		return table.get(name) != null;
	}
	
	// Retorna o nome do simbolo
	public Simbolo get(String symbolName) {
		return table.get(symbolName);
	}
	
	public ArrayList<Simbolo> getAll(){
		ArrayList<Simbolo> list = new ArrayList<Simbolo>();
		for(Simbolo symbol: table.values()) {
			list.add(symbol);
		}
		return list;
	}
	
	public boolean getType(String name,String name2,int teste) {
		int num1;
		int num2;
		Simbolo x;
		Simbolo x2;
		x=table.get(name);
		x2=table.get(name2);		
		
		if(x == null) {
			num1 = -1;
		}else {
			num1= x.getType();
		}
		if(x2 == null) {
			num2 = -1;
		}else{
			num2= x2.getType();
		}
		//System.out.println("Num1: "+num1 +" -> Num2:"+ num2+ " Teste: "+teste);
		if(num1 == num2 ) {
			return true;
		}else if(teste == num2) {
			return true;
		}else if(num1 == 1 && num2 == 0){
			return true;
		}else {
			return false;
		}

		
			
		
	}
	
	public int getType2(String name) {
		int num3;
		Simbolo x;
		x=table.get(name);
		//System.out.println(x+" here");
		if(x == null) {
			num3 = 0;
		}else {
			num3= x.getType();
		}
		//System.out.println(num3);
		return num3;
	}

}


 