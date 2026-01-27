class Adrs < Formula
  desc "Command line tool for managing Architecture Decision Records"
  homepage "https://github.com/joshrotenberg/adrs"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.6.1/adrs-aarch64-apple-darwin.tar.xz"
      sha256 "50489fe2550d2dbec43ee9b9bdb9c048486a31b94c5ac2326a5426b44924560b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.6.1/adrs-x86_64-apple-darwin.tar.xz"
      sha256 "5839e1558a93ff22fd6b7192caf937abcaae4688d2033127cc241642719280c2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.6.1/adrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "27471d8945fad58452ed32752ff3ad5697896320e400986cc8fb1b67389c3a26"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/adrs/releases/download/v0.6.1/adrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8d190aedad2f2d7e057baf766ec6ce0685e62a701d045bed6e9222d7a23b60ff"
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
    bin.install "adrs" if OS.mac? && Hardware::CPU.arm?
    bin.install "adrs" if OS.mac? && Hardware::CPU.intel?
    bin.install "adrs" if OS.linux? && Hardware::CPU.arm?
    bin.install "adrs" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
