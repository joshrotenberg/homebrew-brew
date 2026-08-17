class Roba < Formula
  desc "A library-first finite agent runner with Claude and Codex adapters."
  homepage "https://github.com/joshrotenberg/roba"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.12.0/roba-aarch64-apple-darwin.tar.xz"
      sha256 "ac090591125093c813a1ea74e84495d91828945760658da0ad55468631a1fce1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.12.0/roba-x86_64-apple-darwin.tar.xz"
      sha256 "18f40e0604fa1d8c1e5a636adb8a6f7f5ec278bf435f7e093eb2f629a5c5d99f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.12.0/roba-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "acb8a2458dca2ea20b08b3dfc4330aa3cf4ba7985c76da3ec8f8de5ca1fb8e03"
    end
    if Hardware::CPU.intel?
      url "https://github.com/joshrotenberg/roba/releases/download/v0.12.0/roba-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "acb58f151ebfe6a626bb8b47e0a6f52c25221ad6a8e3afcc1370d45b86b3f321"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "roba"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "roba"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "roba"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "roba"
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
