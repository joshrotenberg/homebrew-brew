class Adrs < Formula
  desc "Command line tool for managing Architecture Decision Records"
  homepage "https://joshrotenberg.com/adrs/"
  version "0.7.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.6/adrs-aarch64-apple-darwin.tar.xz"
      sha256 "ba16b25dc5621c19327be2b257a744495452787d7c924b8ca99a4a57f6dacbd3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.6/adrs-x86_64-apple-darwin.tar.xz"
      sha256 "2d7f439cdfe12d456255f6e60943d18d56d3e0ac555319c25803f0d72ab03ac8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.6/adrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8d0b95eb8d89a46455e997b5dfcb4ec3c0239a6c964e15c6fb2e19921e6cf636"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.7.6/adrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4042a8833cf1bb88d510bc3391afe51bbe90b823ffaac5c3f93a0b2db11de2a5"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "adrs"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "adrs"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "adrs"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "adrs"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
