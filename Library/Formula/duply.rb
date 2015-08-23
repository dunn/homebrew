class Duply < Formula
  desc "Frontend to the duplicity backup system"
  homepage "http://duply.net"
  url "https://downloads.sourceforge.net/project/ftplicity/duply%20%28simple%20duplicity%29/1.10.x/duply_1.10.1.tgz"
  sha256 "78f3714b0dc39657e2b3030e206370d38205305ca484e212704dcf77f9e70d35"

  depends_on "duplicity"

  def install
    bin.install "duply"
  end

  test do
    system bin/"duply", "test", "create"
  end
end
