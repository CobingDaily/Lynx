
let file_content_as_str filename =
  let cin = open_in filename in
  In_channel.input_all cin
;;

let prelude_std src_code =
  let prelude_file_names = Sys.readdir "std" 
    |> Array.to_list
    |> List.map (fun name -> "std" ^ "/" ^ name)
  in
  let std_src =
    let file_sources = List.map (file_content_as_str) prelude_file_names in
    List.fold_right (fun file_str acc -> acc ^ "\n" ^ file_str) file_sources ""
  in
  std_src ^ "\n" ^ src_code
;;

let parse_string src_code =
  let src_code = prelude_std src_code in
  let lexbuf = Lexing.from_string src_code in
  Parser.main Lexer.token lexbuf
;;

let parse_file filename =
  let src_code = file_content_as_str filename in
  parse_string src_code
;;

let interpret_string src_code =
  try
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
