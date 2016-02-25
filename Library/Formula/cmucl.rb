class Cmucl < Formula
  desc "High-performance, free Common Lisp implementation"
  homepage "http://www.cons.org/cmucl/"
  url "https://common-lisp.net/project/cmucl/downloads/release/21a/cmucl-src-21a.tar.bz2"
  sha256 "41604a4f828a134dbf8a58623f45bd81b76ae05fc5c4cea5ccb74edfdc9e3167"

  resource "bootstrap" do
    url "https://common-lisp.net/project/cmucl/downloads/release/21a/cmucl-21a-x86-darwin.tar.bz2"
    sha256 "592dc868166435ce3392a41852293511f4686ca358be5c32d4c64449279614b9"
  end

  def install
    (buildpath/"bootstrap").install resource("bootstrap")

    inreplace "src/lisp/Config.x86_darwin" do |s|
      s.sub! "-mmacosx-version-min=10.5", "-mmacosx-version-min=#{MacOS.version}"
      s.sub! "m32", "m#{MacOS.prefer_64_bit? ? 64 : 32}"
    end

    if MacOS.prefer_64_bit?
      inreplace "src/lisp/Config.x86_common", "-Di386", "-Dx86"
      %w[src/lisp/core.h src/lisp/coreparse.c].each do |f|
        inreplace f,
                  "#if !(defined(alpha) || defined(__x86_64))",
                  "#if (defined(alpha) || defined(__x86_64))"
      end
    end

    inreplace "src/lisp/lispregs.h",
              "#ifdef __x86_64",
              "#if defined(__x86_64) && !defined(__APPLE__)"

    system "bin/build.sh", "-C", "", "-o", buildpath/"bootstrap/bin/lisp"
    bin.install "build-4/bin/lisp"
    lib.install Dir["build-4/lib/*"]
    doc.install Dir["build-4/doc/cmucl/*"]
    man.install Dir["build-4/man/man1/*"]
  end

  test do
  end
end
