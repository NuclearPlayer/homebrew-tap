cask "nuclear" do
  arch arm: "aarch64", intel: "x64"

  version "1.47.1"
  sha256 arm:   "a775aa5ab00c6b9d38bbb85280808eb2ace62510e7ed419f1b14f7fecf88ec2e",
         intel: "b316d666509eaded9573f820f30a0f6093b3311d267c9a3aa616b3011e5f3e28"

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
