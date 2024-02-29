_: {
  programs.git = {
    enable = true;
    ignores = [
      "key.properties"
      "keystore.properties"
      "*.jks"
      ".direnv/"
      ".DS_Store"
      ".vscode/"
      ".idea/"
    ];
    includes = [
      {path = "$HOME/.gitconfig";}
    ];
  };
}
