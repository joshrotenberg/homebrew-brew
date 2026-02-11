class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.4.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.1/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "d466c25e5f42790ae834bd78aea92aec28dec75afd9a8da99b71fca2e8bf1f7b"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.1/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "d22830e14c73949f2de36126c876c1f92098049b66b3593039c0d347b17ddcfc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.1/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d6dabaf6f68c38670a7ddaf253c17b34a5df86c1297734884107318c4448580e"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
