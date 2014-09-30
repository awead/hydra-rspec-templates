require 'jettywrapper'

# Customizing hydra-jetty
#
# Specify a different release of hydra-jetty
#   Jettywrapper.hydra_jetty_version = "v7.1.0"
# Or, use a completely different jetty repository
#   Jettywrapper.url = "http://github.com/you/your-jetty-repo/archive/tagged-release.zip"

# We will use the latest release with Solr 4.9 and Fedora 3.7
Jettywrapper.hydra_jetty_version = "v7.1.0"

# Most of jettywrapper's default tasks are fine as-as, but we might want to do our
# own configuration.  The example below adds an additional configuration
# step to download additional jar files to our solr instance. The default fedora
# and solr configuration tasks are called which copy files from our repo's solr_conf
# and fedora_conf directories.
namespace :jetty do

  desc "Copies the default Solr & Fedora configs and jar files into the bundled Hydra Testing Server"
  task :config do
    Rake::Task["jetty:download_jars"].invoke
  end

  desc "Download additional jar files for Solr"
  task :download_jars do
    # Download jar files and copy them to solr in the jetty directory
  end

end
