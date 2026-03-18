class SkilletMcp < Formula
  desc "MCP-native skill discovery for AI agents"
  homepage "https://github.com/joshrotenberg/skillet"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.5.1/skillet-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "545845c39e51129771f6501ea0182e0cca81c9a8642b69be556cd1c61f815388"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.5.1/skillet-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "7978b48e675f68c7dd3a188ea3b9f635f4457707044b803dc31130c57af04ac6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.5.1/skillet-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "21e6b22b7e793191e33a776b07a469083b80035e274e57320f4ca7c94451d773"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/skillet/releases/download/v0.5.1/skillet-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "524465099968701897a52bb244ffd15f85fbb1e806333b469234738c4526189c"
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
