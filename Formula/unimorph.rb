class Unimorph < Formula
  desc "Complete toolkit for working with UniMorph morphological data"
  homepage "https://github.com/joshrotenberg/unimorph-rs"
  url "https://github.com/joshrotenberg/unimorph-rs/archive/refs/tags/unimorph-v0.1.7.tar.gz"
  sha256 "27b29747d3078ac2b432f30087d65faa4fa9a679d0b7d2e5e69c4ae4095c01f9"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    cd "crates/unimorph-cli" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match "unimorph #{version}", shell_output("#{bin}/unimorph --version")
    assert_match "download", shell_output("#{bin}/unimorph --help")
  end
end
