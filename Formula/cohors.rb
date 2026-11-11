class Cohors < Formula
  desc "Terminal dashboard for cohors; builds the `cohors` binary."
  homepage "https://github.com/rushirb2001/cohors"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.0/cohors-tui-aarch64-apple-darwin.tar.xz"
      sha256 "6f10bc3a2c9eac03961133e0b13ceac9d2bbac698d1f1cb17988284b952bbb85"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.0/cohors-tui-x86_64-apple-darwin.tar.xz"
      sha256 "6236435f9c702434d2855bacda563d20e8a500ba01dee5c551a09a31f994422f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.0/cohors-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a1a7a1ae328f233843a5cb3cfbc3a915529d14fa7e58ab05d1db42c344c7c1cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.0/cohors-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8c31633bee28e8814b56644352daadb5447190971eadad85d57fff61de151314"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
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
