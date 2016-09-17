import Foundation
import Alamofire

struct TwitchApiClient : TwitchApi {
    func getStreamsForChannel(channel : String, completionHandler: (streams: [TwitchStreamVideo]?, error: ServiceError?) -> ()){
        //First we build the url according to the channel we desire to get stream link
        let accessUrlString = String(format: "https://api.twitch.tv/api/channels/%@/access_token", channel)

        Alamofire.request(.GET, accessUrlString, headers :
            [   "Client-ID"   : "jzkbprff40iqj646a697cyrvl0zt2m6"])
            .responseJSON { response in

                if response.result.isSuccess {
                    if let accessInfoDict = response.result.value as? [String : AnyObject] {
                        if let sig = accessInfoDict["sig"] as? String {
                            if let token = accessInfoDict["token"] as? String {
                                let playlistUrlString  = String(format : "http://usher.twitch.tv/api/channel/hls/%@.m3u8", channel)

                                Alamofire.request(.GET, playlistUrlString, parameters :
                                    [   "player"            : "twitchweb",
                                        "allow_audio_only"  : "true",
                                        "allow_source"      : "true",
                                        "type"              : "any",
                                        "p"                 : Int(arc4random_uniform(99999)),
                                        "token"             : token,
                                        "sig"               : sig],
                                    headers :
                                    [   "Client-ID"   : "jzkbprff40iqj646a697cyrvl0zt2m6"])
                                    .responseString { response in
                                        if response.result.isSuccess {
                                            guard let _ = response.result.value else {
                                                Logger.Error("Response had no value")
                                                completionHandler(streams: nil, error: .DataError)
                                                return
                                            }
                                            if let streams = M3UParser.parseToDict(response.result.value!) {
                                                Logger.Debug("Returned \(streams.count) results")
                                                completionHandler(streams: streams, error: nil)
                                                return
                                            }
                                            else {
                                                //Error parsing the .m3u8
                                                Logger.Error("Could not parse the .m3u8 file")
                                                completionHandler(streams: nil, error: .OtherError("Parser error"))
                                                return
                                            }

                                        }
                                        else {
                                            //Error retrieving the .m3u8
                                            Logger.Error("Could not get the .m3u8 file")
                                            completionHandler(streams: nil, error: .URLError)
                                            return
                                        }
                                }
                                return
                            }
                        }
                    }
                    //Error with the access token json response
                    Logger.Error("Could not parse the access token response as JSON Stream")
                    completionHandler(streams: nil, error: .JSONError)
                    return

                }
                else {
                    //Error with access token request
                    Logger.Error("Could not request the access token")
                    completionHandler(streams: nil, error: .URLError)
                    return

                }
        }

    }

    ///This is a method to retrieve the most popular Twitch games
    ///
    /// - parameters:
    ///     - offset: An integer offset to load content after the primary results (useful when you reach the end of a scrolling list)
    ///     - limit: The number of games to return
    ///     - completionHandler: A closure providing results and an error (both optionals) to be executed once the request completes
    func getTopGamesWithOffset(offset : Int, limit : Int, completionHandler: (games: [TwitchGame]?, error: ServiceError?) -> ()) {
        //First we build the url according to the game we desire to get infos
        let gamesUrlString = "https://api.twitch.tv/kraken/games/top"

        Alamofire.request(.GET, gamesUrlString, parameters :
            [   "Client-ID"   : "jzkbprff40iqj646a697cyrvl0zt2m6",
                "limit"       : limit,
                "offset"      : offset],
            headers :
            [   "Client-ID"   : "jzkbprff40iqj646a697cyrvl0zt2m6"])
            .responseJSON { response in

                if response.result.isSuccess {
                    if let gamesInfoDict = response.result.value as? [String : AnyObject] {
                        if let gamesDicts = gamesInfoDict["top"] as? [[String : AnyObject]] {
                            var games = [TwitchGame]()
                            for gameRaw in gamesDicts {
                                if let game = TwitchGame(dict: gameRaw) {
                                    games.append(game)
                                }
                            }
                            Logger.Debug("Returned \(games.count) results")
                            completionHandler(games: games, error: nil)
                            return
                        }
                    }
                    Logger.Error("Could not parse response as JSON Games List")
                    completionHandler(games: nil, error: .JSONError)
                    return
                }
                else {
                    Logger.Error("Could not request top games")
                    completionHandler(games: nil, error: .URLError)
                    return
                }
        }
    }

