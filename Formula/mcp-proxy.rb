class McpProxy < Formula
  desc "Standalone MCP proxy -- config-driven reverse proxy with auth, rate limiting, and observability"
  homepage "https://github.com/joshrotenberg/mcp-proxy"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.1.0/mcp-proxy-aarch64-apple-darwin.tar.xz"
      sha256 "30c4c25c85cd44dae4422d77bc71d81a1eb2dd16d4907432d173495cd2db1b6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.1.0/mcp-proxy-x86_64-apple-darwin.tar.xz"
      sha256 "7a36344ac578c8c270cd2037bc77084259d65a975bdcba74d6c63152b14b588a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.1.0/mcp-proxy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f8e71e612cad39ba87d14b5c0fdf3d2526922c7d6114b4f01015d13e829d3765"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-proxy/releases/download/v0.1.0/mcp-proxy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f5c78def415b6c3e4aa51bbe4126f9d012af32cdd7de5a3f2b3e87b68f7b9a5e"
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
