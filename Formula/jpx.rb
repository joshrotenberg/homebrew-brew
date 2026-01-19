class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.2.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.2.1/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "f52ce93f72922b8021be032e8373b44ac6eef28440cf6092e630569f2dfa1198"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.2.1/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "cffcc690a6d97c8020e4b0d1e6a7bbda426fa515633064c780c3fe50c0c90f44"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.2.1/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0c2e4885fdc562c4b6b6484ca27b8753f378bf399acad8515fd0058ccfaab98f"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
