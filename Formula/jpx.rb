class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.18"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.18/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "a6bd2386f9e55d921f159da93f139836ff6de02450b2a45034195ecf9a1c4609"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.18/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "be6531d7179a77d4bfecd2fbaa463a89258e300c6d2f0243955977ba85324139"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.18/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "11c4511073049cc7124d524312f6c4da6e11982c76005329ee2e038b72e3fe33"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
