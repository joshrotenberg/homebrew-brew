class MdbookLint < Formula
  desc "Fast markdown linter for mdBook projects"
  homepage "https://github.com/joshrotenberg/mdbook-lint"
  url "https://github.com/joshrotenberg/mdbook-lint/archive/refs/tags/v0.13.1.tar.gz"
  sha256 "aa12f816bea00228a390f87f359b07651c37528f9bcda35ca0ec7685def10337"
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
