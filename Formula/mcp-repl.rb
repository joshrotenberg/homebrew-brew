class McpRepl < Formula
  desc "Interactive MCP client that turns a server's surface into terminal commands"
  homepage "https://github.com/joshrotenberg/mcp-repl"
  version "0.3.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.9/mcp-repl-aarch64-apple-darwin.tar.gz"
      sha256 "bcd0f6669c6dfd78f6392a69b42a36e423ccb10acccf090d2a0092a26ce2f2d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.9/mcp-repl-x86_64-apple-darwin.tar.gz"
      sha256 "df3f09c4f32ac47d1b07ab11805569e22f927cf2b97398eea8784de801b8b009"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.9/mcp-repl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "09a32a4589f896edb81e6f6a1e8a7be667f6962b67c1b1f4e52bb2584d740dd3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.9/mcp-repl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5113c6e1b7c26f9fbf7b991793c2772672058770eeb5d8ea6b443b82d4310024"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "mcp-repl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mcp-repl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mcp-repl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mcp-repl"
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
