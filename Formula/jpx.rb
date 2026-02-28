class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.4.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.3/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "620662c774342351c23e3054320382b85bbb61d3fec10cd90f146d6321f53d29"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.3/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "d15ed87318d6abadfc2404f23d33b27d906b5bf7ae90adc924604059dc6d893b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.3/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a3956989fc3521b2fe36ac5e8ea019d65496a283a9243aaa979122925eee4b4"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
