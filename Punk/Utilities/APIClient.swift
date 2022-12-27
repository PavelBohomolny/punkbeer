//
//  APIClient.swift
//  Punk
//
//  Created by Pavel Bohomolnyi on 27/12/2022.
//

import Combine
import Foundation

enum FailureReason: Error {
    case error(Error)
    case invalidURL(String)
    case decodingFailed(Error)
    case incorrectURL
    case message(String)
    case unknown

    var message: String {
        switch self {
        case .error(let error), .decodingFailed(let error):
            return error.localizedDescription
        case .invalidURL(let message), .message(let message):
            return message
        case .incorrectURL:
            return "Incorrect URL"
        case .unknown:
            return "Unknown error"
        }
    }
}

class APIClient {
    private var pathGenerator: PathGenerator
    private var cancellables: [AnyCancellable] = []

    init(pathGenerator: PathGenerator) {
        self.pathGenerator = pathGenerator
    }

    // MARK: - Request
    private func request<T: Decodable>(_ endpoint: Endpoint<T>) throws -> AnyPublisher<T, FailureReason> {
        guard let request = self.request(for: endpoint) else {
            throw FailureReason.invalidURL("Can not generate correct url for \(endpoint.api) endpoint")
        }

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result in
                print("➡️ Network call to: \(request.url?.absoluteString ?? "n/a")")

                do {
                    return try JSONDecoder().decode(T.self, from: result.data)
                } catch {
                    print("⛔️ Failed with reason: \(error)")

                    // Trying to decode API message
                    if let apiError = try? JSONDecoder().decode(APIError.self, from: result.data) {
                        let detailedMessage = apiError.data?.first?.message ?? ""
                        let message = [apiError.message, detailedMessage].joined(separator: "\n")
                        throw FailureReason.message(message)
                    } else {
                        throw FailureReason.decodingFailed(error)
                    }
                }
            }
            .mapError { error in
                if let reason = error as? FailureReason {
                    return reason
                }
                return FailureReason.error(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func request<T: Decodable>(for endpoint: Endpoint<T>) -> URLRequest? {
        guard let url = pathGenerator.url(for: endpoint.api) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.HTTPMethod
        return request
    }

    // MARK: - Actual network cal
    func performRequest<T: Decodable>(
        endpoint: Endpoint<T>,
        completion: @escaping ((Result<T, FailureReason>) -> Void)) {

        try? self.request(endpoint)
            .sink(receiveCompletion: { receive in
                switch receive {
                case .failure(let failure):
                    completion(.failure(failure))
                case .finished:
                    break
                }
            }, receiveValue: { result in
                completion(.success(result))
            })
            .store(in: &cancellables)
    }
}
