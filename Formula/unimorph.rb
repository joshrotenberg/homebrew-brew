class Unimorph < Formula
  desc "Complete toolkit for working with UniMorph morphological data"
  homepage "https://github.com/joshrotenberg/unimorph-rs"
  url "https://github.com/joshrotenberg/unimorph-rs/archive/refs/tags/unimorph-v0.1.8.tar.gz"
  sha256 "9eac1d3aefaf19bc25e0fc63014a799847fa85a25f5fa05470df5669a1d9415b"
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
