class Adrs < Formula
  desc "Command line tool for managing Architecture Decision Records"
  homepage "https://github.com/joshrotenberg/adrs"
  version "0.7.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.3/adrs-aarch64-apple-darwin.tar.xz"
      sha256 "0281b0e740dfcad6a5c61caa35b2b3ef7f5edfca5c7adc2cb794fc7c6854c082"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.3/adrs-x86_64-apple-darwin.tar.xz"
      sha256 "b9d70307343814f5ddd0510cebdfba0a2884f0577a43f12704d2fba8bce44bc2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.3/adrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "544d3b5e5dea75a341a400db10d8662023ef9641b641353b7aa99745db67553c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.3/adrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dc5848a324c29b565247962a8cd05d0aba3191cd35e5e01334444e60abb0fd16"
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
