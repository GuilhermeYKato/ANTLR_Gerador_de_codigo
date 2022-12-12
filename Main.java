import java.io.IOException;
import java.util.HashMap;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Token;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;


class Main {
	public static void main(String[] args) {
		try {


			CharStream cs = CharStreams.fromFileName("ErroLexico\\programa2.gyh");
			LinguagemGyhLexer lexer = new LinguagemGyhLexer(cs);
			CommonTokenStream token = new CommonTokenStream(lexer);
			LinguagemGyhParser parser = new LinguagemGyhParser(token);
			parser.programa();
			
			parser.generateCommand();
			
			
			  Token t;
			 
			  while((t=lexer.nextToken()).getType() != Token.EOF ){ System.out.println("<"+
			  t.getText()+", "+LinguagemGyhParser.VOCABULARY.getSymbolicName(t.getType())+
			  ">"); }
			 
		} 
		catch (SemanticException ex) {
			System.err.println("Erro Semantico, " + ex.getMessage());
		}
		catch (Exception ex) {
			System.err.println("Error " + ex.getMessage());
		} 
		
	}
}
