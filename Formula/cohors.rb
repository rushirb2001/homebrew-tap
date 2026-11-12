class Cohors < Formula
  desc "Terminal dashboard for cohors; builds the `cohors` binary."
  homepage "https://github.com/rushirb2001/cohors"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.1/cohors-tui-aarch64-apple-darwin.tar.xz"
      sha256 "bfef9943a7d477d1806e38f7fc38f074d67a03d7d9d88b1020077952933b31f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.1/cohors-tui-x86_64-apple-darwin.tar.xz"
      sha256 "d2001ab13f97f8802f95d48df32e4f5cc3e27ba698eb05770f7cf24d4a3a90d2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.1/cohors-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d5f3f29149342e2681e30112fe738f1897a638fdae66b5a0c34a85f8d19d5229"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.1/cohors-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "acaa693d54489ed512c1fe6f6ee59d852f4a14d6eeaff1a1ba1c115500a6cdd3"
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
