let print s = print_endline s

type expr =
  | Num of int
  | Bool of bool
  | String of string