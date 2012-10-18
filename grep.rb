require 'formula'

class Grep < Formula
  homepage 'http://www.gnu.org/software/grep/'
  url 'http://ftpmirror.gnu.org/grep/grep-2.14.tar.xz'
  mirror 'http://ftp.gnu.org/gnu/grep/grep-2.14.tar.xz'
  sha256 'e70e801d4fbb16e761654a58ae48bf5020621c95c8e35bd864742577685872e1'

  depends_on 'xz' => :build
  depends_on 'pcre'

  def install
    # find the correct libpcre
    pcre = Formula.factory('pcre')
    ENV.append 'LDFLAGS', "-L#{pcre.lib} -lpcre"
    ENV.append 'CPPFLAGS', "-I#{pcre.include}"

    system "./configure", "--disable-dependency-tracking",
                          "--disable-nls",
                          "--prefix=#{prefix}",
                          "--infodir=#{info}",
                          "--mandir=#{man}"
    system "make"
    system "make install"
  end
end
