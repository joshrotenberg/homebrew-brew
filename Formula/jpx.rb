class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.2.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.2.2/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "add62f1f93b10e6d1e563735c0077c83410f8535ffecfaa8ae6c0016ff799020"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.2.2/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "10a8fdf3ba22de1ce6a20b913604475f45b9c4cffbec8dec391c439efb46325a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.2.2/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "467f2b1c6edb6c7ee4993d1d2efb0bde352722cd16047bbcc5a1e9dc98d46349"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
