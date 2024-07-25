{
  config,
  pkgs,
  ...
}: let
  username = "kbiawat";
  fullname = "Karan Biawat";
  samlConfig = name: saml: ''
    [${name}]
      name                    = ${name}
      url                     = https://marketaxess.okta.com/home/amazon_aws/${saml}/272
      username                = ${username}
      provider                = Okta
      mfa                     = DUO
      aws_urn                 = urn:amazon:webservices
      aws_session_duration    = 36000
      aws_profile             = default
      region                  = us-east-1
      saml_cache              = false
      disable_remember_device = false
      disable_sessions        = false
  '';
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      hello
      # # You can install more packages by adding them to the list.
      ansible
      awscli2
#      containerd
      curl
      direnv
      dive
      dos2unix
#      docker #check docker-setup function, installing directly
      fzf
      git
      go
      gnugrep
      gum
      htop
      jfrog-cli
      jq
      k9s
      kubectl
      kubelogin-oidc
      kubectx
      kubernetes-helm
#      nerdctl
#      nix-zsh-completions
      oh-my-zsh
      poetry
      pipx
#      pre-commit
      python312
#      python311Packages.pip
#      runc
      saml2aws
#      slirp4netns
      stow
      tenv
      tflint
      tfsec
#      terraform
      terraform-docs
      tree
#      vim
#      wslu
      yamllint
      xdg-utils
#      zsh # caused some drv file issue and then omz was not able to update hence install sudo apt install zsh
      zsh-autosuggestions #zsh-autocomplete don't need it as suggestions ones works
      zsh-syntax-highlighting #makes better whilst typing on shell
      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. If you don't want to manage your shell through Home
    # Manager then you have to manually source 'hm-session-vars.sh' located at
    # either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/kbiawat/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      # EDITOR = "emacs";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

#    zsh = {
#      enable = true;
#      autocd = true;
#      enableCompletion = true;
#      autosuggestion.enable = true;
#      dotDir = ".config/zsh";
#      oh-my-zsh = {
#        enable = true;
#      };
#    };

    #direnv = {
    #  enable = true;
    #  enableBashIntegration = true;
    #  nix-direnv.enable = true;
    #};

  };  
}
