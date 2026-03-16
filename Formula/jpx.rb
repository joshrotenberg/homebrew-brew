class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.4.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.4/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "56c7495c29726148ed504e22aa476d69c65b837cbdd91c4c3b260d096d4ef432"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.4/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "d646e94fd747f41d68c836d501de0ba51e49b0bcd4cba9465f3f6cd4454c0422"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.4/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "835caeb537bf0322556fdeea4a8395511dcb1c6a4c2a070d4320e49e56691bbf"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
