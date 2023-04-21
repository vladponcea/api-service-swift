import Foundation

public final class APIService  {
    public init() { }
    
    enum APIServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    // MARK: - Public
    @available(iOS 13.0.0, *)
    public func execute<T: Codable>(
        _ request: APIRequest,
        expecting type: T.Type
    ) async throws -> (T, URLResponse) {
        guard let urlRequest = self.request(from: request) else {
            throw APIServiceError.failedToCreateRequest
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            let model = try JSONDecoder().decode(type.self, from: data)
            return (model, response)
        } catch {
            throw error
        }
    }
    
    public func execute<T: Codable>(
        _ request: APIRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(APIServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data,
                  error == nil else {
                completion(.failure(error ?? APIServiceError.failedToGetData))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(type.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    public func execute(
        _ request: APIRequest,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(APIServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data,
                  error == nil else {
                completion(.failure(error ?? APIServiceError.failedToGetData))
                return
            }
            
            completion(.success(String(data: data, encoding: .utf8) ?? ""))
        }
        
        task.resume()
    }
    
    // MARK: - Private
    private func request(from apiRequest: APIRequest) -> URLRequest? {
        guard let url = apiRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.httpMethod
        
        return request
    }
}
