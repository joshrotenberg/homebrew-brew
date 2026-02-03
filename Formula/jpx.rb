class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.3.0/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "6416ef830eda5a92584b28cf084efc2fdac08d614397cbb760724daff012e3bd"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.3.0/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "635db5fb9f4f77cde6248548f7c3ee7dd2fcbe133f5691c78de7e570028c8c4f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.3.0/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4638bd34fbf4420731cdc0357ebbe31ec1e8fa77f1f376037c22e20cb7b9e5cc"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
