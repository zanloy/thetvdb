Gem::Specification.new do |s|
  s.name      = 'thetvdb'
  s.version   = '0.3'
  s.date      = '2014-09-05'
  s.summary   = 'Very simple interface to TheTVDB API'
  s.authors   = ['Zan Loy']
  s.email     = 'zan.loy@gmail.com'
  s.files     = ['lib/thetvdb.rb']
  s.homepage  = 'http://zanloy.com/ruby/thetvdb/'
  s.license   = 'MIT'

  s.add_dependency 'nokogiri'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'ruby-gntp'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
end
