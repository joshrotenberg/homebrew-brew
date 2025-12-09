class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.4/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "d20a6c5e3bf24a68b1e15d2f1b08ad3f49a7fe99be42d3161a67e934f3010d5b"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.4/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "459ecd701551563876a19448b0eca6edd4474d3b4518ae745b417522239b931e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.4/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5853cbf91cdc6c1ed02d65517a9d6900706a44b625eaeec57233a12d29b530ce"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
