require "formula"

class GrRds < Formula
  homepage "https://github.com/bastibl/gr-rds"
  head "git://github.com/bastibl/gr-rds.git"

  depends_on "cmake" => :build
  depends_on "cppunit"
  depends_on "swig"
  depends_on "gnuradio"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args << "-DPYTHON_LIBRARY=#{python_path}/Frameworks/Python.framework/"
      system "make", "install"
    end

    mkdir_p share+"apps"
    (share+name+"apps").install Dir["apps/*"]
  end

  def python_path
    python = Formula.factory('python')
    kegs = python.rack.children.reject { |p| p.basename.to_s == '.DS_Store' }
    kegs.find { |p| Keg.new(p).linked? } || kegs.last
  end
end
