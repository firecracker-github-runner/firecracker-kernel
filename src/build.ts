import { parse } from "$std/yaml/mod.ts";

interface VersionsYaml {
  firecracker: string;
  kernel: { [track: string]: string };
}

async function main() {
  const versions = parse(
    Deno.readTextFileSync("./versions.yaml"),
  ) as VersionsYaml;
  console.log(versions);
  const firecrackerVersion = versions.firecracker;

  for (const track in versions.kernel) {
    const outputPath = `./dist/vmlinux-${track}.bin`;
    const workingDir = `./working/${track}`;

    const cmd = new Deno.Command("./src/build.sh", {
      args: [
        versions.kernel[track],
        firecrackerVersion,
        workingDir,
        outputPath,
      ],
    });
    await cmd.spawn().output();
  }
}

main();
