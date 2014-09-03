require 'nokogiri'
require 'open-uri'
require 'uri'

module TheTVDB

  class NoResultsException < Exception
  end

  class NoEpisodeException < Exception
  end

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
      nodes = doc.xpath('//Series')
      raise NoResultsException, 'No results found.' if nodes.empty?
      @results = nodes.map do |item|
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

    def seriesid
      if @results.count > 0 then
        @results[@pointer][:id]
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
      begin
        doc = Nokogiri::XML(open(url))
      rescue OpenURI::HTTPError
        raise NoEpisodeException, "No episode found for S#{season}E#{episode}."
      end
      nodes = doc.xpath('//Episode')
      raise NoEpisodeException, "No episode found for S#{season}E#{episode}." if nodes.empty?
      showinfo = nodes.first
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
