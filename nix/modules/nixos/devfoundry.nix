{ config, lib, pkgs, ... }:
let
  sharedRoot = ../../../shared/devfoundry;
in
{
  options.devfoundry.enable = lib.mkEnableOption "devfoundry shared developer defaults";

  config = lib.mkIf config.devfoundry.enable {
    environment.systemPackages = with pkgs; [
      git
      zsh
      chezmoi
      neovim
      zsh-powerlevel10k
      zsh-autosuggestions
      zsh-completions
      zsh-syntax-highlighting
    ];

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    environment.etc."devfoundry".source = sharedRoot;

    environment.etc."gitconfig".text = ''
      [include]
          path = /etc/devfoundry/git/base.gitconfig

      [include]
          path = /etc/devfoundry/git/aliases.gitconfig
    '';

    programs.zsh.loginShellInit = ''
      [[ -r /etc/devfoundry/zsh/load-profile.zsh ]] && source /etc/devfoundry/zsh/load-profile.zsh
    '';

    programs.zsh.interactiveShellInit = ''
      export DEVFOUNDRY_POWERLEVEL10K_THEME="${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
      export DEVFOUNDRY_ZSH_AUTOSUGGESTIONS="${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
      export DEVFOUNDRY_ZSH_SYNTAX_HIGHLIGHTING="${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
      export DEVFOUNDRY_ZSH_COMPLETIONS_DIR="${pkgs.zsh-completions}/share/zsh/site-functions"
      [[ -r /etc/devfoundry/zsh/load-rc.zsh ]] && source /etc/devfoundry/zsh/load-rc.zsh
    '';
  };
}
