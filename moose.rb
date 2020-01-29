class Moose < Formula
  desc "Multiscale Object Oriented Simulation Environment"
  homepage "http://moose.ncbs.res.in"
  url "https://github.com/BhallaLab/moose-core/archive/v3.1.4.tar.gz"
  sha256 "5d8e56e4361723fc30598d87fecfeab67be471abc0bc017a334357fa2160cc1a"
  head "https://github.com/BhallaLab/moose-core.git", :branch=>"chamcham"

  depends_on "cmake" => :build
  depends_on "gsl"
  depends_on "numpy"
  depends_on "python" 

  def install
    args = std_cmake_args
    args << "-DCMAKE_SKIP_RPATH=ON"
    args << "-DVERSION_MOOSE=#{version}"
    mkdir "_build" do
      system "cmake", "..", *args
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
    system "python3", "-c", "import moose; print(moose.__file__, moose.__version__)"
  end
end
