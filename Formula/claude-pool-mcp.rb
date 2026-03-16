class ClaudePoolMcp < Formula
  desc "Thin MCP server exposing claude-pool as tools"
  homepage "https://github.com/joshrotenberg/claude-wrapper"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-mcp-v0.1.1/claude-pool-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "d925d0c83c11e37d194d88f840a4cec101394a705d05f553133fa9446d046a98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-mcp-v0.1.1/claude-pool-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "94e395838f637e4dadec2fd842274cd3b7364ad385196ff19a3800a0c2cbebf1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-mcp-v0.1.1/claude-pool-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "665175e3a45e2d14c975f7cfc57a9eef2de78401b2aed8d8a2a5b444364c7adf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-mcp-v0.1.1/claude-pool-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c88b9d296a1601b341a125bc9cce7086f0801857571d1f36d29299ef2cd323fc"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "claude-pool-mcp" if OS.mac? && Hardware::CPU.arm?
    bin.install "claude-pool-mcp" if OS.mac? && Hardware::CPU.intel?
    bin.install "claude-pool-mcp" if OS.linux? && Hardware::CPU.arm?
    bin.install "claude-pool-mcp" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
