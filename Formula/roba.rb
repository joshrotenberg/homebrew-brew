class Roba < Formula
  desc "A sharp, focused sugaring of claude -p -- pipeable, composable, safe-by-default, session-re-enterable."
  homepage "https://github.com/joshrotenberg/roba"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.10.0/roba-aarch64-apple-darwin.tar.xz"
      sha256 "5a58965a6f2bacada9587674188162a9dd6cee5b5d05aed6e5393cf6f842d2cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.10.0/roba-x86_64-apple-darwin.tar.xz"
      sha256 "809edfa2825c3efa9c1b90a87b57e5cc73b72214c576ef37035cfb9e1e58f0be"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.10.0/roba-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f0cc0c52e29b6ab1f679996d2bfd06d0a16b55aba397c2977788bfe06a59ab5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.10.0/roba-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f9fbdb60fd3ab5a392439a00badc8df6d83b919bd7368e5b7ae65d9ea75e517f"
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
