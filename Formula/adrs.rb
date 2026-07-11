class Adrs < Formula
  desc "Command line tool for managing Architecture Decision Records"
  homepage "https://joshrotenberg.com/adrs/"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.9.0/adrs-aarch64-apple-darwin.tar.xz"
      sha256 "5896ec10a4abcf552ea2cc82ffe68afed14af0ba9c83dce6f69721a007bb277c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.9.0/adrs-x86_64-apple-darwin.tar.xz"
      sha256 "56b71e819de2672b29b24d4e46875ad8496c01386fdd8dfee0291a2fec6c9b99"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.9.0/adrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d449e343943c4122a289efcf4b20e6ba4160e53489a53cc9f76734ec3c4c1f7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.9.0/adrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "557a50f05ce736a42960c073fe47c33fb49d851971b9c696d133fb5a2b1cdef8"
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
    bin.install "adrs" if OS.mac? && Hardware::CPU.arm?
    bin.install "adrs" if OS.mac? && Hardware::CPU.intel?
    bin.install "adrs" if OS.linux? && Hardware::CPU.arm?
    bin.install "adrs" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
