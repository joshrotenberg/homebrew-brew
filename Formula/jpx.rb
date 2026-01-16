class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.17"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.17/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "9aa18de9f794cb5740b29f8b83d3ec99616119af4343c3a58391e17619bbff43"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.17/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "5df63a6b5874842c48c928f17f133eb6c6b7781377fa352108f216d1a8d559c9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.17/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b61dfcb28ef8c80034fe35128d2196e47cfbb66176b1b20c0c46170ee5b449c9"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
