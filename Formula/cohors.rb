class Cohors < Formula
  desc "Every git repo you own on one screen: terminal dashboard, CLI and MCP server"
  homepage "https://github.com/rushirb2001/cohors"
  version "0.9.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.9.2/cohors-aarch64-apple-darwin.tar.xz"
      sha256 "e7e56fd3739b1c24b2f78b2ec27d49cfc612bfcdbf05fdfa4fa516c77b6d9444"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.9.2/cohors-x86_64-apple-darwin.tar.xz"
      sha256 "ad2c93cc880bea77b119866e7dbecc48a24b552bc6f2fe3042e5381f2ff5cdf5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.9.2/cohors-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f30d3b67e124cd8501da1c0420094ce0e20769c8a71bbc0763a40d8316d47e62"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.9.2/cohors-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a426a6f524c8eb4db90d60ef7293b30056d9dda8ba371b08953316c5af867ee"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "cohors"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cohors"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cohors"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cohors"
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
