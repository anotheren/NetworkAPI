import Alamofire
import Foundation

public protocol AsyncNetworkAPI: NetworkAPI, AsyncTaskAPI {
    
}

extension AsyncNetworkAPI {
    
    func request(session: Session = .default) async throws -> ResultType {
        let request = session.request(url,
                                          method: method,
                                          parameters: parameters,
                                          encoding: encoding,
                                          headers: headers,
                                          interceptor: nil,
                                          requestModifier: nil)
        let dataTask = request.serializingData()
        context.dataTask = dataTask
        let data = try await dataTask.value
        return try handle(data: data)
    }
    
    func cancel() {
        context.dataTask?.cancel()
    }
}
