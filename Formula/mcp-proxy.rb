class McpProxy < Formula
  desc "Tower-native MCP gateway for aggregating backends with auth, resilience, and observability"
  homepage "https://github.com/joshrotenberg/mcp-proxy"
  version "0.4.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.3/mcp-proxy-aarch64-apple-darwin.tar.xz"
      sha256 "a22ab6a67547e1db99bd6386d182985d1fc5060fed49fe83ec1d788d4dd20db9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.3/mcp-proxy-x86_64-apple-darwin.tar.xz"
      sha256 "073370cd91b0f7848341b97b6462b398e578619b608940ed5c86e1d39ab4dbc7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.3/mcp-proxy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "61d377a96d7ccac016afe8c61014cc26321d6ee5586f512a12a44e407a6cac5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.3/mcp-proxy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aa1e4ae9e8fd37bb2a5ebc7f0c133cacfd3ef6a80da05f2dfd831248838ae620"
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
