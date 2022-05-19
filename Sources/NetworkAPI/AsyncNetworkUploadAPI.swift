import Alamofire
import Foundation

public protocol AsyncNetworkUploadAPI: NetworkUploadAPI, AsyncTaskAPI {
    
}

extension AsyncNetworkUploadAPI {
    
    public func upload(session: Session = .default, uploadProgress: ((Progress) -> Void)? = nil) async throws -> ResultType {
        let request = session.upload(multipartFormData: { formData in
            self.handle(multipartFormData: formData)
        },
                                     to: url,
                                     method: method,
                                     headers: headers,
                                     interceptor: nil,
                                     requestModifier: nil)
        if let uploadProgress = uploadProgress {
            request.uploadProgress { progress in
                uploadProgress(progress)
            }
        }
        let dataTask = request.serializingData()
        context.dataTask = dataTask
        let data = try await dataTask.value
        return try handle(data: data)
    }
}

