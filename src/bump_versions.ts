import { equal } from "$equal/mod.ts";
import * as semver from "$std/semver/mod.ts";
import * as yaml from "$std/yaml/mod.ts";
import { VersionsYaml } from "./types.ts";

interface KernelReleasesPartial {
  releases: { version: string }[];
}

async function getFirecrackerVersion(): Promise<string> {
  const res = await fetch(
    "https://api.github.com/repos/firecracker-microvm/firecracker/releases/latest",
  );
  const json = await res.json();
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
  ).map((release) => semver.parse(release.version));
  return semver.sort(versions).map((version) => semver.format(version));
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
      ) => [track, getLatestKernelVersion(track, sortedReleases)]),
    ),
  };
  console.log("Found versions:", newVersions);

  if (equal(oldVersions, newVersions)) {
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
