class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.3.0/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "6dbcc2315a68f6b239afface9416a14b9e0a06bb458455c8f4c00cf8f73e1920"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.3.0/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "7f2f011c98df4a78301a4703fad7a6c7a6b48f21023def79d2461eec31f33df5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.3.0/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "48f83815b8c77b4ef9a53bccd4c51e2df7e547b50eee744bc60fd71f454eca0d"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
