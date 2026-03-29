class Forza < Formula
  desc "Configurable workflow orchestrator for agent driven software development"
  homepage "https://github.com/joshrotenberg/forza"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.5.2/forza-aarch64-apple-darwin.tar.xz"
      sha256 "1c04fee7565c90c46264a3f79a0df48cf690d55e228cad76af9583a316e9d5ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.5.2/forza-x86_64-apple-darwin.tar.xz"
      sha256 "6ecc903ad2fffc36754e2f174740f65907a6b22b782d5029d186d92dc7f0122a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.5.2/forza-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "04c221bd6f4c6628789b34fe145bd227a7915860023bd0b91259cdbcf3a5dbc0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.5.2/forza-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c5688cd9c238dc030fc965c626a1100520b5862261b8b666b3d36a5d18403896"
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
    bin.install "forza" if OS.mac? && Hardware::CPU.arm?
    bin.install "forza" if OS.mac? && Hardware::CPU.intel?
    bin.install "forza" if OS.linux? && Hardware::CPU.arm?
    bin.install "forza" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
