Overview
--------

[TheTVDB.com][thetvdb] is a resource for sharing and collecting metadata for TV shows.

[thetvdb]: http://thetvdb.com/

Usage
-----

    require 'thetvdb'

    client = TheTVDB::Client.new(apikey)
    client.search('The Big Bang Theory')
    p client

