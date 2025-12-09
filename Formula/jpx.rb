class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.7"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.7/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "a155dd58bfb32fc09572c132d7b907a86af57909028af0121df679f5892e7e44"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.7/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "64fad91032dade8e53f3fb10ca9bd4e68d0635f09c9b5bb7894bd3eb2aed43c6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.7/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1747077e4460c679e3f893e43f2d6ef43106bf6129b2fc3ce70c97f099d32f27"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
