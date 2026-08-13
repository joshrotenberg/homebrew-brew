class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.5.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.5.1/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "92e7da4de62c354c602eb9190d2338a23183bb0ca9d3e606e9cc24efcd7819cb"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.5.1/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "96ed12f09c1152f3825e6d87a7779430a5f81cbb34a82e14e1198c4f171c8dad"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.5.1/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8414deec802c7a3d8750cf50575e5a2022ceed7d2cf322624351b27a9efaf65f"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
