(* Determine the type of a value *)
val type_of_value : Ast.value -> Ast.type'

val empty_type_env : Ast.type_env

(* Check type correctness in a program
   Partial, yields one of:
    - a type' , the type of correct expression
    - or throws an error , if types are incorrect *)
val run_tc : Ast.type_env -> Ast.expr -> Ast.type'
