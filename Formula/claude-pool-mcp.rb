class ClaudePoolMcp < Formula
  desc "Thin MCP server exposing claude-pool as tools"
  homepage "https://github.com/joshrotenberg/claude-wrapper"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-mcp-v0.1.0/claude-pool-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "7cae7292bfae947e3f7909b162075489eb074b3af0a258ec9fd20b2bee4881ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-mcp-v0.1.0/claude-pool-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "498b3d964cefb033a0a3aff8855d2515bdf01726787c9d3bbbe9da0c8847c8b2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-mcp-v0.1.0/claude-pool-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "af736f41b7c8ab18e188124497ba363edc1dbb33583017ae297deea9f799efd1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-mcp-v0.1.0/claude-pool-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2e431cc2eefdeaaae7f66ca0cc6fc4e62a0529b957f744fc0909c22fa008488c"
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
