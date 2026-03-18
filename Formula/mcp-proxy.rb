class McpProxy < Formula
  desc "Standalone MCP proxy -- config-driven reverse proxy with auth, rate limiting, and observability"
  homepage "https://github.com/joshrotenberg/mcp-proxy"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.3.1/mcp-proxy-aarch64-apple-darwin.tar.xz"
      sha256 "7c091b456e96bd120f6c24066f32574f7fd0b34e99620654c792dd4dae3edf24"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.3.1/mcp-proxy-x86_64-apple-darwin.tar.xz"
      sha256 "8fbe883b49baa7f78173cbf3e8c1d83e98623c3f56f79be13b92dd420c82e8b9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.3.1/mcp-proxy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5203c4c241f8972b696cbaaa02c04d368f823f749bce93282ea29034aed148be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.3.1/mcp-proxy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a4d1b45f7dcb3af921f8daee1a7d7d2f8f87b16c02d756eb85c4297444ddfc2a"
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
