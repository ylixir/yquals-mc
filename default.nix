with import <nixpkgs> {
  config.allowUnfree=true;
  config.oraclejdk.accept_license=true;
};
[
  curl
  oraclejdk
]
