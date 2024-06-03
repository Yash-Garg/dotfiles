{pkgs, ...}: {
  programs.eza = {
    enable = true;
    icons = false;
    extraOptions = ["--all" "--git-ignore"];
  };
}
