class SkilletMcp < Formula
  desc "MCP-native skill discovery for AI agents"
  homepage "https://github.com/joshrotenberg/skillet"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.6.0/skillet-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "16c056279dbb1876c476d46750c75cc81b642caf1af7de0207565351c8dc8715"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.6.0/skillet-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "023d4c1205254bf2df3a1271693163fd3a10a9aa762866159874817db03d920f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.6.0/skillet-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ab1aabf5c3f64b8c557725fdb8d3cdad95042be9d10d0520061964647e2eaff5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.6.0/skillet-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "428beeabf10f23e661c13bcd923128328875f1d7311fba31b2ee7b8aab1d8d22"
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
