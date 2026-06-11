class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.5.0/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "a2ef6765e3f2fb4cd8f33f1d8c1c86b837aa98dbaf0a0050b00cafd8721dca91"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.5.0/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "346be6b2443c65a44b1abce1238b34ff02598172acb49bf4a4cd418f47ed35f9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.5.0/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "555f0f6fdb7033e5672a85870a35fbfa42e5cae3e0b362ecd9a7dfbd64e260eb"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
