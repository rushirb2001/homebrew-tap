class Cohors < Formula
  desc "Every git repo you own on one screen: terminal dashboard, CLI and MCP server"
  homepage "https://github.com/rushirb2001/cohors"
  version "0.8.20"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.8.20/cohors-aarch64-apple-darwin.tar.xz"
      sha256 "03503c41ba2e3f40640322ab2900c3d0610b977d63857e37a3b2c010fe8c40af"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.8.20/cohors-x86_64-apple-darwin.tar.xz"
      sha256 "fcf4e2ab830cac04506deb2a57a85b0dd37f8adfbdb40ea1bd8dc7a46dd632cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.8.20/cohors-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a51ac0959a401774697c3be0954a6463303406b19f0bc83627f0e8592b07881f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.8.20/cohors-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3b4c84231f36fc35591245580ac05dcbe6c9098d5e95087b0797b89cd60c2e21"
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
