class MdbookLint < Formula
  desc "Fast markdown linter for mdBook projects"
  homepage "https://github.com/joshrotenberg/mdbook-lint"
  url "https://github.com/joshrotenberg/mdbook-lint/archive/refs/tags/v0.16.0.tar.gz"
  sha256 "0e2b15b7ef637a2389867b0a221d702c84327f23b751db022f9bf5a1ae5d805e"
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
