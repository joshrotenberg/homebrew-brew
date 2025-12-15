class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.13"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.13/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "31678181a07452674d054b63df6ddf3b6cdfaa5b6ef764c24f720eb51b118e33"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.13/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "c8fbf108480cb57744cd5626e9ff755c1c19b954160ca14dc7cc56f085b7a7ce"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.13/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "872b564396dae60aedea45b3846aa21ece6dbd98a1e152d2c39ff420f9d5d71a"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
