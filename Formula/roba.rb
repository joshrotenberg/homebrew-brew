class Roba < Formula
  desc "A sharp, focused sugaring of claude -p -- pipeable, composable, safe-by-default, session-re-enterable."
  homepage "https://github.com/joshrotenberg/roba"
  version "0.10.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.10.1/roba-aarch64-apple-darwin.tar.xz"
      sha256 "040ca1f4641a0679bae3a74d83bc8fa7a57c9368d52b2737fe61ace2411c89bf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.10.1/roba-x86_64-apple-darwin.tar.xz"
      sha256 "fff52322cbd68e8cb210cc32217800d5305cef642c90448ec210642530c785d8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.10.1/roba-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "736260db499b4fe0a9fa0b4922fa89d1f80943c80bb4bb6fe45974aca9bde3f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.10.1/roba-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4901abfe5f5b3ff8556874df1edb2680e4d6adbbbe93a776aaf39607893772ff"
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
