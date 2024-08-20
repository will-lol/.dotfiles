{ nixpkgs, supportedSystems }: {
  forAllSupportedSystems = f: nixpkgs.lib.genAttrs supportedSystems f;
}

