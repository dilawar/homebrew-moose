class Moogli < Formula
  desc "MOOGLI: 3d Neural Activity Visualizer"
  homepage "http://moose.ncbs.res.in"
  url "https://github.com/BhallaLab/moogli/archive/0.5.1-osx.tar.gz"
  sha256 "d7fe5406f9d908efa3aed925e4bde615950abd43c0bc041a77dbe89284887ce2"
  head "https://github.com/BhallaLab/moogli.git"

  bottle do
    cellar :any
    sha256 "6077f886560480c956270f855cf9576a3e8261c5f2ea064117c3483f74a84462" => :sierra
    sha256 "a637de34ce0b92f16afc120ecb2e0e4aff8f8a2e6a2ada5521ee01cf7ccdca9e" => :el_capitan
    sha256 "1bb0712ef178577a3c44190be8f21f894cddc66ce03f742d768e44371425dce7" => :yosemite
    sha256 "a62366e1e1de37c13dec6d2b7f91dc63f8b40ab460e35b31a4d94507a0df6219" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "openscenegraph"
  depends_on :python if MacOS.version <= :snow_leopard

  def install
    args = std_cmake_args
    args << "-DCMAKE_SKIP_RPATH=ON"
    mkdir "_build" do
      system "cmake", "..", "-DPYTHON_EXECUTABLE:FILEPATH=#{which("python")}", *args
      system "make"
      system "make install"
    end
  end

  test do
    system "python", "-c", "import moogli"
  end
end
