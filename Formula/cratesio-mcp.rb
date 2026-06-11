class CratesioMcp < Formula
  desc "MCP server for querying crates.io - the Rust package registry"
  homepage "https://github.com/joshrotenberg/cratesio-mcp"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.2.1/cratesio-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "78ae50b12bcfcb1704bd994bfe102d1bad07a13a5102a0c47511f8bd13d7cf86"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.2.1/cratesio-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "f3c61f45d09d783a1d810b71c04dd252777b8fccf5ddcdb663528e6156f7182c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.2.1/cratesio-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6365ed3d2df615155fbd84f3389b1d1cb922aeaf7e792069b96fea854555078a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.2.1/cratesio-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cb9c7bd6dd802edca6478ef898abfa9ac58d838a98551c40768685f7607da0f0"
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
    bin.install "cratesio-mcp" if OS.mac? && Hardware::CPU.arm?
    bin.install "cratesio-mcp" if OS.mac? && Hardware::CPU.intel?
    bin.install "cratesio-mcp" if OS.linux? && Hardware::CPU.arm?
    bin.install "cratesio-mcp" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
