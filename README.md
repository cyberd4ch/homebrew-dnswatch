# homebrew-dnswatch

Homebrew tap for [dns-watch](https://github.com/cyberd4ch/dns-watch) — a
dependency-free DNS drift watcher for bug-bounty scopes and personal infra.

## Install

```bash
brew install cyberd4ch/dnswatch/dnswatch
```

Requires `dig` (macOS ships it; on Linux: `brew install bind`).

Takeover tagging needs the signature table, installed at
`$(brew --prefix)/share/dnswatch/signatures.tsv`; pass that path to
`dnswatch -T ...` — the README
[explains the `-T` semantics](https://github.com/cyberd4ch/dns-watch#takeover-candidate-tagging-experimental-opt-in)
(candidate, not verdict; the tool never sends HTTP itself).

Standalone tracking: the tap formula pins the latest tagged release; users
who want `main` should `git clone` the repo instead (documented in the
dns-watch README's Install section).
