class SkilletMcp < Formula
  desc "MCP-native skill registry for AI agents"
  homepage "https://github.com/joshrotenberg/skillet"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.4.0/skillet-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "6b138d5f737b5f3d61365c8c2d5f44b5757e7d3412594fde53f04606d9a3f6a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.4.0/skillet-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "27c668e7a053d66f2057730012eaffcec3919345e6fe4bf827a8b5b36d6a441e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.4.0/skillet-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "78ae74c1373a502605e6a67be5dc0b1c9c7f6ff32aa850383b9e04909f0f3e03"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.4.0/skillet-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b712e1edd5d95e2ed3a6190c199b858e210463a62e3065130a08515c5ccc768e"
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
