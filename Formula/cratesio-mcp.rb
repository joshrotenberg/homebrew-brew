class CratesioMcp < Formula
  desc "MCP server for querying crates.io - the Rust package registry"
  homepage "https://github.com/joshrotenberg/cratesio-mcp"
  version "0.4.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.3/cratesio-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "147778465d9cd5d11af863314338ad9186194118550269cdd9ee41f2a94b8373"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.3/cratesio-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "6ba6e8b1b2c7df5b5e04499f7e8ab1ee1e1a338a55694a431dd3a26f935f3efe"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.3/cratesio-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8cb41654b07248845b871f123faece03754a5beaf4e0481668c5ed3c4922b6f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.3/cratesio-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f8a6188ac00d057215f698643644ecded05fc35e42ed1ebb8e11b56e534f9f4d"
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
      bin.install "cratesio-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cratesio-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cratesio-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cratesio-mcp"
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
