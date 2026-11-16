class Cohors < Formula
  desc "Every git repo you own on one screen: terminal dashboard, CLI and MCP server"
  homepage "https://github.com/rushirb2001/cohors"
  version "0.8.21"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.8.21/cohors-aarch64-apple-darwin.tar.xz"
      sha256 "eeaa7c65837b9abac0541ce36e9eb09b5a9dde47dee28e84ffedab1d525f75f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.8.21/cohors-x86_64-apple-darwin.tar.xz"
      sha256 "faf89416f165291a64d6d805b7cf3d965933df17c547438e571dae32607c09ab"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.8.21/cohors-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "60c6136a7d079a432996e923b54558d748d66cf884967bcbf92d978178549f53"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.8.21/cohors-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "20f7822e2f598844063ab9109e24aa8a99acf161cbc28f4d1671f9d9b81a4c66"
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
