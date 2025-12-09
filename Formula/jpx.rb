class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.6"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.6/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "53dc88675f5b3fd11c36baec2ce12fbdb916eb905b9f3d687a78b50cd61d732a"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.6/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "73802dda29a1ebbf1b50e84ba6220684e657a221d07b41979d1ab6251212a6a9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.6/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "377641537da07c5c3c8c411b6c26ddcc583a3106a917106c4fc8e7bddd116688"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
