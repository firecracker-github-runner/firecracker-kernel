{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  # env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [ pkgs.git pkgs.deno ];

  # https://devenv.sh/scripts/
  # scripts.hello.exec = "echo hello from $GREET";

  scripts.docker-build.exec = "docker buildx build --platform linux/amd64 . -t firecracker-kernel-working";
  scripts.docker-run.exec = ''
    mkdir -p ./dist
    mkdir -p ./working
    docker run -it --rm \
      -v ./src:/working/src:ro \
      -v ./dist:/working/dist:rw \
      -v ./working:/working/working:rw \
      -v ./.deno-cache:/home/builder/.cache/deno:rw \
      firecracker-kernel-working
  '';

  enterShell = ''
    git --version
    deno --version
  '';

  # https://devenv.sh/languages/
  # languages.nix.enable = true;

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  # See full reference at https://devenv.sh/reference/options/
}