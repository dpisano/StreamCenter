import Foundation
@testable import StreamCenter

// this file was generated by Xcode-Better-Refactor-Tools
// https://github.com/tjarratt/xcode-better-refactor-tools

class FakeTwitchApi : TwitchApi, Equatable {
    init() {
    }

    private(set) var getStreamsForChannelCallCount : Int = 0
    var getStreamsForChannelStub : ((String, (streams: [TwitchStreamVideo]?, error: ServiceError?) -> ()) -> ())?
    private var getStreamsForChannelArgs : Array<(String, (streams: [TwitchStreamVideo]?, error: ServiceError?) -> ())> = []
    func getStreamsForChannelReturns(stubbedValues: ()) {
        self.getStreamsForChannelStub = {(channel: String, completionHandler: (streams: [TwitchStreamVideo]?, error: ServiceError?) -> ()) -> () in
            return stubbedValues
        }
    }
    func getStreamsForChannelArgsForCall(callIndex: Int) -> (String, (streams: [TwitchStreamVideo]?, error: ServiceError?) -> ()) {
        return self.getStreamsForChannelArgs[callIndex]
    }
    func getStreamsForChannel(channel: String, completionHandler: (streams: [TwitchStreamVideo]?, error: ServiceError?) -> ()) -> () {
        self.getStreamsForChannelCallCount += 1
        self.getStreamsForChannelArgs.append((channel, completionHandler))
        return self.getStreamsForChannelStub!(channel, completionHandler)
    }

    private(set) var getTopGamesWithOffsetCallCount : Int = 0
    var getTopGamesWithOffsetStub : ((Int, Int, (games: [TwitchGame]?, error: ServiceError?) -> ()) -> ())?
    private var getTopGamesWithOffsetArgs : Array<(Int, Int, (games: [TwitchGame]?, error: ServiceError?) -> ())> = []
    func getTopGamesWithOffsetReturns(stubbedValues: ()) {
        self.getTopGamesWithOffsetStub = {(offset: Int, limit: Int, completionHandler: (games: [TwitchGame]?, error: ServiceError?) -> ()) -> () in
            return stubbedValues
        }
    }
    func getTopGamesWithOffsetArgsForCall(callIndex: Int) -> (Int, Int, (games: [TwitchGame]?, error: ServiceError?) -> ()) {
        return self.getTopGamesWithOffsetArgs[callIndex]
    }
    func getTopGamesWithOffset(offset: Int, limit: Int, completionHandler: (games: [TwitchGame]?, error: ServiceError?) -> ()) -> () {
        self.getTopGamesWithOffsetCallCount += 1
        self.getTopGamesWithOffsetArgs.append((offset, limit, completionHandler))
        return self.getTopGamesWithOffsetStub!(offset, limit, completionHandler)
    }

    private(set) var getTopStreamsForGameWithOffsetCallCount : Int = 0
    var getTopStreamsForGameWithOffsetStub : ((String, Int, Int, (streams: [TwitchStream]?, error: ServiceError?) -> ()) -> ())?
    private var getTopStreamsForGameWithOffsetArgs : Array<(String, Int, Int, (streams: [TwitchStream]?, error: ServiceError?) -> ())> = []
    func getTopStreamsForGameWithOffsetReturns(stubbedValues: ()) {
        self.getTopStreamsForGameWithOffsetStub = {(game: String, offset: Int, limit: Int, completionHandler: (streams: [TwitchStream]?, error: ServiceError?) -> ()) -> () in
            return stubbedValues
        }
    }
    func getTopStreamsForGameWithOffsetArgsForCall(callIndex: Int) -> (String, Int, Int, (streams: [TwitchStream]?, error: ServiceError?) -> ()) {
        return self.getTopStreamsForGameWithOffsetArgs[callIndex]
    }
    func getTopStreamsForGameWithOffset(game: String, offset: Int, limit: Int, completionHandler: (streams: [TwitchStream]?, error: ServiceError?) -> ()) -> () {
        self.getTopStreamsForGameWithOffsetCallCount += 1
        self.getTopStreamsForGameWithOffsetArgs.append((game, offset, limit, completionHandler))
        return self.getTopStreamsForGameWithOffsetStub!(game, offset, limit, completionHandler)
    }

