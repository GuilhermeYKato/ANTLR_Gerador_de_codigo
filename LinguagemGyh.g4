grammar LinguagemGyh;

@header{
	import java.util.ArrayList;

}
@members{
	private String _varName;
	private String _varType;
	private String _varValue;
	private Simbolo _varSymbol;
	private SymbolTable symbolTable = new SymbolTable();
	public void VerificarVar(String var){
		if(!symbolTable.exists(var)){
			throw new SemanticException("Variavel: <" + var + "> nao existe");
		}
	}
	// Detectar atribuicao de tipos errados (double em int)
	private int _type;
	private String _typeVar;
	// Verifica e pega o tipo da variavel (se é double ou int)
	public void VerificaType(String Var){
		_type = symbolTable.getType2(Var);
	}
	public int VerificaType2(String Var){
		return symbolTable.getType2(Var);
	}
	//Checa se os tipos batem, (double pode atribuir para double)
	//(Mas double n pode para int )
	public void ChecaType(String Var,int teste, String Var2){
		if(!symbolTable.getType(Var,Var2,teste)){
			throw new SemanticException("Atribuicao: <" + Var + "> em variavel inteiro <"+Var2+">");
		} else {
			System.out.println("Atribuicao: <" + Var + "> em <"+Var2+">");
		}
	}
	private String _checkVarType;
	// Gerador de Codigo
	private GyhProgram program = new GyhProgram();
	private String _varWrite;
	private String _varRead;
	
	private String _expVar;
	private String _expContent;
	
	private String _cond;
	private String _cond2;
	private String _Repet;
	private ArrayList<Command> lt = new ArrayList<Command>();
	private ArrayList<Command> lf = new ArrayList<Command>();
	
	private ArrayList<Command> listCmd = new ArrayList<Command>();
	private ArrayList<Command> listAux = new ArrayList<Command>();
	public void generateCommand(){
		program.generateTarget();
		System.out.println("\n\n##### Gerando Codigo #####\n");
	}
}

Comment: '#'('#' | '_' | '>' | '='| '<' | '!' | '?' | ':' |[a-zà-ú] | [A-ZÀ-Ú] | [0-9] | '\r' | '\t' | '+' | '-' | '*' | ' ' | '\'' | '(' | ')' )*'\n' ->skip;

WS: ('\n' | '\r' | '\t' | ' ') ->skip;

PC: 'DEC' | 'INT' | 'REAL' | 'PROG' | 'LER' | 'IMPRIMIR' | 'SE' | 'ENTAO' | 'ENQTO' | 'INI' | 'FIM';

OpRel: '>=' | '>' | '<='| '<' | '==' | '!=';

OpArit: '+' | '-' | '*' | '/';

OperadorBooleano: 'E' | 'OU';

Atribuicao: ':=';

Delim: ':';

NumInt: [0-9]+;

NumReal: [0-9]+'.'[0-9]+;

Var: [a-z]+ ([a-z]|[A-Z]|[0-9])*;

Cadeia: '"'('>' | '='| '<' | '!' | '?' | [a-zà-ú] | [A-ZÀ-Ú] | [0-9] | '\r' | '\t' | '+' | '-' | '*' | '&' | '(' | ')'| ' ' | '\n' | '@' | '%' | '/' | '_')*'"';

Parentesis: '(' | ')';


programa:   
	(Delim 'DEC' listaDeclaracoes)  
	(Delim 'PROG' listaComandos)
	EOF
	{
		program.setVarTable(symbolTable);
		System.out.println("Programa ----> VarTable ");
		program.setCommand(listCmd);
		System.out.println("Programa ----> Command ");
	};

listaDeclaracoes returns [int contDec]: 
	{$contDec=0;} 
	(declaracao {$contDec++;})+ 
	;

declaracao: 
	Var 
	{_varName=_input.LT(-1).getText();}  
	Delim ('REAL' {_varType= "REAL";}| 'INT' {_varType= "INT";})
	{_varValue=null;}
	{_varSymbol = new Simbolo(_varName, _varType, _varValue);}
	{
		if(!symbolTable.exists(_varName)){
			symbolTable.add(_varSymbol);
			{System.out.println("Adicionei um simbolo " + _varSymbol);}
		} else {
			throw new SemanticException("Simbolo: <" + _varName + "> ja adicionado");
		}
		
	};

listaComandos returns [int contProg]: 
	{$contProg=0;} 
	(comando {$contProg++;}
		{
			listCmd.addAll(listAux);
			listAux.removeAll(listAux);
		}
		
	)+;

comando: 
	comandoAtribuicao 
	| comandoEntrada 
	| comandoSaida 
	| comandoCondicao 
	| comandoRepeticao 
	| subAlgoritmo;

comandoAtribuicao: 
	Var 	
	{
		// Detecta Erro sintatico
		VerificarVar(_input.LT(-1).getText());
		_expVar = _input.LT(-1).getText();
		_typeVar = _input.LT(-1).getText();
		_checkVarType = _input.LT(-1).getText();
	}
	Atribuicao {_expContent = "";}
	expressaoAritmetica
	{
		CommandAtribuicao cmd = new CommandAtribuicao(_expVar,_expContent);
		listAux.add(cmd);
	};

comandoEntrada: 
	'LER' Var
	{
		// Detecta Erro sintatico
		VerificarVar(_input.LT(-1).getText());
		VerificaType(_input.LT(-1).getText());
	}
	{
		// Gerador codigo
		_varRead = _input.LT(-1).getText();
		CommandLeitura cmd = new CommandLeitura(_varRead,_type);
		listAux.add(cmd);
		
	};

