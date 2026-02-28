class SkilletMcp < Formula
  desc "MCP-native skill registry for AI agents"
  homepage "https://github.com/joshrotenberg/skillet"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.3.0/skillet-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "6ab0a1e3eca35580134bf577511d7bf0998d6c102281a75d8ef50e89787a49ae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.3.0/skillet-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "05bad79a7c5cfd6e64e69a041e487542f6c7b20af8e5655348ea0189349fcade"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.3.0/skillet-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "112965fe3047ca2bd7c0cc29f1c73bca998f8cee7fc00ca9a1d06b09ba99be77"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.3.0/skillet-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "65aaa9d6a42864b98c7465144bc29329c4e4f7302e5a48f16433f7de2585bace"
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
    bin.install "skillet" if OS.mac? && Hardware::CPU.arm?
    bin.install "skillet" if OS.mac? && Hardware::CPU.intel?
    bin.install "skillet" if OS.linux? && Hardware::CPU.arm?
    bin.install "skillet" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
