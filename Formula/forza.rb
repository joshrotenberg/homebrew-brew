class Forza < Formula
  desc "Configurable workflow orchestrator for agent driven software development"
  homepage "https://github.com/joshrotenberg/forza"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.5.0/forza-aarch64-apple-darwin.tar.xz"
      sha256 "3d5dca9259d65d568d449bdbd7bccf5d971f39bdb2a428eeb8b414549857e19e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.5.0/forza-x86_64-apple-darwin.tar.xz"
      sha256 "d75160a8a39b2bf192a2c8241f0025459c045a2673e49fd85d2c742b99447229"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.5.0/forza-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e41fd0546c251be3638f59229c259a70e76423a8ad36933ed0dc5ae91bf9b189"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/forza/releases/download/forza-v0.5.0/forza-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "785eab7f56ec551200112b8be2528aa92f1a0f92b96fdabf5d0b8158d6c713c4"
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
