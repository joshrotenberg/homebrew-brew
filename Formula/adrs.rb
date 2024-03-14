class Adrs < Formula
  desc "Architectural Decision Record tool in Rust"
  homepage "https://joshrotenberg.com/adrs/"
  url "https://github.com/joshrotenberg/adrs/archive/refs/tags/v0.2.8.tar.gz"
  sha256 "91ba1a7232ea98b7c7bc32c4c2433e6aa504edcff3cfcebe6c9b21c51b5b93b8"
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
