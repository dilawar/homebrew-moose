class MooseNightly < Formula
  desc "Multiscale Object Oriented Simulation Environment"
  homepage "http://moose.ncbs.res.in"
  head "https://github.com/BhallaLab/moose-core.git", :branch => "chhennapoda"

  depends_on "cmake" => :build
  depends_on "gsl"
  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "numpy"

  def install
    (buildpath/"VERSION").write("#{version}\n")
    args = std_cmake_args
    args << "-DCMAKE_SKIP_RPATH=ON"
    mkdir "_build" do
      system "cmake", "..", *args
      system "make"
      system "make install"
    end
  end

  def caveats; <<-EOS
    You need to install `networkx` and `python-libsbml` using python-pip. Open terminal
    and execute following command:
      $ pip install python-libsbml networkx
    EOS
  end

  test do
    system "python", "-c", "import moose"
  end
end
