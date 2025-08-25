# flake.nix

{
  description = "CLI tool to mark empty directories with .keep files";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    #flake-parts.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    #flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {

      #systems = [
      #  "x86_64-linux"
      #  "aarch64-darwin"
      #];
      systems = inputs.flake-utils.lib.defaultSystems;

      perSystem = { pkgs, config, system, ... }: {

        packages.default = pkgs.stdenv.mkDerivation {
          name = "mark-empty-dirs";
          src = ./.;

          buildInputs = [ pkgs.findutils pkgs.coreutils ];

          installPhase = ''
            mkdir -p $out/bin
            mkdir -p $out/lib

            #cp -r ${./lib}/* $out/lib
            cp lib/*.sh $out/lib/
            cp main.sh $out/bin/mark-empty-dirs

            substituteInPlace $out/bin/mark-empty-dirs \
              --replace '$(dirname "$0")/lib' "$out/lib"

            chmod +x $out/bin/mark-empty-dirs
          '';
        }; # End of 'packages.default = pkgs.writeShellApplication { ... };'

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.bashInteractive
            pkgs.findutils
            pkgs.coreutils
            pkgs.shellcheck
            pkgs.bats
            pkgs.tree
          ];
          shellHook = ''
            echo "🔧 mark-empty-dirs dev shell activated"
            echo "Run ./main.sh or use nix run"
          '';
        };

        formatter = pkgs.nixpkgs-fmt;

        apps.default = {
          type = "app";
          program = "${config.packages.default}/bin/mark-empty-dirs";
        };

        checks.shellcheck = pkgs.runCommand "shellcheck" { } ''
          ${pkgs.shellcheck}/bin/shellcheck main.sh lib/*.sh
          touch $out
        '';

      }; # End of 'perSystem = { ... };
    };
}

