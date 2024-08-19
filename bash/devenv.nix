{ pkgs, lib, config, inputs, ... }:

{
  packages = with pkgs; [ nodePackages.bash-language-server ];
}
