class Roba < Formula
  desc "Single-prompt CLI runner built on claude-wrapper"
  homepage "https://github.com/joshrotenberg/roba"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.2.2/roba-aarch64-apple-darwin.tar.xz"
      sha256 "3a5d0159777054b0f739d5c2f6545367a84a4081bbbae8b47492cd1a27ce99d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.2.2/roba-x86_64-apple-darwin.tar.xz"
      sha256 "c45e8de8943e5b729ae30b425c7ba83156857b2eb4f2766e0e5b30a84ca2fb5f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.2.2/roba-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "44f0536a98c8b7b1f86753e506436de26dce88a4ab55d6554198de1cdd13148f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.2.2/roba-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "37414c6b3940126fe6b2f3373b87fe994ea0e79761691a9a50965f320b1a34e6"
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
