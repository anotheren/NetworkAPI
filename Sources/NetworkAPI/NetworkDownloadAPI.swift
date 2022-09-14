import Alamofire
import Foundation

public protocol NetworkDownloadAPI: NetworkAPI  {
    
}

extension NetworkDownloadAPI where ResultType == URL {
    
    public func download(session: Session = .default,
                         interceptor: RequestInterceptor? = nil,
                         progressing: ((Progress) -> Void)? = nil,
                         to destination: DownloadRequest.Destination? = nil) async throws -> URL {
        let request = session.download(url, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: nil, requestModifier: nil, to: destination)
        if let progressing = progressing {
            request.downloadProgress { progress in
                progressing(progress)
            }
        }
        let task = request.serializingDownloadedFileURL(automaticallyCancelling: true)
        let url = try await task.value
        return url
    }
}
