//
//  ViewController.swift
//  Pro
//
//  Created by Deepak Dubey on 02/04/22.
//

import UIKit
import AppAuth
import AuthenticationServices


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

        let authUrlString = "https://zoom.us/oauth/authorize?response_type=code&client_id=HPdNtdbbQ6WYPCRklI_PYQ&redirect_uri=http://staging.teachmekw.com/load_ios_app"
        guard let url = URL(string: authUrlString) else { return }

        let session = ASWebAuthenticationSession(
            url: url,
            callbackURLScheme: "http",
            completionHandler: { callback, error in

                guard error == nil, let success = callback else { return }

                let code = NSURLComponents(string: (success.absoluteString))?.queryItems?.filter({ $0.name == "code" }).first

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
