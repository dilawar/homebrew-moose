class MooseNightly < Formula
  desc "Multiscale Object Oriented Simulation Environment"
  homepage "http://moose.ncbs.res.in"
  version "3.2-nightly"
  head "https://github.com/BhallaLab/moose-core.git", :branch => "master"

  depends_on "cmake" => :build
  depends_on "gsl"
  depends_on "numpy"
  depends_on "python"

  def install
    (buildpath/"VERSION").write("#{version}\n")
    args = std_cmake_args
    args << "-DCMAKE_SKIP_RPATH=ON"
    mkdir "_build" do
      system "cmake", "..", *args
      system "make"
      # NOTE: https://github.com/Homebrew/brew/blob/master/docs/Python-for-Formula-Authors.md
      cd "python" do
        system "cp", "setup.cmake.py", "setup.py"
        system "python3", *Language::Python.setup_install_args(prefix)
      end
    end
  end

  def caveats; <<-EOS
    Please install the following as well,
      $ python3 -m pip install matplotlib networkx
    And optionally, folllowing are needed for SBML and NeuroML.
      $ python3 -m pip install python-libsbml pyNeuroML
  EOS
  end

  test do
    system "python3", "-c", "import moose;print(moose.__file__, moose.__version__)"
  end
end
