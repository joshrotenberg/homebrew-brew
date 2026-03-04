class MdbookLint < Formula
  desc "Fast markdown linter for mdBook projects"
  homepage "https://github.com/joshrotenberg/mdbook-lint"
  url "https://github.com/joshrotenberg/mdbook-lint/archive/refs/tags/v0.14.3.tar.gz"
  sha256 "a47c0213f462decd8f4a701db8e0c5a82f1f12a2a485030bb9828dc3a27a56b0"
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
