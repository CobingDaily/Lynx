
type binop = 
    | Add
    | Sub
    | Mul
    | Div
    | Equals
;;

type expr =
    | Int of int
    | Float of float
    | BinOp of binop * expr * expr (* op, left, right *)
    | Var of string
    | Let of string * expr * expr (* variable name, value, body*)
;;

let rec string_of_expr = function
    | Var x -> x
    | Int n -> Printf.sprintf "%d" n
    | Float n -> Printf.sprintf "%ff" n
    | BinOp (op, left, right) ->
            let l_expr = string_of_expr left in
            let r_expr = string_of_expr right in
            (match op with
                | Add -> Printf.sprintf "(%s + %s)" l_expr r_expr
                | Sub -> Printf.sprintf "(%s - %s)" l_expr r_expr
                | Mul -> Printf.sprintf "(%s * %s)" l_expr r_expr
                | Div -> Printf.sprintf "(%s / %s)" l_expr r_expr
                | Equals -> Printf.sprintf "(%s == %s)" l_expr r_expr)
    | Let (name, value, body) ->
            let value = string_of_expr value in
            let body = string_of_expr body in
            Printf.sprintf "(let %s = %s in %s)" name value body
;;
