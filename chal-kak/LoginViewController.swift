
import SwiftUI
import UIKit
import RxSwift
import RxCocoa
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import RxKakaoSDKAuth
import RxKakaoSDKCommon
import RxKakaoSDKUser


class LoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var loginButtonHeight: CGFloat = 40
    var loginButtonWidth: CGFloat = 200
    
    lazy var LoginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 15
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let appleButton: UIButton = {
        let btn = UIButton()
        btn.setImage(.appleLogin, for: .normal)
        return btn
    }()
    
    
    let kakaoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(.kakaoLogin, for: .normal)
        btn.addTarget(self, action: #selector(loginKakao), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addSubView()
        enableAutoLayout()
        setAutoLayout()
        LoginStackView.addArrangedSubview(appleButton)
        LoginStackView.addArrangedSubview(kakaoButton)
    }
    
    
    // MARK: - view에 addSubview하는 함수
    func addSubView() {
        view.addSubview(LoginStackView)
        view.addSubview(kakaoButton)
        view.addSubview(appleButton)
    }
    
    // MARK: - 오토레이아웃을 위한 세팅 함수
    func enableAutoLayout() {
        LoginStackView.translatesAutoresizingMaskIntoConstraints = false
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        kakaoButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    // MARK: - 오토레이아웃 설정 함수
    func setAutoLayout() {
        NSLayoutConstraint.activate([
            LoginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LoginStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            LoginStackView.heightAnchor.constraint(equalToConstant: loginButtonHeight*2 + 15 ),
            LoginStackView.widthAnchor.constraint(equalToConstant: loginButtonWidth),
            
            kakaoButton.widthAnchor.constraint(equalToConstant: loginButtonWidth),
            kakaoButton.heightAnchor.constraint(equalToConstant: loginButtonHeight),

            appleButton.widthAnchor.constraint(equalToConstant: loginButtonWidth),
            appleButton.heightAnchor.constraint(equalToConstant: loginButtonHeight)
        ])
    }
    
    
    // MARK: - 카카오 로그인
    @objc func loginKakao() {
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext:{ (oauthToken) in
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                }, onError: {error in
                    print(error)
                })
                .disposed(by: disposeBag)
        }
    }
    
}
