{ haumea }:

let
  inherit (haumea.transformers)
    liftDefault
    hoistLists
    ;
in

haumea.load {
  src = ./__fixture;
  transformer = [
    (hoistLists "_imports" "imports")
    liftDefault
  ];
}
