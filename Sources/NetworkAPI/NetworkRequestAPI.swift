import Alamofire
import Foundation

public protocol NetworkRequestAPI: NetworkAPI {
    
    func handle(data: Data) throws -> ResultType
}

extension NetworkRequestAPI {
    
    public func request(session: Session = .default,
                        interceptor: RequestInterceptor? = nil) async throws -> ResultType {
        let request = session.request(url,
                                          method: method,
                                          parameters: parameters,
                                          encoding: encoding,
                                          headers: headers,
                                          interceptor: interceptor,
                                          requestModifier: nil)
        let dataTask = request.serializingData(automaticallyCancelling: true)
        let data = try await dataTask.value
        return try handle(data: data)
    }
}
