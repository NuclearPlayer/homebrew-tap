cask "nuclear" do
  arch arm: "aarch64", intel: "x64"

  version "1.54.2"
  sha256 arm:   "d0a0b03a5aa601b4f0a5a8613e423cc6047515e274edf3a53ca35d2d3a284337",
         intel: "d4669f6448f2f65215f7bf966e2d98d144b248e19b7e4e06f5d1a90f0e9f958b"

  url "https://github.com/nukeop/nuclear/releases/download/player%40#{version}/Nuclear_#{version}_#{arch}.dmg"
  name "Nuclear"
  desc "Streaming music player"
  homepage "https://nuclearplayer.com/"

  livecheck do
    url "https://github.com/nukeop/nuclear/releases/latest"
    regex(%r{/player@(\d+(?:\.\d+)+)}i)
    strategy :header_match
  end

  depends_on :macos

  app "Nuclear.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Nuclear.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.nuclearplayer",
    "~/Library/Caches/com.nuclearplayer",
    "~/Library/Logs/com.nuclearplayer",
    "~/Library/WebKit/com.nuclearplayer",
  ]
end
