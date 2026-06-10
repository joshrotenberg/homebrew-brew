class Roba < Formula
  desc "A sharp, focused sugaring of claude -p -- pipeable, composable, safe-by-default, session-re-enterable."
  homepage "https://github.com/joshrotenberg/roba"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.5.0/roba-aarch64-apple-darwin.tar.xz"
      sha256 "b6ab801bd85cfd8e5d8d63d1250d4d88b36c40ad022bf08386c10faae47e5ebc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.5.0/roba-x86_64-apple-darwin.tar.xz"
      sha256 "9e22aa69f24d1f0ce4de3703aa7ec1caacc79844a4b5f212081bda1f0c43ecdf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.5.0/roba-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6227de7b637d54c4b84362d8007cb38cfe7d66cf6a99ffe82cdbda916ce0e6fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.5.0/roba-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "635afea7a3dc572d192a0ce212fa1a3ece2db55ecedc0d2e308470a7bbf4cee6"
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
