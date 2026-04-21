open Ast

type type' =
    | IntT
    | FloatT
    | BoolT
    | CharT
    | StringT
    | FunctionT of type' * type' (* a function type is type' -> type' *)
;;

let type_of_value = function
    | Int _     -> IntT
    | Float _   -> FloatT
    | Bool _    -> BoolT
    | Char _    -> CharT
    | String _  -> StringT
    | Closure _ -> failwith "not implemented"
    (* | Closure _ -> FunctionT *)
;;

let rec run_tc = function
    | Value v -> type_of_value v
    | BinOp (binop, left_expr, right_expr) -> failwith "todo"
    | IfElse (test_expr, then_expr, else_expr) ->
            let test_type = run_tc test_expr in
            let then_type = run_tc then_expr in
            let else_type = run_tc else_expr in
            begin match (test_type) with
            | BoolT -> 
                    if then_type = else_type then then_type
                    else failwith "Types in both branches of `if` must match"
            | _ -> failwith "Expected Bool in if (...)"
            end
    | _ -> failwith "not implemented"
  (*   | BinOp of binop * expr * expr *)
  (*   | UnOp of unop * expr *)
  (*   | Var of string *)
  (*   | Let of string * expr * expr *)
  (*   | Func of string * expr *)
  (*   | Apply of expr * expr *)
