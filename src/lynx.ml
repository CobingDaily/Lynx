
let parse_file (filename: string) : Ast.expr =
  let i_channel = open_in filename in
  let lexbuf = Lexing.from_channel i_channel in
  Parser.main Lexer.token lexbuf
;;

let parse_string (s: string) : Ast.expr =
    let lexbuf = Lexing.from_string s in
    Parser.main Lexer.token lexbuf
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

let interpret_string src_code =
  try
    let src_code = prelude_std src_code in
    let ast = parse_string src_code in
    let result = Interp.interpret ast in
    print_endline result
  with e ->
    Printf.printf "Error: %s\n" (Printexc.to_string e)
;;

let interpret_file filename =
  try
    let ast = parse_file filename in
    let result = Interp.interpret ast in
    print_endline filename;
    print_endline ("=> " ^ result);
  with e ->
    Printf.printf "Error: %s\n" (Printexc.to_string e)
;;
