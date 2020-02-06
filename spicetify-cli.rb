class SpicetifyCli < Formula
  desc "Command-line tool to customize Spotify client"
  homepage "https://github.com/khanhas/spicetify-cli"
  url "https://github.com/khanhas/spicetify-cli/archive/v0.9.7.tar.gz"
  sha256 "4ffcf1977b95148f68a28f007e3e2f7904260a7154ba6028a10b3cea45ad6d0e"
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath/"dep"
    buildpath.install

    cd buildpath do
      system "go", "build", "-o", "spicetify"

      prefix.install "globals.d.ts", "jsHelper", "spicetify",
                     "Themes", "Extensions", "CustomApps"
      bin.install_symlink prefix/"spicetify"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spicetify -v")
  end
end
