class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.8"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.8/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "e7850bbb4c01fde86fabf81ff6232dd872425edb88b8d8dc0aa647c8bdd2c106"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.8/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "7cfb6823f958a16f7e777b6ac7fd2e0d470881a2117577aef57a899678e4f7fa"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.8/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f5b7c70881817c21aac55e5f4822e9edbcb063d802dfd59453e2d9df2095355b"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
