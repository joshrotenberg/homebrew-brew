class Roba < Formula
  desc "Single-prompt CLI runner built on claude-wrapper"
  homepage "https://github.com/joshrotenberg/roba"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.3.1/roba-aarch64-apple-darwin.tar.xz"
      sha256 "f2a72d3243e07b45d8ab1e85eae71848b3e575932acf27905bafce0119da08ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.3.1/roba-x86_64-apple-darwin.tar.xz"
      sha256 "9a6c78f339f311d8d55511a4d0c25e72a455a7fdcdb5f280531fd281b5e9ce48"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.3.1/roba-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f4f7f84f27671c0dad21cfed2f643681bd6fdcef53471c2463b09f7df5bf9daa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.3.1/roba-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "438b3e13a1d08a3d3239315d6d53be289ef5d2b32202927a6117f1ac2fbd9ada"
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
    bin.install "roba" if OS.mac? && Hardware::CPU.arm?
    bin.install "roba" if OS.mac? && Hardware::CPU.intel?
    bin.install "roba" if OS.linux? && Hardware::CPU.arm?
    bin.install "roba" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
