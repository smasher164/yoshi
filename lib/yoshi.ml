module Ty = struct
  type quantifier = string

  type var = Unbound of quantifier | Link of t

  and t =
    | Num
    | Bool
    | Lam of t * t
    | Forall of quantifier * t
    | Var of var ref
end

module Anf = struct
  type id = string
  type atom = Num of int | Bool of bool | Id of id * Ty.t

  type t = t' * Ty.t

  and t' =
    | Jump of id * atom
    | Join of id * id * t * t
    | Return of atom
    | Perform of id * id * atom
    | With of id * id * t * t
    | Resume of atom
    | If of atom * t * t
    | Let of id * t * t
    | Lam of id * id * t * t
    | Closure of id * id list * id * t * t
    | Tuple of id * (id option * atom) list * t
    | Proj of id * id * id * t
    | App of id * id * atom * t
end