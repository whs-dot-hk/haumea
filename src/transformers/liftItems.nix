{
  lib,
  super,
}: c: t: let
  inherit (builtins) attrNames;
  inherit (builtins) concatMap;
  inherit (builtins) isAttrs;
  inherit (builtins) listToAttrs;
  inherit (lib) nameValuePair;

  toplevel = c == [];
  r = listToAttrs (concatMap (
    n: let
      v = t.${n};
    in
      if isAttrs v
      then map (n': nameValuePair "${n}-${n'}" v.${n'}) (attrNames v)
      else []
  ) (attrNames t));
in
  if toplevel
  then r
  else t
