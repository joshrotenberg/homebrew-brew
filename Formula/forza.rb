class Forza < Formula
  desc "Configurable workflow orchestrator for agent driven software development"
  homepage "https://github.com/joshrotenberg/forza"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.6.0/forza-aarch64-apple-darwin.tar.xz"
      sha256 "bc4ba4317934f0dd383fe6042cd49bc8375abae2e4c3ae3c834ebe945821ced8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.6.0/forza-x86_64-apple-darwin.tar.xz"
      sha256 "e1f50ed1992394cef9ba2187251c4d00d8729e7530203f3f52bfb3d639a046a4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.6.0/forza-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f7ab3ccedad9f7fe0cf4cdb311ed6d6c1ae8f80e59c9b245880a489ae6b6134f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.6.0/forza-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c39eaf57ff0c4a99c6a64e55bb0083ed63bfdf7e3e7dc769a7efeecb3380f1d9"
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
    bin.install "forza" if OS.mac? && Hardware::CPU.arm?
    bin.install "forza" if OS.mac? && Hardware::CPU.intel?
    bin.install "forza" if OS.linux? && Hardware::CPU.arm?
    bin.install "forza" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
