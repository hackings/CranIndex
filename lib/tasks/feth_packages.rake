
require 'open-uri'
require 'dcf'
require 'rubygems/package'
namespace :carn_packages do
  desc 'Fetch carn packages for index'
  task fetch: [:environment] do
        
    package_string = open('https://cran.r-project.org/src/contrib/PACKAGES').read()
    package_list = Dcf.parse(package_string)
    package_list.each do |package|
      package_name = package['Package']
      package_version = package['Version']
      next if Package.exists?( name: package_name, version: package_version )
      
      download_string = "http://cran.r-project.org/src/contrib/#{package_name}_#{package_version}.tar.gz"
      puts download_string
      begin 
        download_source = open(download_string)
        tar_files = Gem::Package::TarReader.new(Zlib::GzipReader.open(download_source))
        package_dcf = tar_files.detect{|f| f.full_name.upcase == "#{package_name}/DESCRIPTION".upcase }.read()
        package_detail = Dcf.parse(package_dcf).first

        package_publication_date = package_detail['Date/Publication']
        package_title = package_detail['Title']
        package_description = package_detail['Description']
        package_authors = package_detail['Author'].to_s.split(',').reject(&:blank?)
        package_maintainers = package_detail['Maintainer'].to_s.split(',').reject(&:blank?)
       
        package = Package.new( name: package_name, version: package_version, 
      	  published_date: package_publication_date.to_date, title: package_title, description: package_description ) 

        package_authors.each do | author |
          email = author.strip.scan(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i).join
          name = author.strip.split(/<#{email}>/)[0]
          contributor = Contributor.find_or_initialize_by( name: name.titleize)
          contributor.update(email: email)
          package.package_authors << contributor
        end
        package_maintainers.each do | maintainer |
          email = maintainer.strip.scan(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i).join
          name = maintainer.strip.split(/<#{email}>/)[0]
          contributor = Contributor.find_or_initialize_by( name: name.titleize)
          contributor.update(email: email)
          package.package_maintainers << contributor
        end
        package.save

      rescue StandardError => e
        puts e.message
      end
        
    end 	

  end
end