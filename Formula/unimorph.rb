class Unimorph < Formula
  desc "Complete toolkit for working with UniMorph morphological data"
  homepage "https://github.com/joshrotenberg/unimorph-rs"
  url "https://github.com/joshrotenberg/unimorph-rs/archive/refs/tags/unimorph-v0.1.4.tar.gz"
  sha256 "e7dd607d5d4f8c10b4ca3f82979d32fd28dee55f288a2ec81c292f59fb74c342"
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
