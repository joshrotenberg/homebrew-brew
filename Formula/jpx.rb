class Jpx < Formula
  desc "JMESPath CLI with 400+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jpx"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.3.0/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "f5172e8ef8171608420a1306b9e7e9f9b32c902c576754248e458879c77ebb77"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.3.0/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "24e96e4f3d1aba1b6164b56fc7aea71ca7323fc1a236fd483df64736e84e7c80"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jpx/releases/download/jpx-v0.3.0/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0cc6522557fbdc58b923320547aff1998ea8e1296bc0f8275a9287ca2122acd4"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
