
open Ast

let rec print_prog prog =
  "prog(["^print_cmds prog^"])"

and print_block block =
  "block(["^print_cmds block^"])"

and print_cmds cmds = 
  match cmds with
    [] -> ""
  | [h] -> print_cmd h
  | h::t -> print_cmd h ^","^print_cmds t

and print_cmd cmd =
  match cmd with
      Stat stat -> print_stat stat
    | Def def -> print_def def

and print_def def =
  match def with
      ConstDef (id, t, e) -> "const(\""^id^"\","^(print_type t)^","^(print_expr e)^")"                       
    | FunDef (id, t, args, e) ->"fun(\""^id^"\","^(print_type t)^",["^(print_args args)^"],"^(print_expr e)^")"
    | RecFunDef (id, t, args, e) -> "funrec(\""^id^"\","^(print_type t)^",["^(print_args args)^"],"^(print_expr e)^")"
    | VarDef (id, t) -> "var(\""^id^"\",ref("^(print_type t)^"))"
    | ProcDef (id, args, b) -> "proc(\""^id^"\",["^(print_argsp args)^"],"^print_block b^")"
    | RecProcDef (id, args, b) -> "procrec(\""^id^"\",["^(print_argsp args)^"],"^print_block b^")"

and print_type t =
  match t with
      BoolType -> "bool"
    | IntType -> "int"
    | VoidType -> "void"
    | VecType t -> "vec("^print_type t^")"
    | Types (ts,t) -> "types(["^(String.concat "," (List.map print_type ts))^"],"^(print_type t)^")"

    and print_arg arg =
    match arg with
      (id,t) -> "(\"" ^ id ^ "\"," ^ print_type t^")"
  
  and print_args args =
    match args with
        [] -> ""
      | [a] -> print_argp a
      | a::t -> print_argp a ^ "," ^ print_args t
  
  and print_argp argp =
    match argp with
        Arg (id,t) -> "(\"" ^ id ^ "\"," ^ print_type t^")"
      | Argp(id,t) -> "(\"" ^ id ^ "\",ref(" ^ print_type t^"))"
  
  and print_argsp argsp =
    match argsp with
        [] -> ""
      | [a] -> print_argp a
      | a::t -> print_argp a ^ "," ^ print_argsp t
  
and print_stat stat =
  match stat with
      Echo e -> "echo("^(print_expr e)^")"
    | IfStat (c, i, e) -> "ifstat("^(print_expr c)^","^(print_block i)^","^(print_block e)^")"
    | While (c,b) -> "while("^(print_expr c)^","^(print_block b)^")"
    | Call (id, e) -> "call(\""^id^"\",["^(print_exprsp e)^"])"
    | Set (l, e) ->"set(" ^ (print_lvalue l) ^ ", " ^ (print_expr e) ^ ")"

and print_lvalue lv =
  match lv with
      LvalueId x -> "ident(\""^x^"\")"
    | Lvalue (l, e) -> "nth("^print_lvalue l^", "^print_expr e^")"
   
  
and print_exprp ep =
  match ep with
      ASTAdr x -> "adr(ident(\""^x^"\"))"
    | ASTExpr e -> "expr("^print_expr e^")"
  
and print_exprsp eps =
  match eps with
      [] -> ""
    | [ep] -> print_exprp ep
    | ep::t -> print_exprp ep ^ "," ^ print_exprsp t

and print_expr e =
  match e with
      ASTBool true -> "true"
    | ASTBool false -> "false"
    | ASTNum n -> string_of_int n
    | ASTId x -> "ident(\""^x^"\")"
    | ASTIf (c, i, e) -> "if("^(print_expr c)^","^(print_expr i)^","^(print_expr e)^")"
    | ASTOp (op, es) -> op^"("^(print_exprs es)^")"
    | ASTApp(e, es) -> "app("^(print_expr e)^",["^(print_exprs es)^"])"
    | ASTFunAbs(args, e) -> "funabs(["^(print_args args)^"],"^(print_expr e)^")"
  
and print_exprs es =
  match es with
      [] -> ""
    | [e] -> print_expr e
    | e::t -> print_expr e ^ "," ^ print_exprs t
;;

let fname = Sys.argv.(1) in
let ic = open_in fname in
  try
    let lexbuf = Lexing.from_channel ic in
    let e = Parser.prog Lexer.token lexbuf in
    print_string(print_prog e);
    print_string ".";
  with Lexer.Eof ->
    exit 0