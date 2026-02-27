class SkilletMcp < Formula
  desc "MCP-native skill registry for AI agents"
  homepage "https://github.com/joshrotenberg/skillet"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.2.0/skillet-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "593b079d18c5bbf518f8333f413fd05dfcd774190c6feeaf6d13b3d4dc38543d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.2.0/skillet-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "8353499cec2b434f1295df1ebe8bc16787aad64d7315ad612267640de779f221"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.2.0/skillet-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3c075270b0fafb5ce6a4500eca602f51dd86854d778f36e23a3cdfec39c5b43a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.2.0/skillet-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4a4c83a312c3d0d9ea85db513ee8101154c32a288741f4c3a30bbc2302ab1973"
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
