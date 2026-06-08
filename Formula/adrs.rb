class Adrs < Formula
  desc "Command line tool for managing Architecture Decision Records"
  homepage "https://joshrotenberg.com/adrs/"
  version "0.7.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.5/adrs-aarch64-apple-darwin.tar.xz"
      sha256 "4d697551fe4cfa3aad4e75734f7a24664d42827eabfc94586f2df44301308628"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.5/adrs-x86_64-apple-darwin.tar.xz"
      sha256 "d48e1e9b625acd503f017f037f9c01783858105524371c55265d518f0d819d39"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.5/adrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6e62d5fa7c15341a2a4542c6c704a22312ea85e9ef9af516f553744e75c3e643"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.5/adrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0b1af433a89bf72f970b7ee4a068b8092cc7b8d1075d64c36c7a8cd098c4ed81"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "adrs"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "adrs"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "adrs"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "adrs"
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
