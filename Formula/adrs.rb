class Adrs < Formula
  desc "Command line tool for managing Architecture Decision Records"
  homepage "https://github.com/joshrotenberg/adrs"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.6.0/adrs-aarch64-apple-darwin.tar.xz"
      sha256 "5dd49570282b6f203dbb0cf245fae5a417174dd63fc0fd596b35fd0eb203fa50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.6.0/adrs-x86_64-apple-darwin.tar.xz"
      sha256 "d866d2c17cdfc0adb6850c5c6db8044ee45a1b618012749a7a706aed4bc5ec9a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.6.0/adrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fa04e11a98ee1e71f53f1fe27a6c27dc942a56291da2169e63fc8614f5072b64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.6.0/adrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "537047000d3866e8630f1173b91c720aaa1ef076024e2c9765634401e1c0c84a"
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
