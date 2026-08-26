class McpRepl < Formula
  desc "Interactive MCP client that turns a server's surface into terminal commands"
  homepage "https://github.com/joshrotenberg/mcp-repl"
  version "0.3.5"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.5/mcp-repl-v0.3.5-aarch64-apple-darwin.tar.gz"
      sha256 "04438d8453e039ba820ec00b53dfc2c6affe444c6329259bfc686570b75b9ba5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.5/mcp-repl-v0.3.5-x86_64-apple-darwin.tar.gz"
      sha256 "9f31fb89ad100089d2054a8502e4b01dde18088ebde9c7f5390dd6612e8437e4"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.5/mcp-repl-v0.3.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e1fa812ce272851d97705d3e8cb3913ad6d20797562f8da74f14b222b9cb226f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/mcp-repl/releases/download/v0.3.5/mcp-repl-v0.3.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6e5c0740fe23540e5c7dbe71ae99557dca59474b528943aa8713185b259ab7fc"
    end
  end

  license any_of: ["MIT", "Apache-2.0"]

  def install
    bin.install "mcp-repl"
    man1.install "mcp-repl.1"
    bash_completion.install "completions/mcp-repl.bash" => "mcp-repl"
    zsh_completion.install "completions/mcp-repl.zsh" => "_mcp-repl"
    fish_completion.install "completions/mcp-repl.fish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mcp-repl --version")
  end
end
