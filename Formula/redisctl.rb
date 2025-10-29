class Redisctl < Formula
  desc "Unified CLI tool for managing Redis Cloud and Redis Enterprise deployments"
  homepage "https://github.com/joshrotenberg/redisctl"
  version "0.6.6"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/joshrotenberg/redisctl/releases/download/redisctl-v0.6.6/redisctl-aarch64-apple-darwin.tar.xz"
      sha256 "c2e5bdfd36d30842a104e6439391ac63987c7d2307cf26e4351da99254f1e47a"
    end
    on_intel do
      url "https://github.com/joshrotenberg/redisctl/releases/download/redisctl-v0.6.6/redisctl-x86_64-apple-darwin.tar.xz"
      sha256 "72ae0367429fd9e8c2f1718d806ea4ed2477058c5143419276da1e3b651a04db"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joshrotenberg/redisctl/releases/download/redisctl-v0.6.6/redisctl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2f84884e3a59fec3eb589f5b9c4f6906e74c320fa9901a8e93ccf8ff99be8602"
    end
  end

  def install
    bin.install "redisctl"
  end

  test do
    assert_match "redisctl", shell_output("#{bin}/redisctl --version")
  end
end
