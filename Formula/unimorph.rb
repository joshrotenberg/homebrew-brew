class Unimorph < Formula
  desc "Command-line interface for UniMorph morphological data"
  homepage "https://joshrotenberg.github.io/unimorph-rs/"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/unimorph-rs/releases/download/unimorph-v0.2.1/unimorph-aarch64-apple-darwin.tar.xz"
      sha256 "f7ee0f9df31f841216b4ca4cfcb8b20b0b1f2c7618ad4a2a022666830ef46f72"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/unimorph-rs/releases/download/unimorph-v0.2.1/unimorph-x86_64-apple-darwin.tar.xz"
      sha256 "77d0c95c877db2a1f59daa4f825f7d9ed42bf0ef7ce5d8476f2a13c8402e7bfa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/unimorph-rs/releases/download/unimorph-v0.2.1/unimorph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b4dd51d49ddfb9d0ba05da812250af67b7404ed761da22f8b6f9aeddd300874a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/unimorph-rs/releases/download/unimorph-v0.2.1/unimorph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "596109837c5c9d4eee0d3b4d2cb6e99fa89e1748314f944cdc0c1d57a4593c20"
    end
  end
  license "Apache-2.0"

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
    bin.install "unimorph" if OS.mac? && Hardware::CPU.arm?
    bin.install "unimorph" if OS.mac? && Hardware::CPU.intel?
    bin.install "unimorph" if OS.linux? && Hardware::CPU.arm?
    bin.install "unimorph" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
