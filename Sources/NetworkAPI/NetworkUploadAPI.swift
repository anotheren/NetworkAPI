import Alamofire
import Foundation

public protocol NetworkUploadAPI: NetworkAPI {
    
    func handle(multipartFormData: MultipartFormData)
}

extension NetworkUploadAPI {
    
    public var method: HTTPMethod {
        .post
    }
}
