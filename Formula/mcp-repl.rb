class McpRepl < Formula
  desc "Interactive MCP client that turns a server's surface into terminal commands"
  homepage "https://github.com/joshrotenberg/mcp-repl"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.5.0/mcp-repl-aarch64-apple-darwin.tar.gz"
      sha256 "8934265e7e511935770575d36fe4d2ddff5505d9ec9b1fb4963ae8d1180733d8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.5.0/mcp-repl-x86_64-apple-darwin.tar.gz"
      sha256 "799a9fe149ba08458c838c030ed22a76e3393c84cead413df461eafe8de9cca4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.5.0/mcp-repl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "48f44749e6338da5b79bbfa7fcbd36755a3813d4dba979a096cd3dc1c9216d4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.5.0/mcp-repl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3ca5087a1b419ec43ae1613e94ec83f23c30bab9d8c01b751fa80b9369265da7"
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
