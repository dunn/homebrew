class Aespipe < Formula
  desc "AES encryption or decryption for pipes"
  homepage "http://loop-aes.sourceforge.net/"
  url "http://loop-aes.sourceforge.net/aespipe/aespipe-v2.4d.tar.bz2"
  sha256 "c5ce656e0ade49b93e1163ec7b35450721d5743d8d804ad3a9e39add0389e50f"

  bottle do
    cellar :any
    sha1 "f3441fee13b4daab1a717abd55453791278206e2" => :yosemite
    sha1 "f72e5107d0ff2a6a9d215b956c806c6fcf4ba208" => :mavericks
    sha1 "77f01ed2cae7844319119520576e5b198ff4e9a0" => :mountain_lion
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"secret").write "thisismysecrethomebrewdonttellitplease"
    msg = "Hello this is Homebrew"
    encrypted = pipe_output("#{bin}/aespipe -P secret", msg)
    decrypted = pipe_output("#{bin}/aespipe -P secret -d", encrypted)
    assert_equal msg, decrypted.gsub(/\x0+$/, "")
  end
end
