export interface VersionsYaml {
  firecracker: string;
  kernel: { [track: string]: {
    version: string;
    config: string;
  } };
}
