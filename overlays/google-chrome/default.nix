_: _final: prev: {
  google-chrome = prev.google-chrome.overrideAttrs (prevAttrs: {
    postFixup = ''
      makeWrapper ${prev.lib.getExe prev.electron_27} $out/bin/${prevAttrs.pname} \
        --set "LOCAL_GIT_DIRECTORY" ${prev.git} \
        --add-flags $out/share/${prevAttrs.pname}/resources/app
    '';
  });
}
