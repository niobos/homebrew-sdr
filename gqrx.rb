require "formula"

class Gqrx < Formula
  homepage "http://gqrx.dk"
  head "https://github.com/csete/gqrx.git", :revision => "0bbfd3832943739cbe4c3ee2642e4347c4b00753"

  depends_on 'pkg-config' => :build
  depends_on 'gnuradio'
  depends_on 'librtlsdr'
  depends_on 'gr-osmosdr'
  depends_on 'qt'

  def install
    args = "PREFIX=#{prefix}"
    mkdir "build" do
      system "qmake", "..", *args
      system "make"
    end
    Dir.glob("build/*.app") { |app| mv app, prefix }
  end

  test do
    system "false"
  end
end