    ///This is a method to retrieve the most popular Twitch streams for a given game
    ///
    /// - parameters:
    ///     - game: The game that we are attempting to get the streams for
    ///     - offset: An integer offset to load content after the primary results (useful when you reach the end of a scrolling list)
    ///     - limit: The number of streams to return
    ///     - completionHandler: A closure providing results and an error (both optionals) to be executed once the request completes
    func getTopStreamsForGameWithOffset(game : String, offset : Int, limit : Int, completionHandler: (streams: [TwitchStream]?, error: ServiceError?) -> ()) {
        //First we build the url according to the game we desire to get infos
        let streamsUrlString = "https://api.twitch.tv/kraken/streams"

        Alamofire.request(.GET, streamsUrlString, parameters :
            [   "limit"         : limit,
                "offset"        : offset,
                "game"          : game,
                "stream_type"   : "live"],
            headers :
            [   "Client-ID"   : "jzkbprff40iqj646a697cyrvl0zt2m6"])
            .responseJSON { response in

                if response.result.isSuccess {
                    if let streamsInfoDict = response.result.value as? [String : AnyObject] {
                        if let streamsDicts = streamsInfoDict["streams"] as? [[String : AnyObject]] {
                            var streams = [TwitchStream]()
                            for streamRaw in streamsDicts {
                                if let channelDict = streamRaw["channel"] as? [String : AnyObject] {
                                    if let channel = TwitchChannel(dict: channelDict), stream = TwitchStream(dict: streamRaw, channel: channel) {
                                        streams.append(stream)
                                    }
                                }
                            }
                            Logger.Debug("Returned \(streams.count) results")
                            completionHandler(streams: streams, error: nil)
                            return
                        }
                    }
                    Logger.Error("Could not parse response as JSON Stream List")
                    completionHandler(streams: nil, error: .JSONError)
                    return
                }
                else {
                    Logger.Error("Could not request top streams")
                    completionHandler(streams: nil, error: .URLError)
                    return
                }
        }
    }

    ///This is a method to retrieve Twitch games based on a search term
    ///
    /// - parameters:
    ///     - term: A search term
    ///     - offset: An integer offset to load content after the primary results (useful when you reach the end of a scrolling list)
    ///     - limit: The number of games to return
    ///     - completionHandler: A closure providing results and an error (both optionals) to be executed once the request completes
    func getGamesWithSearchTerm(term: String, offset : Int, limit : Int, completionHandler: (games: [TwitchGame]?, error: ServiceError?) -> ()) {
        //First we build the url according to the game we desire to get infos
        let searchUrlString = "https://api.twitch.tv/kraken/search/games"

        Alamofire.request(.GET, searchUrlString, parameters :
            [   "query"     : term,
                "type"      : "suggest",
                "live"      : true],
            headers :
            [   "Client-ID"   : "jzkbprff40iqj646a697cyrvl0zt2m6"])
            .responseJSON { response in

                if response.result.isSuccess {
                    if let gamesInfoDict = response.result.value as? [String : AnyObject] {
                        if let gamesDicts = gamesInfoDict["games"] as? [[String : AnyObject]] {
                            var games = [TwitchGame]()
                            for gameDict in gamesDicts {
                                if let game = TwitchGame(dict: gameDict) {
                                    games.append(game)
                                }
                            }
                            Logger.Debug("Returned \(games.count) results")
                            completionHandler(games: games, error: nil)
                            return
                        }
                    }
                    Logger.Error("Could not parse response as JSON")
                    completionHandler(games: nil, error: .JSONError)
                    return
                }
                else {
                    Logger.Error("Could not request games with search term")
                    completionHandler(games: nil, error: .URLError)
                    return
                }
        }
    }

