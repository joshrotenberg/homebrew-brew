class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.2.0/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "b4b19151de6d92e1bf70bb5438d8316162f26e097b02135f5be372c849701056"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.2.0/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "0cf4e312128a4eeed4ce59ffca7e67efb3613ca915feffce7dbc5d7d7d200d34"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.2.0/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "faa3674d772cbf29be3a73fb45e3b94ce3fc3f6887501422dade132f913e14b9"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
