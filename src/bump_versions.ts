import * as semver from "@std/semver";
import * as yaml from "@std/yaml";
import { isDeepStrictEqual } from "node:util";
import { VersionsYaml } from "./types.ts";

interface KernelReleasesPartial {
  releases: { version: string }[];
}

async function getFirecrackerVersion(): Promise<string> {
  const res = await fetch(
    "https://api.github.com/repos/firecracker-microvm/firecracker/releases/latest",
  );
  const json = await res.json();
  if (json.tag_name == null || json.tag_name.length === 0) {
    throw new Error("Received empty tag_name for firecracker from GitHub releases API");
  }
  return json.tag_name;
}

async function getAvailableKernelReleases(): Promise<string[]> {
  const res = await fetch(
    `https://www.kernel.org/releases.json`,
  );
  const json: KernelReleasesPartial = await res.json();
  const versions = json.releases.filter((release) =>
    // Exclude release candidates;. Semver doesn't support them, and we don't want them.
    !release.version.includes("-")
  ).map((release) =>
    // semver doesn't support x.y versions, so we add a .0 to them.
    // TODO: Maybe just don't use semver parsing...
    release.version.split(".").length === 2
      ? `${release.version}.0`
      : release.version
  ).map((version) => semver.parse(version));

  versions.sort(semver.compare);
  return versions.map((version) => semver.format(version));
}

function getLatestKernelVersion(
  track: string,
  sortedReleases: string[],
): string {
  const latestVersion =
    sortedReleases.find((release) => release.startsWith(track)) ?? null;
  if (latestVersion === null) {
    throw new Error(`No release found for track ${track}`);
  }
  return latestVersion;
}

async function main() {
  const oldVersions = yaml.parse(
    Deno.readTextFileSync("./versions.yaml"),
  ) as VersionsYaml;
  const kernelTracks = Object.keys(oldVersions.kernel);

  const [firecrackerVersion, sortedReleases] = await Promise.all([
    getFirecrackerVersion(),
    getAvailableKernelReleases(),
  ]);

  const newVersions: VersionsYaml = {
    firecracker: firecrackerVersion,
    kernel: Object.fromEntries(
      kernelTracks.map((
        track,
      ) => [track, {
        version: getLatestKernelVersion(track, sortedReleases),
        config: oldVersions.kernel[track].config,
      }]),
    ),
  };
  console.log("Found versions:", newVersions);

  if (isDeepStrictEqual(oldVersions, newVersions)) {
    console.log("Versions are the same, not updating");
  } else {
    Deno.writeTextFileSync(
      "./versions.yaml",
      // deno-lint-ignore no-explicit-any
      yaml.stringify(newVersions as any),
    );
  }
}

main();
