class Jpx < Formula
  desc "JMESPath CLI with 150+ extended functions - a powerful jq alternative"
  homepage "https://github.com/joshrotenberg/jmespath-extensions"
  version "0.1.15"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.15/jpx-aarch64-apple-darwin.tar.xz"
      sha256 "cc8ed24e0c01b2215bed28042ff8fc1fcb48904d68b06d1f8443211e941930ce"
    end
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.15/jpx-x86_64-apple-darwin.tar.xz"
      sha256 "9b68d6529990bf4488cc055909d218c1149dfebef153b17caf7a8f057b352782"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/jmespath-extensions/releases/download/jpx-v0.1.15/jpx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f70cb09d23710867f8d7c645329c7dff6819d2193b328479f0ab6281986aba46"
    end
  end

  def install
    bin.install "jpx"
  end

  test do
    assert_match "jpx", shell_output("#{bin}/jpx --version")
  end
end
