open Lynx

let quit_input = function
    | "q" | "Q" | "quit" | "exit" -> true
    | _ -> false
;;

let rec repl_loop () =
    Printf.printf ">>> ";
    let user_input = read_line () in
    if quit_input user_input then ()
    else (interpret_string user_input; repl_loop ();)
;;

let () = repl_loop ();;
