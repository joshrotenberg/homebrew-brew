class McpRepl < Formula
  desc "Interactive MCP client that turns a server's surface into terminal commands"
  homepage "https://github.com/joshrotenberg/mcp-repl"
  version "0.3.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.7/mcp-repl-aarch64-apple-darwin.tar.gz"
      sha256 "c6be31e08ed9cc938d2adba04868ab93276b63e9c5be0ef7066f150815488656"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.7/mcp-repl-x86_64-apple-darwin.tar.gz"
      sha256 "0233bfc6ebaf21074ef908eaa6e722430597e4db31f10f8bb874d9219c4b4e73"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.7/mcp-repl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0b5782e41c9d8d136a632e8faf3923e2490635507d8016736f28a1e8dc0b4a7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.7/mcp-repl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a28c15339b52767d399fcea6398b3a1bba09d07535f68effa7920c4b8fee1ae9"
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
