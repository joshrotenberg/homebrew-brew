class MdbookLint < Formula
  desc "Fast markdown linter for mdBook projects"
  homepage "https://github.com/joshrotenberg/mdbook-lint"
  url "https://github.com/joshrotenberg/mdbook-lint/archive/refs/tags/v0.11.7.tar.gz"
  sha256 "59c7d26463495459ba9beadd4f419f096689f2041131eb8662e153e581c38255"
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
