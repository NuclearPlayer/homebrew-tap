cask "nuclear" do
  arch arm: "aarch64", intel: "x64"

  version "1.48.0"
  sha256 arm:   "63a93c7cb1f5dd51bbd55719bd2165e1f9bee48e8d61d677e7cb419ca956a1fa",
         intel: "7dae2b6cd0453537578234f7935a24093f0e53b4119ab7573d1635c1990b6edf"

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
