class CratesioMcp < Formula
  desc "MCP server for querying crates.io - the Rust package registry"
  homepage "https://github.com/joshrotenberg/cratesio-mcp"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.1/cratesio-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "603c85ee08a7077cedff68834a78de2ab1b77862afd18004438acd13ffb8054e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.1/cratesio-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "31a2c29f47d06813641271221eb39d7426300697885f139078d09a172ad01f3f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.1/cratesio-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "919ad7a56b82d2319883771951d6fe7da37fd4fabb7c29ad3431667eb14e3a12"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.1/cratesio-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d4caaec5c64da8e21962fab9a8e7cb03ecaca48aec0b6b98164d07b3bc8431ca"
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
