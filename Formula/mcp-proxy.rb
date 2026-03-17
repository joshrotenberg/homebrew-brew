class McpProxy < Formula
  desc "Standalone MCP proxy -- config-driven reverse proxy with auth, rate limiting, and observability"
  homepage "https://github.com/joshrotenberg/mcp-proxy"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.2.0/mcp-proxy-aarch64-apple-darwin.tar.xz"
      sha256 "bad5e3b1fb6aec7d320701930e168992bbcb6f43dbe1ecf0f1a49c2cbf95f570"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.2.0/mcp-proxy-x86_64-apple-darwin.tar.xz"
      sha256 "88c34b64d8cbb941048d5e4ef9b58846ab766944d25a6e02f79450221436effd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.2.0/mcp-proxy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fd0b9ed2aa368e7964ac88bae40ae3cf1b5db7b94e75e88f00b263631c210d30"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.2.0/mcp-proxy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9c95eec988b03bdf58fc103107fcfef12f3a16e904b487c668af0569171b861e"
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
    bin.install "mcp-proxy" if OS.mac? && Hardware::CPU.arm?
    bin.install "mcp-proxy" if OS.mac? && Hardware::CPU.intel?
    bin.install "mcp-proxy" if OS.linux? && Hardware::CPU.arm?
    bin.install "mcp-proxy" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
