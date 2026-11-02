class CratesioMcp < Formula
  desc "MCP server for querying crates.io - the Rust package registry"
  homepage "https://github.com/joshrotenberg/cratesio-mcp"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.2/cratesio-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "87a0da64d9c3611016316960943a93ced3324c84e96fb2f2c2f6d769510d3ed2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.2/cratesio-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "77b6e6cec1ee235532567bbce4bc61f8271c57ce2754e13fb015bc27df0e90a0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.2/cratesio-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dd728c38719aa386d7863ea04d89fcea3fd0e6b5c36c4113fedf898d1d9bc532"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.2/cratesio-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "de33949bf36992978a2a4f2f74e508e54c428514ef03c19963270ac841766226"
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
