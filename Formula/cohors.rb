class Cohors < Formula
  desc "Every git repo you own on one screen: terminal dashboard, CLI and MCP server"
  homepage "https://github.com/rushirb2001/cohors"
  version "0.7.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.7/cohors-aarch64-apple-darwin.tar.xz"
      sha256 "db6f4b2095a17a1644088e397dec2560be8fa23ecba5c8bbbd4b0d071736e848"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.7/cohors-x86_64-apple-darwin.tar.xz"
      sha256 "c6564904a34d3945911e26e76d502423b33a1760ec18be3296f838d08557a239"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.7/cohors-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8ad811738361a20ef47c5cccf28494280c0454f8acb7007b6d61efd019ffa546"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.7/cohors-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dd2ea1d0866d67851b782e50cca1ed3a6d4ddbbdd5bcfae0c36726e5a24cc140"
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
