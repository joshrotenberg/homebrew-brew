class Unimorph < Formula
  desc "Complete toolkit for working with UniMorph morphological data"
  homepage "https://github.com/joshrotenberg/unimorph-rs"
  url "https://github.com/joshrotenberg/unimorph-rs/archive/refs/tags/unimorph-v0.1.5.tar.gz"
  sha256 "95c1a50b90cb963ea86713f88cd6b6047ee2af43f172f72a848f40a42d8cfc07"
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
