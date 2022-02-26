//
//  MockImageNetworkManager.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/27.
//

import Foundation
@testable import CatchLunch
import UIKit

final class MockImageNetworkManager: NetworkManagable {
    private(set) var request: MockSessionStatus?
    private(set) var session: MockSession


    private var correctImageData: Data {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "dummyImage", ofType: ".jpg") else {
            fatalError("invalid path")
        }
        guard let image = UIImage(contentsOfFile: path) else {
            fatalError("can not find image")
        }
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            fatalError("failed to convert to data from image")
        }
        return data
    }

    private var incorrectImageData: Data {
        let blahblah = "askdjsipfbjsfdipkfsdjipdjfewiagbjipdfbjipn"
        return blahblah.data(using: .utf8)!
    }

    init(session: MockSession = MockSession()) {
        self.session = session
    }

    func setUpRequest(with request: Requestable) {
        self.request = request
    }

    func dataTask(completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard let request = request else {
            completionHandler(.failure(NetworkError.requestIsNotExist))
            return
        }

        session.dataTask(with: request) { data, response, error in
            switch request {
            case .dataIsExist:
                completionHandler(.success(self.correctImageData))
            case .dataIsNotExist:
                completionHandler(.success(self.incorrectImageData))
            case .clientError:
                completionHandler(.failure(NetworkError.clientError(code: 400)))
            case .serverError:
                completionHandler(.failure(NetworkError.clientError(code: 500)))
            case .otherResponseError:
                completionHandler(.failure(NetworkError.clientError(code: 999)))
            case .criticalError:
                completionHandler(.failure(NetworkError.dataIsNotExist))
            }
        }.resume()
    }
}
