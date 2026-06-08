class Roba < Formula
  desc "Single-prompt CLI runner built on claude-wrapper"
  homepage "https://github.com/joshrotenberg/roba"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.4.0/roba-aarch64-apple-darwin.tar.xz"
      sha256 "9c3cb52f13b91f7bc1da45070f50b3b15b1749526ba98b9e6883bc33fc15a692"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.4.0/roba-x86_64-apple-darwin.tar.xz"
      sha256 "3ad5674e7a423b67e489ef25a980c7e24589862ad0d3039e43c8758e718f7ee8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.4.0/roba-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0368e7479f55f406e8f34875c93865b52aacf7110fb63a45b917c0044c4d0682"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.4.0/roba-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c8bd515236ae81dd1f7d3737aaf4f8316476e7afbce7c98c765081d0f0d0f79a"
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
