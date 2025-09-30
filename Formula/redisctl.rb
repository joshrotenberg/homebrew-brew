class Redisctl < Formula
  desc "Unified CLI tool for managing Redis Cloud and Redis Enterprise deployments"
  homepage "https://github.com/joshrotenberg/redisctl"
  url "https://github.com/joshrotenberg/redisctl/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "5a611eca1ff7639c1e88af6b0dd64d631aa0f8f61accff24b3f5aef2a0ee457f"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "rust" => :build

  def install
    cd "crates/redisctl"
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "redisctl", shell_output("#{bin}/redisctl --version")
  end
end
