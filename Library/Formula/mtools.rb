class Mtools < Formula
  homepage "https://www.gnu.org/software/mtools/"
  url "http://ftpmirror.gnu.org/mtools/mtools-4.0.18.tar.bz2"
  mirror "https://mirrors.kernel.org/debian/pool/main/m/mtools/mtools_4.0.18.orig.tar.bz2"
  sha256 "59e9cf80885399c4f229e5d87e49c0c2bfeec044e1386d59fcd0b0aead6b2f85"

  conflicts_with "multimarkdown", :because => "both install `mmd` binaries"

  depends_on :x11 => :optional

  fails_with :clang do
    build 602
    cause "error: use of undeclared identifier 'lookupState'"
  end

  def install
    args = ["LIBS=-liconv",
            "--disable-debug",
            "--prefix=#{prefix}"]

    if build.with? "x11"
      args << "--with-x"
    else
      args << "--without-x"
    end

    system "./configure", *args
    system "make"
    ENV.j1
    system "make", "install"
  end

  test do
    system bin/"mtoolstest"
  end
end
