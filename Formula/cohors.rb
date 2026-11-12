class Cohors < Formula
  desc "Every git repo you own, on one screen: a terminal dashboard, CLI and MCP server for your whole fleet of repositories."
  homepage "https://github.com/rushirb2001/cohors"
  version "0.7.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.5/cohors-aarch64-apple-darwin.tar.xz"
      sha256 "2fc88d39b575afed35a1176d41e6083250aa3cc2f4a4d1e8cb20809194153c1e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.5/cohors-x86_64-apple-darwin.tar.xz"
      sha256 "8ce88c00f2bae25eda124486a050023706bf9d38107fc16c5bc8fc75ae6a4be7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.5/cohors-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d22f191603a221ecf6cac2005765b8c5f8798562256c20f958f4e1d2326a7512"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.5/cohors-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c64ba0372ee4d4f0a490b6111c0340ec118449142ce82f487dc792ad1ff61c90"
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
