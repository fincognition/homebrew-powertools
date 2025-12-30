class PowertoolsAi < Formula
  include Language::Python::Virtualenv

  desc "Agentic workflow toolkit with persistent memory and task tracking"
  homepage "https://github.com/fincognition/powertools"
  url "https://files.pythonhosted.org/packages/source/p/powertools-ai/powertools_ai-0.1.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"

  depends_on "python@3.12"
  depends_on :macos => :sonoma
  depends_on arch: :arm64

  def install
    virtualenv_create(libexec, "python3.12")
    system libexec/"bin/pip", "install", "powertools-ai[mlx]==#{version}"
    bin.install_symlink Dir[libexec/"bin/pt"]
    bin.install_symlink Dir[libexec/"bin/powertools-embed"]
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

