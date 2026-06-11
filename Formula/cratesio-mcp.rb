class CratesioMcp < Formula
  desc "MCP server for querying crates.io - the Rust package registry"
  homepage "https://github.com/joshrotenberg/cratesio-mcp"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.2.0/cratesio-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "50dac6bdf3af36319e61a1f929abac234b86598ebc3e90704c6e78844b4a359e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.2.0/cratesio-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "01996370d78e9ace6786bd36eac915b189d03c5b37689e0d2f6b90f7e171fd1a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.2.0/cratesio-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "12288ea1ddf272f41429e7f5f33349fcb3d59535c6f41aee332dec061a70395a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.2.0/cratesio-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "12d6fef7b192d5531bcf9eac596d814425490ee73c942d2b5a4b7f161bb65b56"
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
