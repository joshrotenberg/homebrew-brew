class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.11"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.11/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "f67200b58e23fab7bafea35a00176fc88be845985a20e486eae253dcbd40c1ab"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.11/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "7ddb877eb2de101d756a4ef6f71e7acc8c03a8bd9e580ac58289ec814202a6e0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.11/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "50dbc643cfd2f98c64ce901c3ddf23acfb4208fdb9e0bdce9fe877c8ff8f64d1"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
