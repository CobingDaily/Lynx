
let parse (s: string) : Ast.expr =
    let lexbuf = Lexing.from_string s in
    Parser.main Lexer.token lexbuf
;;

let interpret input =
    try
        let result = Interp.interpret @@ parse input in
        print_endline result
    with e ->
        Printf.printf "Error: %s\n\n" (Printexc.to_string e)
;;

let quit_input = function
    | "q" 
    | "Q" 
    | "quit"
    | "exit" -> true
    | _ -> false
;;


let rec repl_loop () =
    Printf.printf ">>> ";
    let user_input = read_line () in
    if quit_input user_input then ()
    else (interpret user_input; repl_loop ();)
;;

let () = repl_loop ();;
