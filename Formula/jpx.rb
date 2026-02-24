class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.4.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.2/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "936660a780a07b820fbc3be4e9fac11dc0faf5c135ec988e6cce085d236398da"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.2/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "90ebc03139401c5596bb0ee15008023bd3b16b61905f919b1d2daeb01c2df9a1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.4.2/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "260032e8f9ab81fc39a2858cc022def46e6d3a7af1d8f2c46f2ead4fed5e9cf7"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
