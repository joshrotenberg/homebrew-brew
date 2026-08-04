class McpProxy < Formula
  desc "Tower-native MCP gateway for aggregating backends with auth, resilience, and observability"
  homepage "https://github.com/joshrotenberg/mcp-proxy"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.2/mcp-proxy-aarch64-apple-darwin.tar.xz"
      sha256 "4ca7eec4ef44feb7091ec43e94099604e829dc63b2af297148146c052ac6ff66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.2/mcp-proxy-x86_64-apple-darwin.tar.xz"
      sha256 "a7a9cdf7add1e4d8659103b2d9042bbe7f9a27bb2806542c8704f86d2812e21a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.2/mcp-proxy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4fcfb9171d887ff104b49608c063c5318e255629bd1d6a783f7c232f16edd5a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.2/mcp-proxy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "83b4e1df3066f350ea9bb1c01be9a490826b70fd29f80e26a339c85ff044fe40"
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
