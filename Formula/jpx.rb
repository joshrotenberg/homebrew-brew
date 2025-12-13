class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.12"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.12/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "0ee2332acc627caa0ac10425919617edaf05c69244e040d0323cc920b22eea0f"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.12/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "f8828e585c4cafa59419f521f59d0096af5bd3aec06a822d758bcf743cebe120"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.12/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d25c8f44417aad7b619d734f45d8fe3037be9064e8fc0aa9e7f2c457aaf6b309"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
