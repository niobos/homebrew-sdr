require "formula"

class GrOsmosdr < Formula
  homepage "http://sdr.osmocom.org/trac/wiki/GrOsmoSDR"
  url "http://cgit.osmocom.org/gr-osmosdr/snapshot/gr-osmosdr-0.1.4.tar.gz"
  sha1 "672041a6ffa767d39ffad2432e2a13c11e3ec984"

  depends_on "cmake" => :build

  resource "Cheetah" do
    url "https://pypi.python.org/packages/source/C/Cheetah/Cheetah-2.4.4.tar.gz"
    sha1 "c218f5d8bc97b39497680f6be9b7bd093f696e89"
  end

  def install
    ENV.prepend_create_path 'PYTHONPATH', libexec+'lib/python2.7/site-packages'
    python_args = ["install", "--prefix=#{libexec}"]
    %w[Cheetah].each do |r|
      resource(r).stage { system "python", "setup.py", *python_args }
    end

    mkdir "build" do
      system "cmake", "..", *std_cmake_args << "-DPYTHON_LIBRARY=#{python_path}/Frameworks/Python.framework/"
      system "make", "install"
    end
  end

  test do
    system "false"
  end

  def python_path
    python = Formula.factory('python')
    kegs = python.rack.children.reject { |p| p.basename.to_s == '.DS_Store' }
    kegs.find { |p| Keg.new(p).linked? } || kegs.last
  end
end
