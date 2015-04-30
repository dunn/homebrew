class Mlt < Formula
  homepage "http://www.mltframework.org/"
  url "https://downloads.sourceforge.net/mlt/mlt/mlt-0.9.6.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/m/mlt/mlt_0.9.6.orig.tar.gz"
  sha256 "ab999992828a03dadbf62f6a131aada776cfd7afe63a94d994877fdba31a3000"

  head "http://github.com/mltframework/mlt.git"

  bottle do
    sha1 "8a672be9b09bf79c099755f822afd7837ee715a9" => :mavericks
    sha1 "6fbdbc9c2422836ce659989f096d1670570d1c57" => :mountain_lion
    sha1 "b5804ee50a521ee7f09c82fb3d58947ad4413990" => :lion
  end

  depends_on "pkg-config" => :build

  depends_on "atk"
  depends_on "ffmpeg"
  depends_on "frei0r"
  depends_on "libdv"
  depends_on "libsamplerate"
  depends_on "libvorbis"
  depends_on "sdl"
  depends_on "sox"

  depends_on "gtk+" => :optional

  if build.with? "gtk+"
    depends_on "pango"
    depends_on "gdk-pixbuf"
  end

  def install

    args = ["--prefix=#{prefix}",
            "--disable-jackrack",
            "--disable-swfdec"]

    args << "--disable-gtk" if build.without? "gtk+"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"melt", test_fixtures("test.mp3"),
           "-serialize", testpath/"test.melt"
    File.exist? testpath/"test.melt"
  end
end
