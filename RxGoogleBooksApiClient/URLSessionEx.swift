import Foundation
import GoogleBooksApiClient
import RxSwift
import RxCocoa

extension RxSwift.Reactive where Base: URLSession {
    
    public func response<A: GoogleBooksApiRequest, B: Deserializable>(request: A) -> Observable<B>
    where A.Result == B {
        guard let req = request.request else {
            return Observable.error(GoogleBooksApiClientError.unknown)
        }
        return self.data(request: req)
            .flatMap({ d -> Observable<B> in
                do {
                    guard let json = try JSONSerialization.jsonObject(with:d) as? [AnyHashable:Any] else {
                        return Observable.error(GoogleBooksApiClientError.unknown)
                    }
                    if let b = B.create(json) {
                        return Observable.just(b)
                    } else {
                        return Observable.error(GoogleBooksApiClientError.deserializationFailed(data: d))
                    }
                } catch {
                    return Observable.error(GoogleBooksApiClientError.unknown)
                }
            })
    }
    
    public func response<A: GoogleBooksApiRequest>(request: A) -> Observable<Bool>
    where A.Result == Bool {
            guard let req = request.request else {
                return Observable.error(GoogleBooksApiClientError.unknown)
            }
            return self.data(request: req)
                .map({ _ in true })
    }
    
}
