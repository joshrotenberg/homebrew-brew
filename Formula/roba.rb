class Roba < Formula
  desc "A sharp, focused sugaring of claude -p -- pipeable, composable, safe-by-default, session-re-enterable."
  homepage "https://github.com/joshrotenberg/roba"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.7.1/roba-aarch64-apple-darwin.tar.xz"
      sha256 "98796568424c312aab0c5212621773dcb83b17f565c9722b10f6fb37dc343694"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.7.1/roba-x86_64-apple-darwin.tar.xz"
      sha256 "e0126edcfe73241a23d2b45dfeceb904291bee963d2d362b04da24677f6bb8c5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.7.1/roba-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "57b3bcd415264cfe5b2c19cdb9a381729c8a9d8dc898500d281bd423cdb1a01b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.7.1/roba-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b718a583a60cb509dbb730fe370ace94839efdfccea830148209eefa1edc1db2"
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
