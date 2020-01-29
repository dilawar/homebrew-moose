class MooseNightly < Formula
  desc "Multiscale Object Oriented Simulation Environment"
  homepage "http://moose.ncbs.res.in"
  head "https://github.com/BhallaLab/moose-core.git", :branch => "master"

  depends_on "cmake" => :build
  depends_on "gsl"
  depends_on "numpy"
  depends_on "python@3" if MacOS.version <= :snow_leopard

  def install
    (buildpath/"VERSION").write("#{version}\n")
    args = std_cmake_args
    args << "-DCMAKE_SKIP_RPATH=ON"
    mkdir "_build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  def caveats; <<-EOS
    Please also install the following using pip
      $ pip install matplotlib networkx
    Optionally, you can install the folllowing for sbml and NeuroML support.
      $ pip install python-libsbml pyNeuroML
  EOS
  end

  test do
    system "python3", "-c", "import moose;print(moose.__file__, moose.__version__)"
  end
end
