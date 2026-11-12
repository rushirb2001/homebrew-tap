class Cohors < Formula
  desc "Terminal dashboard for cohors; builds the `cohors` binary."
  homepage "https://github.com/rushirb2001/cohors"
  version "0.7.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.2/cohors-tui-aarch64-apple-darwin.tar.xz"
      sha256 "ade5771c92877b27de0593cbc09b637777eeb4ecbde357cae43c1f98e5d966a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.2/cohors-tui-x86_64-apple-darwin.tar.xz"
      sha256 "fc2c17cc329debfdc49bd493af7621f7ba0bf747f76e1d5c59f355885b4d7177"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.2/cohors-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "19f5f4ce523f140f6685c308b34d89c155ff31f5c8eba24932c39a459b259152"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.7.2/cohors-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "25831a74cb0771bd0bf42eb39f722fdf2cff3569871da0f68addb2318239f06e"
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
