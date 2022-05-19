import Alamofire
import Foundation

public class AsyncTaskContext {
    
    var dataTask: DataTask<Data>?
    
    public init() { }
}

public protocol AsyncTaskAPI {
    
    var context: AsyncTaskContext { get }
}
