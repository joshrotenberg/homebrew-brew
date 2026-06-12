class CratesioMcp < Formula
  desc "MCP server for querying crates.io - the Rust package registry"
  homepage "https://github.com/joshrotenberg/cratesio-mcp"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.3.0/cratesio-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "da2d7e90b2e70f374ee8c83b3990ad5942cb411cb605c0550bed3bb948bb98d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.3.0/cratesio-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "819777b84d045511c4dc9949b2d867e0509e2bdbe3993f93e9e7e887ce4cb8e1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.3.0/cratesio-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "65fba1aae9000998c991b795edf7e2cf8183da4c232a35b4fd4d19c234944c59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.3.0/cratesio-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "509752102d99c0080e60cafa86a66a46a77099e7dd1a412e023e071f4bc79e5a"
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
