{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.${namespace}.desktop.android-dev;
  defaultJdk = pkgs.openjdk17;
  toolchains = [
    pkgs.openjdk11
    pkgs.openjdk22
    defaultJdk
  ];
  mapOpenJdk = pkg: "${pkg}/lib/openjdk";
in
{
  options.${namespace}.desktop.android-dev = {
    enable = mkEnableOption "Configure a development environment for Android apps";
  };
  config = mkIf cfg.enable {
    users.users.yash.packages = with pkgs; [
      android-tools
      androidStudioPackages.stable
      androidStudioPackages.beta
      apktool
      flutter
      kotlin
      scrcpy
      maestro
    ];

    programs = {
      adb.enable = true;
      java = {
        enable = true;
        package = defaultJdk;
        binfmt = false;
      };
      nix-ld = {
        enable = true;
        package = pkgs.nix-ld-rs;
        libraries = with pkgs; [
          icu
          openssl
          stdenv.cc.cc
          zlib
        ];
      };
    };

    snowfallorg.users.yash.home.config = {
      programs.gradle = {
        enable = true;
        settings = {
          "org.gradle.caching" = true;
          "org.gradle.parallel" = true;
          "org.gradle.jvmargs" = "-XX:MaxMetaspaceSize=1024m -XX:+UseG1GC";
          "org.gradle.java.home" = mapOpenJdk defaultJdk;
          "org.gradle.java.installations.auto-detect" = false;
          "org.gradle.java.installations.auto-download" = false;
          "org.gradle.java.installations.paths" = lib.concatMapStringsSep "," mapOpenJdk toolchains;
        };
      };
    };
  };
}
