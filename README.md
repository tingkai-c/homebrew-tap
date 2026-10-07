# TermiTex Homebrew tap

Native terminal math rendering for macOS with Ghostty.

```sh
brew install tingkai-c/tap/termitex
termitex
```

The formula builds a pinned release from source. Homebrew installs Rust as a build dependency; the installed native renderer does not need Node.js. Ghostty and the CLI you want to wrap (Codex by default) are installed separately.

```sh
brew update
brew upgrade termitex
```

The optional MathJax backend requires a source checkout; see [TermiTex](https://github.com/tingkai-c/TermiTex#use-mathjax).

## Maintaining a release

1. Test and tag a release in `tingkai-c/TermiTex`.
2. Update the formula's source URL and SHA-256 checksum.
3. Run `brew install --build-from-source tingkai-c/tap/termitex` and `brew test tingkai-c/tap/termitex`.
4. Commit and push the tap update.
