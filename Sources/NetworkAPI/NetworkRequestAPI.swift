import Alamofire
import Foundation

public protocol NetworkRequestAPI: NetworkAPI {
    
    func handle(data: Data) throws -> ResultType
}

extension NetworkRequestAPI {
    
    public func request(session: Session = .default,
                        interceptor: RequestInterceptor? = nil,
                        automaticallyCancelling: Bool = false) async throws -> ResultType {
        let request = session.request(url,
                                      method: method,
                                      parameters: parameters,
                                      encoding: encoding,
                                      headers: headers,
                                      interceptor: interceptor,
                                      requestModifier: nil)
        let dataTask = request.serializingData(automaticallyCancelling: automaticallyCancelling)
        let data = try await dataTask.value
        return try handle(data: data)
    }
    
    public func request2(session: Session = .default,
                         interceptor: RequestInterceptor? = nil) async throws -> ResultType {
        let request = session.request(url,
                                      method: method,
                                      parameters: parameters,
                                      encoding: encoding,
                                      headers: headers,
                                      interceptor: interceptor,
                                      requestModifier: nil)
        return try await withTaskCancellationHandler {
            return try await withCheckedThrowingContinuation { continuation in
                request.responseData { res in
                    switch res.result {
                    case .success(let data):
                        do {
                            let result = try handle(data: data)
                            continuation.resume(returning: result)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        } onCancel: {
            request.cancel()
        }
    }
}
