class McpRepl < Formula
  desc "Interactive MCP client that turns a server's surface into terminal commands"
  homepage "https://github.com/joshrotenberg/mcp-repl"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.4.0/mcp-repl-aarch64-apple-darwin.tar.gz"
      sha256 "f2c8cad502684c244a7b742ec32007340fcc8ced4637f4a2dc97bf0fadaac292"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.4.0/mcp-repl-x86_64-apple-darwin.tar.gz"
      sha256 "dea08d36416e5ce33f72f8d18d62db5dd7874140028545235bd3b226f2c04b83"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.4.0/mcp-repl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "77fa6ee45a3d17fcf0c05b2188f23bdd6138a084e678da1c160b4d1f7e9d5380"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.4.0/mcp-repl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eccbde4202853ec4807cccd98f8a2e2e53dcc48ab0a5026b48489c86037986a9"
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
