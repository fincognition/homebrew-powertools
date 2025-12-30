class PowertoolsAi < Formula
  include Language::Python::Virtualenv

  desc "Agentic workflow toolkit with persistent memory and task tracking"
  homepage "https://github.com/fincognition/powertools"
  url "https://github.com/fincognition/powertools/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "801b35a272a59946ea6cc35ae9f84a9263893a7a424897051576cef7bdf90ec7"
  license "MIT"

  depends_on "python@3.12"
  depends_on :macos => :sonoma
  depends_on arch: :arm64

  def install
    # Create virtualenv with pip included
    venv = virtualenv_create(libexec, "python3.12", system_site_packages: false)
    # Install package from PyPI with mlx extras
    system libexec/"bin/python", "-m", "ensurepip", "--upgrade"
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "powertools-ai[mlx]==#{version}"
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

