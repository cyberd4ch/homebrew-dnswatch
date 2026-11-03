class Dnswatch < Formula
  desc "Dependency-free DNS drift watcher for bug-bounty scopes and infra"
  homepage "https://github.com/cyberd4ch/dns-watch"
  url "https://github.com/cyberd4ch/dns-watch/releases/download/v1.1.0/dnswatch-1.1.0.tar.gz"
  sha256 "c896d5afaa9e8d2df7f2a89a5cda073ddced780125dde9ef029fabcb2b629116"
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
    # Version-agnostic on purpose: the tap is bumped by CI (dns-watch's
    # tap-bump workflow), so the test must not pin a version string the
    # bot does not update. Pinning happens via the URL + sha256.
    assert_match(/[0-9]+\.[0-9]+\.[0-9]+/, shell_output("#{bin}/dnswatch --version"))
  end
end
