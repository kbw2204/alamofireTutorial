//
//  ViewController.swift
//  alamofireTest
//
//  Created by 융융 on 2021/01/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰가 로드되면 실행되겠죠??
        NetworkService.shared.requestSearchBook("Swift", 1) { result in
            // 요 작업이 완료되면, 아까 그 complete에 넘겨줬던게 result로 가는거에요
            switch result {
            case .success(let books):
                if let book = books.first {
                    // 요렇게 메인일 때 적용하도록 넘겨주는게 안전..
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        
                        self.label.text = book.title
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
