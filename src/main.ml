open Lynx

let files directory = 
  Sys.readdir directory 
    |> Array.to_list
    |> List.map (fun name -> directory ^ "/" ^ name)
;;

let () = 
  List.iter (fun file -> interpret_file file) (files "examples")
;;
