import { parse } from "$std/yaml/mod.ts";
import { VersionsYaml } from "./types.ts";

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
    const result = await cmd.spawn().output();
    if (result.code !== 0) {
      console.log("BUILD FAILED");
      Deno.exit(result.code);
    }
  }

  const cmd = new Deno.Command("/usr/bin/sha256sum", {
    args: outputFilenames,
    cwd: "./dist",
    clearEnv: true,
    stdout: "piped",
  });
  const checksums = await cmd.spawn().output();
  if (checksums.code !== 0) {
    console.log("CHECKSUMS FAILED");
    Deno.exit(checksums.code);
  }

  const checksumsText = new TextDecoder().decode(checksums.stdout);
  console.log("CHECKSUMS");
  console.log(checksumsText);

  Deno.writeFileSync("./dist/checksums.txt", checksums.stdout);
  Deno.copyFileSync("./versions.yaml", "./dist/versions.yaml");
}

main();
