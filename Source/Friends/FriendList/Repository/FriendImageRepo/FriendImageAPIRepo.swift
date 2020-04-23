//
//  FriendImageRepo.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/20.
//

import Foundation

public class FriendImageAPIRepo {

  struct DataBundleKeys {
    static let user = "user"
  }
  
  struct ImageData: Codable{
    var data: [UInt8]
  }
  
  public init() { }

  public weak var observer: FriendImageRepoObserver?
  
}

extension FriendImageAPIRepo: FriendImageRepositoryType {
  
  public func findProfileImage(of user: User, using serviceCaller: ServiceCaller) {
    
    guard let url = URL(string: FeistyAPIURLComponents.imageURL) else {
      observer?.errorInGettingImageOf(user: user)
      return
    }
    
    let dataBundle = prepareDataBundle(withUser: user)
    
    serviceCaller.callFailedWithData = { _, dataBundle in
      
      let user = dataBundle.extraData[DataBundleKeys.user] as? User ?? User.defaultValue
      
      self.observer?.errorInGettingImageOf(user: user)
    }
    
    serviceCaller.callSucceeded = { data, dataBundle in
      
      let user = self.decodeProfileImage(using: data, andDataBundle: dataBundle)
      
      self.observer?.foundImageOf(user: user)
      
    }
    
    do {
      try serviceCaller.makeServiceCall(with: url, and: dataBundle, usingMethod: .post)
    } catch {
      return
    }
    
  }
  
  public func subscribeToRepository(with subscriber: FriendImageRepoObserver) {
    observer = subscriber
  }
  
  public func unsubscribeFromRepository(withID observerID: String) {
    observer = nil
  }
  
  private func prepareDataBundle(withUser user: User) -> DataBundle {
    
    let dataBundle = DataBundle()
    
    var loginParamters: [String: Any] = [:]
    loginParamters["userID"] = user.userID
    
    dataBundle.extraData[ServiceCallerDataBundleKeys.postParameters] = loginParamters
    dataBundle.extraData[DataBundleKeys.user] = user
    
    return dataBundle
    
  }
  
  private func decodeProfileImage(using data: Data, andDataBundle dataBundle: DataBundle) -> User {
    
    guard let imageDataFromAPI = try? JSONDecoder().decode(ImageData.self, from: data) else {
      return User.defaultValue
    }
    
    let user = dataBundle.extraData[DataBundleKeys.user] as? User ?? User.defaultValue
    
    let imageData = Data(bytes: imageDataFromAPI.data, count: imageDataFromAPI.data.count)
    user.profileImage = UIImage(data: imageData)
    
    return user
    
  }
  
}
