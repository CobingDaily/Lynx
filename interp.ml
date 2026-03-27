open Ast

let rec eval = function
    | Value value -> value
    | Var _ -> failwith "var not implemented"
    | Let _ -> failwith "let not implemented"
    | IfElse (cond_expr, then_expr, other_expr) ->
            (match (eval cond_expr) with
            | Bool false
            | String ""
            | Int 0
            | Float 0.0 -> eval other_expr
            | _ -> eval then_expr)
    | BinOp (op, left, right) ->
            let left = eval left in
            let right = eval right in
            let eval_binop = eval_binop left right in
            (match op with
             | Add -> eval_binop ~op_i:( + ) ~op_f:( +. ) ~op_s:( ^ ) ()
             | Sub -> eval_binop ~op_i:( - ) ~op_f:( -. ) ()
             | Mul -> eval_binop ~op_i:( * ) ~op_f:( *. ) ()
             | Div -> eval_binop ~op_i:( / ) ~op_f:( /. ) ()
             | Equals -> Bool (left = right))


and eval_binop left right ?op_i ?op_f ?op_s () =
    match (left, right, op_i, op_f, op_s) with
    | Int x, Int y, Some op, _, _ -> Int (op x y)
    | Float x, Float y, _, Some op, _ -> Float (op x y)
    | String s1, String s2, _, _, Some op -> String (op s1 s2)
    | _ -> failwith (Printf.sprintf "Cannot infer type")
;;

let interpret expr =
    let value = eval expr in
    match value with
    | Int n -> Printf.sprintf "%i" n
    | Float n -> Printf.sprintf "%f" n
    | Bool b -> if b then "true" else "false"
    | Char c -> Printf.sprintf "%C" c
    | String s -> Printf.sprintf "%S" s
;;

