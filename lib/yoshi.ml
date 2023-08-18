module rec Ty : sig
  type quantifier = string
  type var = Unbound of quantifier | Link of t
  and t =
    | Num
    | Bool
    | Lam of t * t
    | Forall of quantifier * t
    | Var of var ref
end = Ty
and Anf : sig
  type id = string
  type imm =
    | Num of int
    | Bool of bool
    | Id of id * Ty.t
  type t' =
    | Jump of id * imm
    | Join of id * id * t' * t'
    | Return of imm
    | Perform of id * id * imm
    | With of id * id * t' * t'
    | Resume of imm
    | If of imm * t' * t'
    | Imm of imm
    | Let of id * t' * t'
    | Lam of id * id * t' * t'
    | App of id * id * imm * t'
  type t = t' * Ty.t
end = Anf