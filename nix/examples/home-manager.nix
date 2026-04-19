{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
    zsh
    chezmoi
    neovim
  ];

  programs.zsh.enable = true;

  home.file.".local/share/devfoundry".source = ../../shared/devfoundry;
  home.file.".gitconfig".text = builtins.readFile ../../home/dot_gitconfig;
  home.file.".zshenv".text = builtins.readFile ../../home/dot_zshenv;
  home.file.".zprofile".text = builtins.readFile ../../home/dot_zprofile;
  home.file.".zshrc".text = builtins.readFile ../../home/dot_zshrc;
}
