//
//  AlamofireServices.swift
//  Astute Assignment
//
//  Created by Yasin on 23/01/2022.
//

import Foundation
import Alamofire
class AlamofireServices {
    public static let shared = AlamofireServices()
    
    private let base_Url = "https://blogswizards.com/mobile_app_assignment/api/"
    
    func getAllImages(completion:@escaping((String?,Images?) -> Void)){
        AF.request(base_Url + "get_all_photos",method: .get).responseDecodable(of: Images.self) { response in
            switch response.result {
            case .success:
                switch response.response?.statusCode {
                case 200:
                    completion(nil,try! response.result.get())
                    break
                default:
                    completion(nil,nil)
                    break
                }
                break
            case let .failure(error):
                completion(error.localizedDescription,nil)
                break
            }
        }
    }

    func getImageDetailsByid(id: String,completion: @escaping((String?,ImageDetails?) -> Void)) {
        AF.request(base_Url + "get_single_photo_detail",method: .get,parameters: ["photo_id": id]).responseDecodable(of: ImageDetails.self) { response in
            switch response.result {
            case .success:
                switch response.response?.statusCode {
                case 200:
                    completion(nil,try! response.result.get())
                    break
                default:
                    completion(nil,nil)
                    break
                }
                break
            case let .failure(error):
                completion(error.localizedDescription,nil)
                break
            }
        }
    }
    
    func getSuggestedImages(id: String,completion:@escaping((String?,Images?) -> Void)) {
        AF.request(base_Url + "get_suggested_photos",method: .get,parameters: ["photo_id": id]).responseDecodable(of: Images.self) { response in
            switch response.result {
            case .success:
                switch response.response?.statusCode {
                case 200:
                    completion(nil,try! response.result.get())
                    break
                default:
                    completion(nil,nil)
                    break
                }
                break
            case let .failure(error):
                completion(error.localizedDescription,nil)
                break
            }
        }
    }
    
}
