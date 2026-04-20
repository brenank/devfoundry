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
    programs.zsh.enableCompletion = false;
    programs.zsh.promptInit = "";
    users.defaultUserShell = pkgs.zsh;

    programs.zsh.shellInit = ''
      export XDG_CONFIG_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}"
      export XDG_CACHE_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}"
      export XDG_DATA_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}"
      export XDG_STATE_HOME="''${XDG_STATE_HOME:-$HOME/.local/state}"

      export DEVFOUNDRY_SYSTEM_HOME="''${DEVFOUNDRY_SYSTEM_HOME:-/etc/devfoundry}"
      export DEVFOUNDRY_USER_CONFIG_HOME="''${DEVFOUNDRY_USER_CONFIG_HOME:-''${XDG_CONFIG_HOME}/devfoundry}"
      export DEVFOUNDRY_USER_SHARE_HOME="''${DEVFOUNDRY_USER_SHARE_HOME:-''${XDG_DATA_HOME}/devfoundry}"
      export DEVFOUNDRY_SYSTEM_PLUGIN_HOME="''${DEVFOUNDRY_SYSTEM_PLUGIN_HOME:-''${DEVFOUNDRY_SYSTEM_HOME}/plugins}"
      export DEVFOUNDRY_USER_PLUGIN_HOME="''${DEVFOUNDRY_USER_PLUGIN_HOME:-''${DEVFOUNDRY_USER_SHARE_HOME}/plugins}"

      export DEVFOUNDRY_HOME="''${DEVFOUNDRY_USER_SHARE_HOME}"
      export DEVFOUNDRY_DATA_HOME="''${DEVFOUNDRY_USER_SHARE_HOME}"
      export DEVFOUNDRY_PLUGIN_HOME="''${DEVFOUNDRY_USER_PLUGIN_HOME}"
    '';

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
