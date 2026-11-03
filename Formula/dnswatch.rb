class Dnswatch < Formula
  desc "Dependency-free DNS drift watcher for bug-bounty scopes and infra"
  homepage "https://github.com/cyberd4ch/dns-watch"
  url "https://github.com/cyberd4ch/dns-watch/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "819c5649b6ef6bb9012a43e9e170b77e5537de78421889f404c8bd7342e1853a"
  license "MIT"
  head "https://github.com/cyberd4ch/dns-watch.git", branch: "main"

  def install
    bin.install "dnswatch.sh" => "dnswatch"
    # The takeover signature table is DATA, not part of the binary: installed
    # to share/, and passed by the user as the -T argument's path.
    (share/"dnswatch").install "signatures.tsv"
  end

  def caveats
    s = <<~EOS
      Requires `dig` (on macOS it ships with the OS; on Linuxbrew: `brew install bind`).
      The takeover signature table lives at:
        #{HOMEBREW_PREFIX}/share/dnswatch/signatures.tsv
      so takeover tagging is invoked as:
        dnswatch -t targets.txt -T #{HOMEBREW_PREFIX}/share/dnswatch/signatures.tsv ...
    EOS
    s
  end

  test do
    assert_match "1.1.0", shell_output("#{bin}/dnswatch --version")
  end
end
