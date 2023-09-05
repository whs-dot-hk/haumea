{
  lib,
  super,
}: from: to:
# Example from / to
# - Lifting `imports` from: _imports, to: imports
#
# Note:
#   underscore used as mere convention to signalling to the user the "private"
#   nature, they won't be part of the final view presented to the user
let
  inherit (lib) attrNames;
  inherit (lib) filterAttrsRecursive;
  inherit (lib) flatten;
  inherit (lib) isAttrs;

  f = t:
    flatten (map (
        n: let
          v = t.${n};
        in
          if n == from
          then [v]
          else if isAttrs v
          then f v
          else []
      )
      (attrNames t));
in
  c: t: let
    toplevel = c == [];
    r =
      (filterAttrsRecursive (n: _: n != from) t)
      // {
        ${
          if toplevel
          then to
          else from
        } =
          f t;
      };
  in
    r