    private(set) var getGamesWithSearchTermCallCount : Int = 0
    var getGamesWithSearchTermStub : ((String, Int, Int, (games: [TwitchGame]?, error: ServiceError?) -> ()) -> ())?
    private var getGamesWithSearchTermArgs : Array<(String, Int, Int, (games: [TwitchGame]?, error: ServiceError?) -> ())> = []
    func getGamesWithSearchTermReturns(stubbedValues: ()) {
        self.getGamesWithSearchTermStub = {(term: String, offset: Int, limit: Int, completionHandler: (games: [TwitchGame]?, error: ServiceError?) -> ()) -> () in
            return stubbedValues
        }
    }
    func getGamesWithSearchTermArgsForCall(callIndex: Int) -> (String, Int, Int, (games: [TwitchGame]?, error: ServiceError?) -> ()) {
        return self.getGamesWithSearchTermArgs[callIndex]
    }
    func getGamesWithSearchTerm(term: String, offset: Int, limit: Int, completionHandler: (games: [TwitchGame]?, error: ServiceError?) -> ()) -> () {
        self.getGamesWithSearchTermCallCount += 1
        self.getGamesWithSearchTermArgs.append((term, offset, limit, completionHandler))
        return self.getGamesWithSearchTermStub!(term, offset, limit, completionHandler)
    }

    private(set) var getStreamsWithSearchTermCallCount : Int = 0
    var getStreamsWithSearchTermStub : ((String, Int, Int, (streams: [TwitchStream]?, error: ServiceError?) -> ()) -> ())?
    private var getStreamsWithSearchTermArgs : Array<(String, Int, Int, (streams: [TwitchStream]?, error: ServiceError?) -> ())> = []
    func getStreamsWithSearchTermReturns(stubbedValues: ()) {
        self.getStreamsWithSearchTermStub = {(term: String, offset: Int, limit: Int, completionHandler: (streams: [TwitchStream]?, error: ServiceError?) -> ()) -> () in
            return stubbedValues
        }
    }
    func getStreamsWithSearchTermArgsForCall(callIndex: Int) -> (String, Int, Int, (streams: [TwitchStream]?, error: ServiceError?) -> ()) {
        return self.getStreamsWithSearchTermArgs[callIndex]
    }
    func getStreamsWithSearchTerm(term: String, offset: Int, limit: Int, completionHandler: (streams: [TwitchStream]?, error: ServiceError?) -> ()) -> () {
        self.getStreamsWithSearchTermCallCount += 1
        self.getStreamsWithSearchTermArgs.append((term, offset, limit, completionHandler))
        return self.getStreamsWithSearchTermStub!(term, offset, limit, completionHandler)
    }

    private(set) var getStreamsThatUserIsFollowingCallCount : Int = 0
    var getStreamsThatUserIsFollowingStub : ((Int, Int, (streams: [TwitchStream]?, error: ServiceError?) -> ()) -> ())?
    private var getStreamsThatUserIsFollowingArgs : Array<(Int, Int, (streams: [TwitchStream]?, error: ServiceError?) -> ())> = []
    func getStreamsThatUserIsFollowingReturns(stubbedValues: ()) {
        self.getStreamsThatUserIsFollowingStub = {(offset: Int, limit: Int, completionHandler: (streams: [TwitchStream]?, error: ServiceError?) -> ()) -> () in
            return stubbedValues
        }
    }
    func getStreamsThatUserIsFollowingArgsForCall(callIndex: Int) -> (Int, Int, (streams: [TwitchStream]?, error: ServiceError?) -> ()) {
        return self.getStreamsThatUserIsFollowingArgs[callIndex]
    }
    func getStreamsThatUserIsFollowing(offset: Int, limit: Int, completionHandler: (streams: [TwitchStream]?, error: ServiceError?) -> ()) -> () {
        self.getStreamsThatUserIsFollowingCallCount += 1
        self.getStreamsThatUserIsFollowingArgs.append((offset, limit, completionHandler))
        return self.getStreamsThatUserIsFollowingStub!(offset, limit, completionHandler)
    }

    private(set) var getEmoteUrlStringFromIdCallCount : Int = 0
    var getEmoteUrlStringFromIdStub : ((String) -> (String))?
    private var getEmoteUrlStringFromIdArgs : Array<(String)> = []
    func getEmoteUrlStringFromIdReturns(stubbedValues: (String)) {
        self.getEmoteUrlStringFromIdStub = {(id: String) -> (String) in
            return stubbedValues
        }
    }
    func getEmoteUrlStringFromIdArgsForCall(callIndex: Int) -> (String) {
        return self.getEmoteUrlStringFromIdArgs[callIndex]
    }
    func getEmoteUrlStringFromId(id: String) -> (String) {
        self.getEmoteUrlStringFromIdCallCount += 1
        self.getEmoteUrlStringFromIdArgs.append((id))
        return self.getEmoteUrlStringFromIdStub!(id)
    }

    static func reset() {
    }
}

func == (a: FakeTwitchApi, b: FakeTwitchApi) -> Bool {
    return a === b
}