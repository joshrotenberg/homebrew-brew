class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.14"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.14/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "c6fd82ac33b41b47df01518e66b643e2105ab637fe2c6d9f58d0f039f112c36d"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.14/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "fc0e5973ab0c1f20ab302508a93b023c92daa43e9f4cf5777b1822b1db3a9756"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.14/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff36092e42d3f6f55d3593247f8e20bb4ed0c030d6c9c8456a08c3387103bf5b"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
