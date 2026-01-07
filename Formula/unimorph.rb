class Unimorph < Formula
  desc "Command-line interface for UniMorph morphological data"
  homepage "https://joshrotenberg.github.io/unimorph-rs/"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/unimorph-rs/releases/download/unimorph-v0.1.8/unimorph-aarch64-apple-darwin.tar.xz"
      sha256 "ca8d3461c879ec3d45966deb986d22be880c49d2307602911847f16becdd4697"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/unimorph-rs/releases/download/unimorph-v0.1.8/unimorph-x86_64-apple-darwin.tar.xz"
      sha256 "767e8dcb05260b70fbc16d3dd0915852829c76cebea9b1356ffe268b3cc9d8d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/unimorph-rs/releases/download/unimorph-v0.1.8/unimorph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "11f166cbbc985fd637642c6492d13b81585d1160bfebd6bb05e578d3760e9b3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/unimorph-rs/releases/download/unimorph-v0.1.8/unimorph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b9c5485e980a0e4a7d22af5a2e72632cc964653a516bec82a03573dd60fea6e4"
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
