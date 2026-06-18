class Roba < Formula
  desc "A sharp, focused sugaring of claude -p -- pipeable, composable, safe-by-default, session-re-enterable."
  homepage "https://github.com/joshrotenberg/roba"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.8.0/roba-aarch64-apple-darwin.tar.xz"
      sha256 "c68d8f14d60dcf63af171eaf48168d0fc3d99bdc621dc57d7b9b23f87c475704"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.8.0/roba-x86_64-apple-darwin.tar.xz"
      sha256 "a492bf9315b00a2b19b355ce414846f7c09a9dabc0962992e477249646a3d17a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.8.0/roba-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bc4e072b2411eaea51a2cf4db27d794abc770e81517a74161fa2eb2f75d477cd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.8.0/roba-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a8e6bcd5ab52fc30e7f52aab66f6de90901bed5e281623ad97a5370d4e371c4b"
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
