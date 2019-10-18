//
//  BaseViewModel.swift
//  pagination-demo
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel {

    var bag = DisposeBag()
    
    init() {}
    
    func handelError(data: Any?, failer: PublishSubject<[ErrorModel]>){
        if let err = data as? ErrorModel{
            failer.onNext([err])
        }else if let errorArr = data as? [ErrorModel]{
            failer.onNext(errorArr)
        }else if let error = data as? Error {
            let error = ErrorModel(message: error.localizedDescription)
            failer.onNext([error])
        }
    }
}
