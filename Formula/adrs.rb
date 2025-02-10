class Adrs < Formula
  desc "Architectural Decision Record tool in Rust"
  homepage "https://joshrotenberg.com/adrs/"
  url "https://github.com/joshrotenberg/adrs/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "5faf0fa42fa51ed94bc1d59fbc02f213b5e670d9238d38fe989a9144acfb33b5"
  license "Apache-2.0"

  depends_on "cmake" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    file = "0001-record-architecture-decisions.md"
    assert_match file, shell_output("#{bin}/adrs init")
    assert_match file, shell_output("#{bin}/adrs list")
  end
end
