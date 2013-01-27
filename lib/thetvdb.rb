require 'nokogiri'
require 'open-uri'
require 'uri'

module TheTVDB
    class Client
        include Enumerable
        attr_reader :apikey
        def initialize(apikey)
            @apikey = apikey
            @base_url = "http://www.thetvdb.com"
            @results = {}
        end
        def search(query, options = {})
            default_options = { lang: 'en' }
            options = default_options.merge(options)
            query = URI.encode(query)
            search_url = "#{@base_url}/api/GetSeries.php?seriesname=#{query}&language=#{options[:lang]}"
            doc = Nokogiri::XML(open(search_url))
            @results = doc.xpath('//Series').map do |item|
                {
                    id: item.xpath('seriesid').text,
                    name: item.xpath('SeriesName').text,
                    overview: item.xpath('Overview').text,
                }
            end
            @pointer = 0
            @results
        end
        def seriesname
            if @results.count > 0 then
                @results[@pointer][:name]
            end
        end
        def each(&block)
            @results.each(&block)
        end
        def get_episode_info(season, episode, options = {})
            default_options = { lang: 'en' }
            options = default_options.merge(options)
            season = Integer(season)
            episode = Integer(episode)
            url = "#{@base_url}/api/#{@apikey}/series/#{@results[@pointer][:id]}/default/#{season}/#{episode}/#{options[:lang]}.xml"
            doc = Nokogiri::XML(open(url))
            showinfo = doc.xpath('//Episode').first
            result = {
                tvdb_id: showinfo.xpath('id').text,
                series_id: showinfo.xpath('seriesid').text,
                show: @results[@pointer][:name],
                season: season,
                episode: episode,
                name: showinfo.xpath('EpisodeName').text,
                first_aired: showinfo.xpath('FirstAired').text,
                director: showinfo.xpath('Director').text,
                overview: showinfo.xpath('Overview').text,
                imdb_id: showinfo.xpath('IMDB_ID').text,
            }
            result
        end
    end
end
