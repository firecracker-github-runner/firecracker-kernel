export interface VersionsYaml {
  firecracker: string;
  kernel: { [track: string]: string };
}
