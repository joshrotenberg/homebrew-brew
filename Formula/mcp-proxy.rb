class McpProxy < Formula
  desc "Tower-native MCP gateway for aggregating backends with auth, resilience, and observability"
  homepage "https://github.com/joshrotenberg/mcp-proxy"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.5.0/mcp-proxy-aarch64-apple-darwin.tar.xz"
      sha256 "4cd164cce1c9adf210ffb23dc6202d75121981c41821e35f3c36fb7e763e9a79"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.5.0/mcp-proxy-x86_64-apple-darwin.tar.xz"
      sha256 "952797be497b5f62e9b9497520eea4e22a0ef59a191d6770093c3bf670aa3f40"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.5.0/mcp-proxy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e222a350483ec5f537745553e174a9718eb1f5407fb6d88e394dd9849edb6bd5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.5.0/mcp-proxy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5f62a7a19614808df4393ead0047d5606d5eb6281327bf744fc489ba0d98a9df"
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
