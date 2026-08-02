class CratesioMcp < Formula
  desc "MCP server for querying crates.io - the Rust package registry"
  homepage "https://github.com/joshrotenberg/cratesio-mcp"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.0/cratesio-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "68d0a6a39fc52ff018e7341ec9538c34bc565652ebdd46e2b8dddd68264de738"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.0/cratesio-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "24cf5377165cb57da8421d40c9c614225ac045da09d854e15ad6339fe8937675"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.0/cratesio-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "53158c1b4258c6e5fe200e181558e6f0605ef79cde696a6f3ffd09025ff6350f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.0/cratesio-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ea4a4f60dbe4d375226ed49270bd80e1824774c954157ba2ed95f4febcb6f6d5"
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
