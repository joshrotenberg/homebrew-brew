class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.0/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "c5df4ba6786051e236b3c9d56e334ed3470c7a2c593bf1f12e79d68474be7d93"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.0/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "91b9e41bdadd25b9d3fa1bd98cef92119fd00c9814d2b709d4ca4df229aa5978"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.0/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e4df84b6efa3025d3079de01e039215a6a357c7ec2b7e685f356e10ae20b1a25"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
