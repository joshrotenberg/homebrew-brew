class SkilletMcp < Formula
  desc "MCP-native skill registry for AI agents"
  homepage "https://github.com/joshrotenberg/skillet"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.1.0/skillet-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "b8103e758b93e06fef7ddb1138cf6e031ad254a74b9de8ae9c98889249146532"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.1.0/skillet-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "81d761e73ded501dcd45e7daabab5f0dd0100d961ee9ac7058f21f17286bc12f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.1.0/skillet-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d4ddb338efff2d9cbd54506d33a9cd9b6c1842619049bac2441ac880fd8aa13"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.1.0/skillet-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "abed95af3426b8edffcd1d4d3512f32517e6f02d896de8c9b12281ad996817f3"
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
