class MdbookLint < Formula
  desc "Fast markdown linter for mdBook projects"
  homepage "https://github.com/joshrotenberg/mdbook-lint"
  url "https://github.com/joshrotenberg/mdbook-lint/archive/refs/tags/v0.15.2.tar.gz"
  sha256 "f8f6ea4ce3a96d8faabcae485e765df5488b48484119772c28978edf4a1437a2"
  license "MIT"

  depends_on "rust" => :build

  def install
    cd "crates/mdbook-lint-cli" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match "mdbook-lint #{version}", shell_output("#{bin}/mdbook-lint --version")
    assert_match "MD001", shell_output("#{bin}/mdbook-lint rules")
  end
end
