import Alamofire
import Foundation

public protocol NetworkUploadAPI: NetworkAPI {
    
    func handle(data: Data) throws -> ResultType
    func handle(multipartFormData: MultipartFormData)
}

extension NetworkUploadAPI {
    
    public var method: HTTPMethod {
        .post
    }
    
    public func upload(session: Session = .default,
                       interceptor: RequestInterceptor? = nil,
                       progressing: ((Progress) -> Void)? = nil) async throws -> ResultType {
        let request = session.upload(multipartFormData: { formData in
            self.handle(multipartFormData: formData)
        },
                                     to: url,
                                     method: method,
                                     headers: headers,
                                     interceptor: nil,
                                     requestModifier: nil)
        if let progressing = progressing {
            request.uploadProgress { progress in
                progressing(progress)
            }
        }
        let task = request.serializingData(automaticallyCancelling: true)
        let data = try await task.value
        return try handle(data: data)
    }
}