comandoSaida: 
	'IMPRIMIR'  Var 
	{
		// Detecta Erro sintatico
		VerificarVar(_input.LT(-1).getText());
	}
	{
		// Gerador de codigo
		_varWrite = _input.LT(-1).getText();
		_type=VerificaType2(_input.LT(-1).getText());
		//System.out.println(_type);
		CommandEscrita cmd = new CommandEscrita(_varWrite,_type);
		listAux.add(cmd);
	}
	| 'IMPRIMIR' Cadeia
	{	
		// Gerador de codigo
		_varWrite = _input.LT(-1).getText();
		CommandEscrita cmd = new CommandEscrita(_varWrite,-1);
		listAux.add(cmd);
	};



comandoRepeticao: 
	'ENQTO' {
		// Gerador de codigo
		_cond2= "";
		_Repet = "INICIO";
	}
	expressaoRelacional  {
		// Gerador de codigo
		CommandRepeticao cmd = new CommandRepeticao(_cond2,_Repet);
		listCmd.add(cmd);
	}
	(comando
	{
		// Gerador de codigo
		_cond2 = "}\\n";
		_Repet = "FIM";
		CommandRepeticao cmd1 = new CommandRepeticao(_cond2,_Repet);
		listAux.add(cmd1);
		//listCmd.add(cmd1);
	});

subAlgoritmo: 
	'INI' 
	(comando)+
	'FIM';


expressaoAritmetica: 
	termoAritmetico  
	('+' {_expContent+= " + ";}
	termoAritmetico  
	| '-' {_expContent+= " - ";}
	 termoAritmetico )? 
	 | termoAritmetico;



termoAritmetico: 
	fatorAritmetico  
	('*' 
	{
		_expContent+=_input.LT(-1).getText();
		System.out.println(_input.LT(-1).getText());
	}
	fatorAritmetico  
	| '/' 
	{
		_expContent+= _input.LT(-1).getText();
		System.out.println(_input.LT(-1).getText());
	}
	fatorAritmetico)
	| fatorAritmetico;



fatorAritmetico: 
	(NumInt	
	{ 
		// Gerador de codigo
		_expContent+= _input.LT(-1).getText();
	}
	| NumReal   
	{ 
		// Gerador de codigo
		_expContent+= _input.LT(-1).getText();
		ChecaType(_input.LT(-1).getText(),0,_typeVar);
	}
	| Var 	 	
	{ 
		// Gerador de Codigo
		
		_expContent+= _input.LT(-1).getText();
		VerificaType(_input.LT(-1).getText());
		ChecaType(_input.LT(-1).getText(),-1,_typeVar);
		
	}
	{
		// Sintatico
		VerificarVar(_input.LT(-1).getText());
	})*
	| 
	'('  {_expContent+= " ( ";}
	expressaoAritmetica
	 ')' {_expContent+= " ) ";}
	 ;
	 
comandoCondicao: 
	{
		_cond= "";
	}
	'SE' 
	expressaoRelacional 
	'ENTAO' 
	comando {
		lt.addAll(listAux);
		listAux.removeAll(listAux);
		
	}
	comandoCondicao2;

comandoCondicao2: ('SENAO' comando
	{
		// Gerador de codigo
		lf.addAll(listAux);
		listAux.removeAll(listAux);
		
	}
	)?
	{
		// Gerador de codigo
		CommandCondicao cmd = new CommandCondicao(_cond,lt,lf);
		listAux.add(cmd);
	}; 
	
expressaoRelacional: 
	
	expressaoRelacional 
	OperadorBooleano {
		// Gerador de codigo
		_cond+= " ";
		_cond2+= " ";
		if(_input.LT(-1).getText().equals("E")){
			// Gerador de codigo
			_cond+= " && ";
			_cond2+= " && ";
		}else if(_input.LT(-1).getText().equals("E")){
			// Gerador de codigo
			_cond+= " || ";
			_cond2+= " || ";
		};
	}
	termoRelacional {
		// Gerador de codigo
		_cond += " ";
		_cond2+= " ";
		_cond += _expContent;
		_cond2+= _expContent;
		_expContent="";
	}
	| termoRelacional 
	{
		// Gerador de codigo
		_cond += " ";
		_cond2+= " ";
		_cond += _expContent;
		_cond2+= _expContent;
		_expContent="";
	};

termoRelacional: 
	{_expContent="";}
	expressaoAritmetica 
	{
		// Gerador de codigo
		_cond += " ";
		_cond2+= " ";
		_cond += _expContent;
		_cond2+= _expContent;
		_expContent="";
	}
	OpRel {
		// Gerador de codigo
		_cond+= " ";
		_cond2+= " ";
		_cond += _input.LT(-1).getText();
		_cond2 += _input.LT(-1).getText();
	}
	expressaoAritmetica 
	{
		// Gerador de codigo
		_cond += " ";
		_cond += _expContent;
		_cond2 += " ";
		_cond2 += _expContent;
		_expContent="";
	}
	| '(' 
	{
		// Gerador de codigo
		_cond += " ( ";
		_cond2 += " ( ";
	}
	expressaoRelacional 
	')'
	{
		// Gerador de codigo
		_cond+= " ) ";
		_cond2+= " ) ";
	};










