import XCTest
@testable import NetworkAPI

final class NetworkAPITests: XCTestCase {

    func testDownloadAPI() async throws {
        
        struct WechatSDKAPI: NetworkDownloadAPI {
            typealias ResultType = URL
            var baseURL: URL { URL(string: "https://res.wx.qq.com")! }
            var path: String { "/op_res/XP2S6Df6fFmoNCdbbD14fbkHfjxvl3Q4lw61HkI79tjBQjppRTgJSmJ1cYKIXZdQh9IeX2xXCWX7AqnzuWfUvw" }
        }
        
        let api = WechatSDKAPI()
        let url = try await api.download(progressing: { progress in
            print(progress.fractionCompleted)
        })
        print(url)
    }
}
