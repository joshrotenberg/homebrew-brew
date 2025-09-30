class Redisctl < Formula
  desc "Unified CLI tool for managing Redis Cloud and Redis Enterprise deployments"
  homepage "https://github.com/joshrotenberg/redisctl"
  version "0.6.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/redisctl/releases/download/v0.6.2/redisctl-aarch64-apple-darwin.tar.xz"
      sha256 "47982ee2ad900c695890be68978cceeb65d628ae2fbb553f248918f309b595a6"
    end
    on_intel do
      url "https://github.com/joshrotenberg/redisctl/releases/download/v0.6.2/redisctl-x86_64-apple-darwin.tar.xz"
      sha256 "d54236b32bfa1547ae079a54f6eff52924d69c35c887beb1c08606467249d80e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/redisctl/releases/download/v0.6.2/redisctl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8b6756048991ba7c3cacde0bf9c972eb6d783572622467314ef9d863fb143325"
    end
  end

  def install
    bin.install "redisctl"
  end

  test do
    assert_match "redisctl", shell_output("#{bin}/redisctl --version")
  end
end
