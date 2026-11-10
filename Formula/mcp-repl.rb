class McpRepl < Formula
  desc "Interactive MCP client that turns a server's surface into terminal commands"
  homepage "https://github.com/joshrotenberg/mcp-repl"
  version "0.3.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.10/mcp-repl-aarch64-apple-darwin.tar.gz"
      sha256 "9eaeccaf7f7795eeb8faa3748938374e2b6216f03fb459503410e732b480194e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.10/mcp-repl-x86_64-apple-darwin.tar.gz"
      sha256 "a37b91d1311fef842b82e0f3b5260be5bea45e0a59ce2989f6841ce2e5a7bc5b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.10/mcp-repl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cb528f1852fef213870b5612537783eb8083770d31e567e6792025a68b60fc99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.10/mcp-repl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "85a3b60652200503d8a479a3d714014891fb6dd5ad4e982872f718bbcd9e42ec"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "mcp-repl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mcp-repl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mcp-repl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mcp-repl"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
