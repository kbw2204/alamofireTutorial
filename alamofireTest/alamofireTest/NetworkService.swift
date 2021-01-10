//
//  NetworkService.swift
//  alamofireTest
//
//  Created by 융융 on 2021/01/10.
//

import Foundation

import Alamofire

final class NetworkService {
    static let shared = NetworkService()
    
    private let baseURL = "https://api.itbook.store/1.0/"
    
    func requestSearchBook(
        _ query: String,
        _ page: Int,
        _ completion: @escaping (Result<[Book], Error>) -> () // Result 타입을 사용하면 좋아요.
    ) {
        // url을
        let url = baseURL + "search/" + "\(query)/\(page)"
        // 인코딩 해주고 (스페이스 같은 부분들 처리해줄 수 있어용)
        if let urlEncoding = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            AF
                .request(urlEncoding, method: .get) // request 보냅니당
                .responseJSON { response in // response를 받아와서
                    switch response.result {
                    case .success(let jsonData): // 잘 가져왔다면
                        do {
                            let json = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                            let result = try JSONDecoder().decode(Books.self, from: json)
                            let books: [Book] = result.books
                            completion(.success(books)) // 성공하면 핸들러로 넘겨주고
                        } catch(let error) {
                            completion(.failure(error))
                        }
                    case .failure(let error): // 실패했다면 에러처리..
                        completion(.failure(error)) // 실패해도 핸들러로 넘겨줌..
                    }
                }
        }
    }
}
