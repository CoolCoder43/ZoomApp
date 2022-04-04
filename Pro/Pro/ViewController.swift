//
//  ViewController.swift
//  Pro
//
//  Created by Deepak Dubey on 02/04/22.
//

import UIKit
import AppAuth
import AuthenticationServices
import Alamofire


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      //  configure()
        authWithSpotify()
        // Do any additional setup after loading the view.
    }
    func configure(){
        let configuration = OIDServiceConfiguration(
               authorizationEndpoint: URL(string: "https://zoom.us/oauth2/login")!,
               tokenEndpoint: URL(string: "https://zoom.us/oauth/token")!
           )

           // builds authentication request
           let request = OIDAuthorizationRequest(
               configuration: configuration,
               clientId: "HPdNtdbbQ6WYPCRklI_PYQ",
               clientSecret: "akJ8WQnUH7sQVXYL7vFCrBA51avonsU8",
               scope: nil,
               redirectURL: URL(string: "https://oauthexample.timeless.space/zoom")!,
               responseType: "code",
               state: nil,
               nonce: nil,
               codeVerifier: nil,
               codeChallenge: nil,
               codeChallengeMethod: nil,
               additionalParameters: nil
           )
        OIDAuthState.authState(
                    byPresenting: request,
                    presenting: self
                ) { authState, error in
                    guard error == nil else {
                        print("Zoom Authorization Error \(error!)")
                        return
                    }

                    if authState != nil {
                        print("Success!!")
                    }
                }
            }
    
    let spotifyID = ""
    
    
    func authWithSpotify() {

        let authUrlString = "https://zoom.us/oauth/authorize?response_type=code&client_id=jn3VU4PLSnK2RdMvVjzPWQ&redirect_uri=http%3A%2F%2Fstaging.teachmekw.com%2Fload_ios_app"
        guard let url = URL(string: authUrlString) else { return }

        let session = ASWebAuthenticationSession(
            url: url,
            callbackURLScheme: "http",
            completionHandler: { callback, error in

                guard error == nil, let success = callback else { return }

                let code = NSURLComponents(string: (success.absoluteString))?.queryItems?.filter({ $0.name == "code" }).first
                debugPrint(code?.value)
                getAuthToken(code: code!.value ?? "")
               // self.getSpotifyAuthToken(code)
        })

        session.presentationContextProvider = shimController
        session.start()
      }

}


var globalPresentationAnchor: ASPresentationAnchor? = nil
var shimController = ShimViewController() // << instantiate your object here


class ShimViewController: UIViewController, ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
    return  ASPresentationAnchor()
  }
}


func getAuthToken(code:String){
    let params = ["code":code, "grant_type":"authorization_code", "redirect_uri":"http://staging.teachmekw.com/load_ios_app"]
    //let headers = ["Authorization":"Basic am4zVlU0UExTbksyUmRNdlZqelBXUTppUWNlblM3Tm9DUFR4WGVIbXpUOFVGY0FnRmwwVjNZYg==", "Content-Type":"application/x-www-form-urlencoded"]
    let hd = HTTPHeader.init(name: "Authorization", value: "Basic am4zVlU0UExTbksyUmRNdlZqelBXUTppUWNlblM3Tm9DUFR4WGVIbXpUOFVGY0FnRmwwVjNZYg==")
    let  hdc = HTTPHeader.init(name: "Content-Type", value: "application/x-www-form-urlencoded")
    AF.request("https://zoom.us/oauth/token", method: .post, parameters: params,headers: [hd,hdc]).response { d in
        debugPrint(d.value)
        let testJSONData = try? JSONDecoder().decode(TestJSONData.self, from: d.data!)
        getZAK(accesToken: testJSONData!.accessToken)

    }
}

var zak:ZakData?
func getZAK(accesToken:String){
    let hd = HTTPHeader.init(name: "Authorization", value: "Bearer \(accesToken)")
    AF.request("https://api.zoom.us/v2/users/me/zak", method: .get,headers: [hd]).response { d in
        debugPrint(d)
        zak = try? JSONDecoder().decode(ZakData.self, from: d.data!)
    }
}




import Foundation

// MARK: - TestJSONData
struct TestJSONData: Codable {
    let accessToken, tokenType, refreshToken: String
    let expiresIn: Int
    let scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case scope
    }
}

// MARK: - ZakData
struct ZakData: Codable {
    let token: String
}
