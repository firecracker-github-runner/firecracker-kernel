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
  const outputFilenames: string[] = [];

  for (const track in versions.kernel) {
    const outputFilename = `vmlinux-${track}.bin`;
    outputFilenames.push(outputFilename);

    const outputPath = `./dist/${outputFilename}`;
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

  const cmd = new Deno.Command("sha256sum", {
    args: outputFilenames,
    cwd: "./dist",
    clearEnv: true,
    stdout: "piped",
  });
  const checksums = await cmd.spawn().output();
  const checksumsText = new TextDecoder().decode(checksums.stdout);
  console.log("CHECKSUMS");
  console.log(checksumsText);

  Deno.writeFileSync("./dist/checksums.txt", checksums.stdout);
}

main();
