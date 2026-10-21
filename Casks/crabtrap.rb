cask "crabtrap" do
  version "0.2.1"
  sha256 "c4e8ad52fb7d4b5858f9f5b116d68598d1a8b80fbc139afffe6ee95c76d49abc"

  url "https://github.com/underherzen/crabtrap/releases/download/v#{version}/crabtrap-#{version}-macos-universal.dmg"
  name "crabtrap"
  desc "HTTP/HTTPS debugging proxy (Charles-like) written in Rust"
  homepage "https://github.com/underherzen/crabtrap"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "crabtrap.app"

  # Not notarized (ad-hoc signature): drop quarantine so Gatekeeper lets it launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/crabtrap.app"]
  end

  zap trash: "~/Library/Application Support/crabtrap"
end
