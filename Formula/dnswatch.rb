class Dnswatch < Formula
  desc "Dependency-free DNS drift watcher for bug-bounty scopes and infra"
  homepage "https://github.com/cyberd4ch/dns-watch"
  url "https://github.com/cyberd4ch/dns-watch/releases/download/v1.1.0/dnswatch-1.1.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
