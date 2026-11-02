class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.5.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.5.2/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "17412aa952ded6919ecf76c00cf8675a301105ed5a97bf0e22291c5d1085379d"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.5.2/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "a485d185cb15c844035dbfe0f2e0334af8e02f68ea0119a708b9c246b67ae038"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.5.2/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4d31b508d48fa82a8e7e5c37aca0954fe4dc81ad2b17e0ec6822c9c272a46837"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
