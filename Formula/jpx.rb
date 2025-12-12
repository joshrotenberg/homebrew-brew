class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.9"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.9/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "fdfd36a039244ac12e9ce468c97c0bc9b7db5371212883f608417c1d642b3001"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.9/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "d26f97e355aa67a37fd110cfacd57608a1527aa51526d0cee67732842022dd2e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.9/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "66a720b6cab4a14cd3fdc952875e9d7fc6ee38f15bcf86d9a9eed818ad29accf"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
