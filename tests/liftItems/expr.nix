{haumea}: let
  inherit
    (haumea.transformers)
    liftDefault
    liftItems
    ;
in
  haumea.load {
    src = ./__fixture;
    transformer = [
      liftDefault
      liftItems
    ];
  }
