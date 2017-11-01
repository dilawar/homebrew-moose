class Moose < Formula
  desc "Multiscale Object Oriented Simulation Environment"
  homepage "http://moose.ncbs.res.in"
  url "https://github.com/BhallaLab/moose-core/archive/3.1.2.tar.gz"
  sha256 "a542983e4903b2b51c79f25f4acc372555cbe31bc0b9827302a6430fad466ef7"
  head "https://github.com/BhallaLab/moose-core.git"

  depends_on "cmake" => :build
  depends_on "gsl"
  depends_on "hdf5"
  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "numpy"

  def install
    (buildpath/"VERSION").write("#{version}\n")
    # FindHDF5.cmake needs a little help
    ENV.prepend "LDFLAGS", "-lhdf5 -lhdf5_hl"

    args = std_cmake_args
    args << "-DCMAKE_SKIP_RPATH=ON"
    mkdir "_build" do
      system "cmake", "..", "-DPYTHON_EXECUTABLE:FILEPATH=#{which("python")}", *args
      system "make"
    end

    Dir.chdir("_build/python") do
      system "python", *Language::Python.setup_install_args(prefix)
    end

    if build.with?("examples")
      doc.install resource("examples")
    end
  end

  def caveats; <<-EOS.undent
    You need to install `networkx` and `python-libsbml` using python-pip. Open terminal
    and execute following command:
      $ pip install python-libsbml networkx
    EOS
  end

  test do
    system "python", "-c", "import moose"
  end
end
