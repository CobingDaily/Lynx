
let parse (s: string) : Ast.expr =
    let lexbuf = Lexing.from_string s in
    Parser.main Lexer.token lexbuf
;;

let interpret (s: string) =
    try
        let ast = parse s in
        let result = Interp.interpret ast in
        print_endline result
    with e ->
        Printf.printf "Error: %s\n" (Printexc.to_string e)
;;

let prelude_std (src_code : string) =
  let prelude_files = Sys.readdir "std" 
    |> Array.to_list
    |> List.map (fun name -> "std" ^ "/" ^ name)
  in
  let file_content_as_str filename =
    let cin = open_in filename in
    In_channel.input_all cin
  in
  let std_src =
    let file_sources = List.map (file_content_as_str) prelude_files in
    List.fold_right (fun file_str acc -> acc ^ "\n" ^ file_str) file_sources ""
  in
  std_src ^ "\n" ^ src_code
;;

let quit_input = function
    | "q" | "Q" | "quit" | "exit" -> true
    | _ -> false
;;


let rec repl_loop () =
    Printf.printf ">>> ";
    let user_input = read_line () in
    if quit_input user_input then ()
    else (interpret (prelude_std user_input); repl_loop ();)
;;

let () = repl_loop ();;
