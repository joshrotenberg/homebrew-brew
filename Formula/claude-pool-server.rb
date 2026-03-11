class ClaudePoolServer < Formula
  desc "MCP server binary for claude-pool"
  homepage "https://github.com/joshrotenberg/claude-wrapper"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-server-v0.2.0/claude-pool-server-aarch64-apple-darwin.tar.xz"
      sha256 "0a38efd5b2d780b7d25c7cb85ece5b390d2ad9b18e4f802c5c7a4f48ba15d826"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-server-v0.2.0/claude-pool-server-x86_64-apple-darwin.tar.xz"
      sha256 "eee82ca4b4d4602cd2eac490049bb1f3f49993faa70ed6cadd0ab155765f92cf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-server-v0.2.0/claude-pool-server-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2715b3e3a41c27239e2b1564cbe160890f4bc59b3ba48ab9a38ab9826a3e6d60"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-server-v0.2.0/claude-pool-server-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e85daa6812dfd52fd65801fc4cde2962e688b01a30c00f8eb61169f422e8eeeb"
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
    bin.install "claude-pool-server" if OS.mac? && Hardware::CPU.arm?
    bin.install "claude-pool-server" if OS.mac? && Hardware::CPU.intel?
    bin.install "claude-pool-server" if OS.linux? && Hardware::CPU.arm?
    bin.install "claude-pool-server" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
