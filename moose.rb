class Moose < Formula
  desc "Multiscale Object Oriented Simulation Environment"
  homepage "http://moose.ncbs.res.in"
  url "https://github.com/dilawar/moose-core/archive/v3.1.5rc1.tar.gz"
  sha256 "74d8ca49662e28e3742f520ff1017ba520e2d1f9e1f94f4361c85066c1fb17e6"
  head "https://github.com/dilawar/moose-core.git", :branch=>"chamcham"

  depends_on "cmake" => :build
  depends_on "gsl"
  depends_on "numpy"
  depends_on "python@3" 

  def install
    args = std_cmake_args
    args << "-DCMAKE_SKIP_RPATH=ON"
    args << "-DVERSION_MOOSE=#{version}"
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
    system "python@3", "-c", "import moose; print(moose.__file__, moose.__version__)"
  end
end
