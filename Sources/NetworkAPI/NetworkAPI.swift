import Alamofire
import Foundation

public protocol NetworkAPI {
    
    associatedtype ResultType
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters { get }
    var encoding: ParameterEncoding { get }
}

extension NetworkAPI {
    
    public var url: URL {
        baseURL.appendingPathComponent(path)
    }
    
    public var method: HTTPMethod {
        .get
    }
    
    public var headers: HTTPHeaders {
        []
    }
    
    public var parameters: Parameters {
        [:]
    }
    
    public var encoding: ParameterEncoding {
        URLEncoding.default
    }
}
