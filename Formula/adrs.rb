class Adrs < Formula
  desc "Architectural Decision Record tool in Rust"
  homepage "https://joshrotenberg.com/adrs/"
  url "https://github.com/joshrotenberg/adrs/archive/refs/tags/v0.2.9.tar.gz"
  sha256 "04365b971f0ae8d2efd18dfd6f67f7881a82b3fdccf0a74fc44a71c7ee5b0251"
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
