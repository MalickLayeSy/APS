LEX_ML = ocamllex
YACC_ML = ocamlyacc
OCAMLC = ocamlc

eval: prologTerm eval.ml
	$(OCAMLC) -o eval ast.cmo lexer.cmo parser.cmo eval.ml
	
prologTerm: parser prologTerm.ml
	$(OCAMLC) -o prologTerm ast.cmo lexer.cmo parser.cmo prologTerm.ml

parser: ast.ml lexer.mll parser.mly
	$(OCAMLC) -c ast.ml
	$(LEX_ML) -o lexer.ml lexer.mll
	$(YACC_ML) -b parser parser.mly
	$(OCAMLC) -c parser.mli
	$(OCAMLC) -c lexer.ml
	$(OCAMLC) -c parser.ml

clean:
	rm -f *.cmo
	rm -f *.cmi
	rm -f prologTerm
	rm -f eval
	rm -f lexer.ml
	rm -f parser.mli
	rm -f parser.ml
	
