class ClaudePoolServer < Formula
  desc "MCP server binary for claude-pool"
  homepage "https://github.com/joshrotenberg/claude-wrapper"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-server-v0.3.0/claude-pool-server-aarch64-apple-darwin.tar.xz"
      sha256 "a8922cd3b215ad09bdc8331e973cb3d765fee7376d0abfc6a4da5e94ff7fda33"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-server-v0.3.0/claude-pool-server-x86_64-apple-darwin.tar.xz"
      sha256 "b922bd4f6b0dde3de19a09930b356ee1e61264afd15fea5b33cb23591bc4b4ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-server-v0.3.0/claude-pool-server-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7232f004a73c8f9e944a4bde0203bd2eadb3e57e838571c83e8969e62f22e160"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/claude-wrapper/releases/download/claude-pool-server-v0.3.0/claude-pool-server-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fff6a36882cc183cb23a0b6b1625dffd264d44f8db5185d256cb52f41c2ff0f4"
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
