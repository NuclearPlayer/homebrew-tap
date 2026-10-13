cask "nuclear" do
  arch arm: "aarch64", intel: "x64"

  version "1.51.0"
  sha256 arm:   "2720622aacaf2460102ddd9e687bb5a4baef9e476c9823d4de2c0a280a6211c0",
         intel: "5afa60cafed969bf82b641a1e5bf9cb4384487056b4ca190c99a4092dad81664"

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
