require 'spec_helper'

describe TheTVDB::Client do

  before :all do
    @apikey = File.read(File.join(File.dirname(__FILE__), '../apikey')).chomp
    @client = TheTVDB::Client.new(@apikey)
  end

  describe '#new' do

    it 'creates a Client object' do
      expect(@client).to be_a TheTVDB::Client
    end

    it 'stores the apikey' do
      expect(@client.apikey).to eql(@apikey)
    end

  end

  describe '#search' do

    before :all do
      @client.search('big bang theory')
    end

    it 'searches a show' do
      expect(@client.seriesname).to eql('The Big Bang Theory')
    end

    it 'has the correct tvdb id' do
      expect(@client.seriesid).to eql("80379")
    end

    it 'raises exception for bad search' do
      expect { @client.search('abcdefghijklmnopqrstuvwxyz') }.to raise_exception(TheTVDB::NoResultsException)
    end

    it 'is enumerable' do
      expect { @client.each { |i| } }.to_not raise_exception
    end

  end

  describe '#get_episode_info' do

    before :all do
      @client.search('big bang theory')
      @episode = @client.get_episode_info(1,1)
    end

    it 'returns the pilot episode' do
      expect(@episode[:name]).to eql('Pilot')
    end

    it 'raises exception on bad episode' do
      expect { @client.get_episode_info(0,0) }.to raise_exception(TheTVDB::NoEpisodeException)
    end

  end

end
