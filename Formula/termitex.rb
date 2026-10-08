class Termitex < Formula
  desc "Render LaTeX in live terminal output with native Rust"
  homepage "https://github.com/tingkai-c/TermiTex"
  url "https://github.com/tingkai-c/TermiTex/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "548ae52cc1c205a531c716ee481bbec7222bfec423406f50f22762c7d3052dd3"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
    pkgshare.install "licenses"
    pkgshare.install "LICENSE"
  end

  def caveats
    <<~EOS
      Run termitex in a supported Kitty-graphics terminal.
      Use termitex doctor to check terminal capabilities.
      The default renderer is native RaTeX; Node.js is not required.
      For the optional MathJax backend, use a source checkout:
        https://github.com/tingkai-c/TermiTex#use-mathjax
    EOS
  end

  test do
    require "json"

    assert_match "termitex #{version}", shell_output("#{bin}/termitex --version")
    request = {
      key: "brew-test", cell_width: 16, cell_height: 34,
      formula: { latex: "x^2", row: 0, col: 0, rows: 1, cols: 12,
                 display: false, fg: "#ffffff", bg: "#282c34" }
    }
    response = JSON.parse(pipe_output("#{bin}/termitex --internal-ratex-worker", "#{request.to_json}\n", 0))
    assert_nil response["error"]
    assert_equal "brew-test", response["key"]
    png = response.fetch("png").unpack1("m0")
    assert_equal "\x89PNG\r\n\x1a\n".b, png.byteslice(0, 8)
    assert_equal [response.fetch("columns") * 16, 34], png.byteslice(16, 8).unpack("NN")
  end
end
