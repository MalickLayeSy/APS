

type prog =
  bloc

and bloc =
  cmd list

and cmd =
    Def of def
  | Stat of stat
  | Return of sexpr

and def  =
    ConstDef of string * stype * sexpr
  | FunDef of string * stype * arg list * sexpr
  | FunRecDef of string * stype * arg list * sexpr
  | VarDef of string * stype
  | ProcDef of string * arg list * bloc
  | ProcRecDef of string * arg list * bloc
  | FunPDef of string * stype * arg list * bloc
  | FunRecPDef of string * stype * arg list * bloc

and stype =
    BoolType
  | IntType
  | VecType of stype
  | Types of stype list * stype

and arg = 
    Arg of string * stype
  | Argp of string * stype

and stat =
    Echo of sexpr
  | Set of lvalue * sexpr
  | IfStat of sexpr * bloc * bloc
  | While of sexpr * bloc
  | Call of string * sexprp list

and lvalue =
    Lvar of string
  | Lnth of lvalue * sexpr

and sexprp =
    ASTAdr of string
  | ASTExpr of sexpr

and sexpr =
    ASTBool of bool
  | ASTNum of int
  | ASTId of string
  | ASTIf of sexpr * sexpr * sexpr
  | ASTOp of string * sexpr list
  | ASTApp of sexpr * sexpr list
  | ASTFunAbs of arg list * sexpr