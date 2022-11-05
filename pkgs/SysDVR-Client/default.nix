{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages,
  ffmpeg_5,
  SDL2,
  # usb streaming
  libusb1,
  # for the builtin player
  pulseaudio,
  libGL,
}:
buildDotnetModule rec {
  pname = "SysDVR-Client";
  version = "1b3b44609620c406588e181a38ebaf1d4bb619f6";

  src =
    fetchFromGitHub {
      owner = "exelix11";
      repo = "SysDVR";
      rev = "${version}";
      hash = "sha256-SYVipagklX27IWRQiL12ct/Lr8LP5tJUgQhG62iqHZE=";
      name = "${pname}-git-${version}";
    }
    + "/Client";

  dotnet-runtime = dotnetCorePackages.runtime_6_0;
  dotnet-sdk = dotnetCorePackages.sdk_6_0;

  nugetDeps = ./deps.nix;
  runtimeDeps = [ffmpeg_5 SDL2 libusb1 pulseaudio libGL];
  dotnetFlags = ["--runtime linux-x64"];

  executables = ["SysDVR-Client"];

  meta = with lib; {
    description = "Stream switch games to your PC via USB or network";
    homepage = "https://github.com/exelix11/SysDVR";
    license = licenses.gpl2;
    maintainers = [maintainers.maddiethecafebabe];
    platforms = ["x86_64-linux"];
  };
}
