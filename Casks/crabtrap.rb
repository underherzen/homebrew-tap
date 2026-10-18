# Шаблон cask: 0.1.0, c6ccbfa69d88df71ccc0c4dd7005fdffbb1314c6951fd081b4b1819cdac641f7, underherzen/crabtrap подставляет .github/workflows/homebrew.yml.
cask "crabtrap" do
  version "0.1.0"
  sha256 "c6ccbfa69d88df71ccc0c4dd7005fdffbb1314c6951fd081b4b1819cdac641f7"

  url "https://github.com/underherzen/crabtrap/releases/download/v#{version}/crabtrap-#{version}-macos-universal.dmg"
  name "crabtrap"
  desc "HTTP/HTTPS debugging proxy (Charles-like) written in Rust"
  homepage "https://github.com/underherzen/crabtrap"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "crabtrap.app"

  # Сборка не нотаризована (ad-hoc подпись): снимаем карантин, иначе
  # Gatekeeper не даст запустить приложение.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/crabtrap.app"]
  end

  zap trash: "~/Library/Application Support/crabtrap"
end
