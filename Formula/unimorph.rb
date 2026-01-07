class Unimorph < Formula
  desc "Complete toolkit for working with UniMorph morphological data"
  homepage "https://github.com/joshrotenberg/unimorph-rs"
  url "https://github.com/joshrotenberg/unimorph-rs/archive/refs/tags/unimorph-v0.1.6.tar.gz"
  sha256 "0a096468494771ad935e2af5f6804315af40cd38e0ede4394e5ecae59379cff1"
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
