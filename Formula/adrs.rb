class Adrs < Formula
  desc "Command line tool for managing Architecture Decision Records"
  homepage "https://github.com/joshrotenberg/adrs"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.5.1/adrs-aarch64-apple-darwin.tar.xz"
      sha256 "2b29d6716dabbdaa9a574f5e26b52ed0cb42bc8355d3d6de4965889adf96eb98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.5.1/adrs-x86_64-apple-darwin.tar.xz"
      sha256 "ba95c6b136e7b6247ccb781f29c5b07264970198218a28aa24cb50dd86b369a6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.5.1/adrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6f28144e8903e7a364e0a8c19b7a89247825c816c26bf07221d70250d37e88d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.5.1/adrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "91636c055671e5bbbd22ac33fff353340e432555f3eca76773d163a2845eab38"
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
