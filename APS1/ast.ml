
type prog =
  cmd list

and block =
  cmd list

and cmd =
  Stat of stat
  | Def of def

and stype =
  BoolType
  | IntType
  | VoidType
  | Types of stype list * stype

and arg = string * stype

and def =
  ConstDef of string * stype * sexpr
  | FunDef of string * stype * arg list * sexpr
  | RecFunDef of string * stype * arg list * sexpr
  | VarDef of string * stype
  | ProcDef of string * arg list * block
  | RecProcDef of string * arg list * block

and stat =
  Echo of sexpr
  |Set of string * sexpr
  |IfStat of sexpr * block * block
  |While of sexpr * block
  |Call of string * sexpr list

and sexpr =
  ASTBool of bool
  | ASTNum of int
  | ASTId of string
  | ASTIf of sexpr * sexpr * sexpr
  | ASTOp of string * sexpr list
  | ASTApp of sexpr * sexpr list
  | ASTFunAbs of arg list * sexpr



