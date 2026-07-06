class Cohors < Formula
  desc "Terminal dashboard for cohors; builds the `cohors` binary."
  homepage "https://github.com/rushirb2001/cohors"
  version "0.5.14"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.5.14/cohors-tui-aarch64-apple-darwin.tar.xz"
      sha256 "307c1730efa875f0f2cfe2620622c133da45364272c1a369851752747e99b7a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rushirb2001/cohors/releases/download/v0.5.14/cohors-tui-x86_64-apple-darwin.tar.xz"
      sha256 "efaf81f0ec2e38f23bd967b164c1f7434b442c82e3fbcea4d2b59940be3c52c9"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/rushirb2001/cohors/releases/download/v0.5.14/cohors-tui-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ca03ed277d9baf4bbc712e23d2840f45d2f372ce1e117a453bb3ffb672518e76"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "cohors" if OS.mac? && Hardware::CPU.arm?
    bin.install "cohors" if OS.mac? && Hardware::CPU.intel?
    bin.install "cohors" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