    ///This is a method to retrieve Twitch streams based on a search term
    ///
    /// - parameters:
    ///     - term: A search term
    ///     - offset: An integer offset to load content after the primary results (useful when you reach the end of a scrolling list)
    ///     - limit: The number of streams to return
    ///     - completionHandler: A closure providing results and an error (both optionals) to be executed once the request completes
    func getStreamsWithSearchTerm(term : String, offset : Int, limit : Int, completionHandler: (streams: [TwitchStream]?, error: ServiceError?) -> ()) {
        //First we build the url according to the game we desire to get infos
        let streamsUrlString = "https://api.twitch.tv/kraken/search/streams"

        Alamofire.request(.GET, streamsUrlString, parameters :
            [   "limit"     : limit,
                "offset"    : offset,
                "query"     : term],
            headers :
            [   "Client-ID"   : "jzkbprff40iqj646a697cyrvl0zt2m6"])
            .responseJSON { response in

                if response.result.isSuccess {
                    if let streamsInfoDict = response.result.value as? [String : AnyObject] {
                        if let streamsDicts = streamsInfoDict["streams"] as? [[String : AnyObject]] {
                            var streams = [TwitchStream]()
                            for streamDict in streamsDicts {
                                if let channelDict = streamDict["channel"] as? [String : AnyObject] {
                                    if let channel = TwitchChannel(dict: channelDict), stream = TwitchStream(dict: streamDict, channel: channel) {
                                        streams.append(stream)
                                    }
                                }
                            }
                            Logger.Debug("Returned \(streams.count) results")
                            completionHandler(streams: streams, error: nil)
                            return
                        }
                    }
                    Logger.Error("Could not parse response as JSON")
                    completionHandler(streams: nil, error: .JSONError)
                    return
                }
                else {
                    Logger.Error("Could not request streams with search term")
                    completionHandler(streams: nil, error: .URLError)
                    return
                }
        }
    }

    ///This is a method to retrieve Twitch streams that a user is following
    ///
    /// - parameters:
    ///     - term: A search term
    ///     - offset: An integer offset to load content after the primary results (useful when you reach the end of a scrolling list)
    ///     - limit: The number of games to return
    ///     - completionHandler: A closure providing results and an error (both optionals) to be executed once the request completes
    func getStreamsThatUserIsFollowing(offset : Int, limit : Int, completionHandler: (streams: [TwitchStream]?, error: ServiceError?) -> ()) {

        guard let token = TokenHelper.getTwitchToken() else {
            completionHandler(streams: nil, error: .AuthError)
            return
        }
        //First we build the url according to the game we desire to get infos
        let streamsUrlString = "https://api.twitch.tv/kraken/streams/followed"

        Alamofire.request(.GET, streamsUrlString, parameters :
            [   "limit"         : limit,
                "offset"        : offset,
                "oauth_token"   : token     ])
            .responseJSON { response in

                if response.result.isSuccess {
                    if let streamsInfoDict = response.result.value as? [String : AnyObject] {
                        if let streamsDicts = streamsInfoDict["streams"] as? [[String : AnyObject]] {
                            var streams = [TwitchStream]()
                            for streamDict in streamsDicts {
                                if let channelDict = streamDict["channel"] as? [String : AnyObject] {
                                    if let channel = TwitchChannel(dict: channelDict), stream = TwitchStream(dict: streamDict, channel: channel) {
                                        streams.append(stream)
                                    }
                                }
                            }
                            Logger.Debug("Returned \(streams.count) results")
                            completionHandler(streams: streams, error: nil)
                            return
                        }
                    }
                    Logger.Error("Could not parse response as JSON")
                    completionHandler(streams: nil, error: .JSONError)
                    return
                }
                else {
                    Logger.Error("Could not request followed streams by user")
                    completionHandler(streams: nil, error: .URLError)
                    return
                }
        }
    }

    func getEmoteUrlStringFromId(id : String) -> String {
        return  "http://static-cdn.jtvnw.net/emoticons/v1/\(id)/1.0"
    }
}
