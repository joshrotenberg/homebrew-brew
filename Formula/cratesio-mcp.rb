class CratesioMcp < Formula
  desc "MCP server for querying crates.io - the Rust package registry"
  homepage "https://github.com/joshrotenberg/cratesio-mcp"
  version "0.4.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.4/cratesio-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "393961cee0ad8c1cb9ae35aca66844f50ffa9c1185dc583942a2713de92ed945"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.4/cratesio-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "68edad1c6fcf5f00da5bd13766ec61b30055f5ca90111bdbbe24b3c61aab2ca8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.4/cratesio-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8ba759d392c9a80186e2fbd932e5824609eb72b90986b415dff7d2452f28eb8d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/cratesio-mcp/releases/download/v0.4.4/cratesio-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e6c0e1769de52ae70fc5ac20ecce06ffe9ee8b36876b26855a8611201a7aa85c"
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
