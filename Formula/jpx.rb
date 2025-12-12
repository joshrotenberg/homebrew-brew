class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.10"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.10/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "f7d30cbfa12bb09bc44a24082478be5fadd5f37c45d5506d3e5de1d5af980f71"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.10/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "2df1d91fcb15016e0cc5d9c8b3d897dd55f636e1310476245ebaa3d0a326f7f0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.10/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d5772bcae8f5c75d5d938423e69c7b0ec9edfeeb8bd630b4374d2e018b4edc64"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
