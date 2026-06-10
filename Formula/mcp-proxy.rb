class McpProxy < Formula
  desc "Standalone MCP proxy -- config-driven reverse proxy with auth, rate limiting, and observability"
  homepage "https://github.com/joshrotenberg/mcp-proxy"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.0/mcp-proxy-aarch64-apple-darwin.tar.xz"
      sha256 "c9509e5205835cc8e31401fdba0fe7ed570e9a1fcc90055f9aa8e19eb4ba1452"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.0/mcp-proxy-x86_64-apple-darwin.tar.xz"
      sha256 "97ec8f4f078fae300dde978ede07755d3430f5de8a240e3c68fea71008f773ee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.0/mcp-proxy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "52259cfc51a1e7ec4c128fb3841aaad3f1fc83a70af987ecdf7c974807c27aa1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.4.0/mcp-proxy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2e7d9366df3e28fbeac095f5d2bd0bd61b08418c466b56892bd4b93f1e7c0e5a"
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
