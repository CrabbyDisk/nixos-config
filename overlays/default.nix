{inputs, ...}: {
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    prismlauncher = prev.prismlauncher.override {
      jdks = [graalvm-ce];
      additionalLibs = [wayland libxkbcommon];
    };

  }
}
