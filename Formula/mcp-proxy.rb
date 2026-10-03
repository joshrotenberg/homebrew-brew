class McpProxy < Formula
  desc "Tower-native MCP gateway for aggregating backends with auth, resilience, and observability"
  homepage "https://github.com/joshrotenberg/mcp-proxy"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.6.0/mcp-proxy-aarch64-apple-darwin.tar.xz"
      sha256 "26e98ee123dd5887587bdcd82092995721bed1dd956ecd0274b61d56e91a45e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.6.0/mcp-proxy-x86_64-apple-darwin.tar.xz"
      sha256 "56797e1381fe5af6dcef33ecaaff546be455379ce192680e2c640d1beec8932d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.6.0/mcp-proxy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a8c1a98b49885c2a7835f1ca34253d70967a235c9946bd0435cc25941b52b22e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.6.0/mcp-proxy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f05ed358d1866feca6704b52f0d8e8610c2c7b587eced489838771a5400c09b"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "mcp-proxy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mcp-proxy"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mcp-proxy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mcp-proxy"
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
