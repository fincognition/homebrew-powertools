class PowertoolsAi < Formula
  desc "Agentic workflow toolkit with persistent memory and task tracking"
  homepage "https://github.com/fincognition/powertools"
  url "https://github.com/fincognition/powertools/releases/download/v1.1.2/powertools_ai-1.1.2-py3-none-any.whl"
  sha256 "86efede77dff6476725c622fdb375247267e2b1327965e6348bbafb3fcfcb170"
  license "MIT"

  depends_on "uv"
  depends_on "python@3.12"
  depends_on :macos => :sonoma
  depends_on arch: :arm64

  def install
    # Use uv to create venv and install package
    system "uv", "venv", libexec, "--python", Formula["python@3.12"].opt_bin/"python3.12"
    system "uv", "pip", "install", "--python", libexec/"bin/python", "powertools-ai[mlx]==#{version}"
    # Symlink binaries
    bin.install_symlink libexec/"bin/pt"
    bin.install_symlink libexec/"bin/powertools-embed"
  end

  def caveats
    <<~EOS
      Run initial setup:
        pt init

      Then in your project:
        pt project-init -n myproject
    EOS
  end

  test do
    system bin/"pt", "--help"
  end
end

