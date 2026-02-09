class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.4.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.0/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "ceb7836c652404ffccbbd459fed075e9e6d95009554b80097eaa4e8a4a6077c0"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.0/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "97f7b8786efe8e9ae28e4bd18bfe0611f04234f1f94fbad3beb1970af23bacb5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.0/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a7c6b82bf916b0ab25dad316b2294ffdeea31029e5029ccd79dbb403e78ca05b"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
