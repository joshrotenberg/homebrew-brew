class SkilletMcp < Formula
  desc "MCP-native skill discovery for AI agents"
  homepage "https://github.com/joshrotenberg/skillet"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.5.0/skillet-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "b5c8cbd6bc1cd65ac7fafa653a71ba2640ee16a4c4009b0189b610ef4f8a02e9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.5.0/skillet-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "98002ec45bc780c1084c1422b3d59ef791454389a9dc45ee9c8e5fccae62e36a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.5.0/skillet-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ae27129cc21405013a46d798aa5e6f069180a5077b15ee5ed09294ea261cd276"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.5.0/skillet-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5a24b1406e96e7ae3ced623b33948fab7cc9a5fba11e6efb14bab58a81defc84"
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
