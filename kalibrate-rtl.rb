require "formula"

class KalibrateRtl < Formula
  homepage "https://github.com/steve-m/kalibrate-rtl"
  head "git://github.com/steve-m/kalibrate-rtl.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "fftw"
  depends_on "librtlsdr"

  # -lrt not needed (nor functional) on OSX
  patch :DATA

  def install
    ENV.append_path "PKG_CONFIG_PATH", "#{Formula["fftw"].lib}/pkgconfig"
    ENV.append_path "PKG_CONFIG_PATH", "#{Formula["librtlsdr"].lib}/pkgconfig"
    #print "#{ENV["PKG_CONFIG_PATH"]}\n"

    system "./bootstrap"
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end

__END__
--- a/src/Makefile.am	2015-04-14 09:56:02.000000000 +0200
+++ b/src/Makefile.am	2015-04-14 09:56:51.000000000 +0200
@@ -20,4 +20,4 @@
    version.h
 
 kal_CXXFLAGS = $(FFTW3_CFLAGS) $(LIBRTLSDR_CFLAGS)
-kal_LDADD = $(FFTW3_LIBS) $(LIBRTLSDR_LIBS) -lrt
+kal_LDADD = $(FFTW3_LIBS) $(LIBRTLSDR_LIBS)
