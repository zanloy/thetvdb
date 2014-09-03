Gem::Specification.new do |s|
    s.name      = 'thetvdb'
    s.version   = '0.3'
    s.date      = '2014-09-03'
    s.summary   = 'Very simple interface to TheTVDB API'
    s.authors   = ['Zan Loy']
    s.email     = 'zan.loy@gmail.com'
    s.files     = ["lib/thetvdb.rb"]
    s.homepage  = 'http://zanloy.com/scripts/ruby/thetvdb/'

    s.add_dependency('nokogiri')
end
