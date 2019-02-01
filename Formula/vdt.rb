class Vdt < Formula
  desc "The vdt mathematical library"
  homepage "https://github.com/dpiparo/vdt"
  url "https://github.com/elzoido238/homebrew-vdt.git"
  version "v0.4.2"

  depends_on "cmake"

  head do
    url "https://github.com/elzoido238/homebrew-vdt.git", :using => :git, :branch =>"master"
  end

  option "with-benchmarking", "Benchmarking tools and unit tests (requires C++11 support by the compiler)"
  option "with-static_libs", "Build static library"
  option "with-preload", "Prepare the library to be pre-loaded in order to replace the calls to the default math lib at runtime"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    args = []
    args << "-D DIAG=1" if build.with? "benchmarking"
    args << "-D BUILD_SHARED_LIBS=0" if build.with? "static_libs"
    args << "-D PRELOAD=1" if build.with? "preload"

    system "cmake", args,
           ".",
           *std_cmake_args
    system "make"
    system "make", "install"
  end

  # test do
  #   # `test do` will create, run in and delete a temporary directory.
  #   #
  #   # This test will fail and we won't accept that! For Homebrew/homebrew-core
  #   # this will need to be a test that verifies the functionality of the
  #   # software. Run the test with `brew test homebrew-vdt`. Options passed
  #   # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
  #   #
  #   # The installed folder is not in the path, so use the entire path to any
  #   # executables being tested: `system "#{bin}/program", "do", "something"`.
  #   system "false"
  # end
end
