val parse_string : string -> Ast.expr
val parse_file   : string -> Ast.expr

val interpret_string : string -> unit
val interpret_file   : string -> unit
