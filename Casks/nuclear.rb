cask "nuclear" do
  arch arm: "aarch64", intel: "x64"

  version "1.52.2"
  sha256 arm:   "5f36400e35ebedfceef2a524931d6c6f0e2ef52db00e5d7edc3510ac0f71f44a",
         intel: "1271c98b7dd66a9591ee7e249fec5dc32c0baf77728a6d27f3d7c00ad326a2ea"

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
