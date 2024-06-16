//
//  NetworkManager.swift
//  MyFavorite
//
//  Created by Bora Yang on 6/16/24.
//

import UIKit
import Alamofire

struct NetworkManager {
    private init() { }

    static func callRequest(query: String, page: Int, sort: ResultSort, success: @escaping (_ value: ResultEntity) -> Void) {
        let header: HTTPHeaders = [
            Constant.LiteralString.Networking.clientID: APIKey.naverClientID,
            Constant.LiteralString.Networking.clientSceret: APIKey.naverClientSecretKey
        ]

        let param: Parameters = [
            Constant.LiteralString.Networking.param.query.rawValue: query,
            Constant.LiteralString.Networking.param.start.rawValue: page,
            Constant.LiteralString.Networking.param.display.rawValue: Constant.LiteralNum.display,
            Constant.LiteralString.Networking.param.sort.rawValue: sort.rawValue
        ]

        AF.request(URLString.searchNaver,
                   parameters: param,
                   headers: header
        )
        .responseDecodable(of: ResultEntity.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
