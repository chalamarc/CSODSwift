//
//  GistRouter.swift
//  csodSwiftREST
//
//  Created by Chalama Challa on 2015-11-29.
//

import Foundation
import Alamofire

enum GistRouter: URLRequestConvertible {
  static let baseURLString:String = "https://api.github.com"
  
  case GetPublic() // GET https://api.github.com/gists/public
  case GetMyStarred() // GET https://api.github.com/gists/starred
  case GetMine() // GET https://api.github.com/gists
  case GetAtPath(String) // GET at given path
  case IsStarred(String) // GET https://api.github.com/gists/\(gistId)/star
  case Star(String) // PUT https://api.github.com/gists/\(gistId)/star
  case Unstar(String) // DELETE https://api.github.com/gists/\(gistId)/star
  case Create([String: AnyObject]) // POST https://api.github.com/gists
  case Delete(String) // DELETE https://api.github.com/gists/\(gistId)
  
  var URLRequest: NSMutableURLRequest {
    var method: Alamofire.Method {
      switch self {
      case .GetPublic:
        return .GET
      case .GetMyStarred:
        return .GET
      case .GetMine:
        return .GET
      case .GetAtPath:
        return .GET
      case IsStarred:
        return .GET
      case .Star:
        return .PUT
      case .Unstar:
        return .DELETE
      case .Delete:
        return .DELETE
      case .Create:
        return .POST
      }
    }
    
    let result: (path: String, parameters: [String: AnyObject]?) = {
      switch self {
      case .GetPublic:
        return ("/gists/public", nil)
      case .GetMyStarred:
        return ("/gists/starred", nil)
      case .GetMine:
        return ("/gists", nil)
      case .GetAtPath(let path):
        let URL = NSURL(string: path)
        let relativePath = URL!.relativePath!
        return (relativePath, nil)
      case .IsStarred(let id):
        return ("/gists/\(id)/star", nil)
      case .Star(let id):
        return ("/gists/\(id)/star", nil)
      case .Unstar(let id):
        return ("/gists/\(id)/star", nil)
      case .Delete(let id):
        return ("/gists/\(id)", nil)
      case .Create(let params):
        return ("/gists", params)
      }
    }()
    
    let URL = NSURL(string: GistRouter.baseURLString)!
    let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
    
    // Set OAuth token if we have one
    if let token = GitHubAPIManager.sharedInstance.OAuthToken {
      URLRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    
    let encoding = Alamofire.ParameterEncoding.JSON
    let (encodedRequest, _) = encoding.encode(URLRequest, parameters: result.parameters)
    
    encodedRequest.HTTPMethod = method.rawValue
    
    return encodedRequest
  }
}
