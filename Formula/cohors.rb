class Cohors < Formula
  desc "Every git repo you own, on one screen: a terminal dashboard, CLI and MCP server for your whole fleet of repositories."
  homepage "https://github.com/rushirb2001/cohors"
  version "0.7.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.6/cohors-aarch64-apple-darwin.tar.xz"
      sha256 "d254922bef01d420c90e1387773f1336c769e8d94738d3709e5b96019666017e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.6/cohors-x86_64-apple-darwin.tar.xz"
      sha256 "1222fe896452736f91d27fb1c3587dee96a6e6c326a823e41b09b085392d909f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.6/cohors-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7f4206187ccb3e6f03dc21ddcdbad751d1500bb4687e22d1d8a2cfa896f36dc6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.6/cohors-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a897b6a0a53abe97f5438777cb3e361257afd0207d875db3d5b6534539ebe8b"
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
