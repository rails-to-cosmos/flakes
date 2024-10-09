{ pkgs, lib, config, inputs, ... }:

{
  packages = with pkgs; [ gopls nodejs tinygo ];
  languages.go.enable = true;
}
