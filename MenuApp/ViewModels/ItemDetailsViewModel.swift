//
//  ItemDetailsViewModel.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import RxSwift

class ItemDetailsViewModel: BaseViewModel, ViewModelType {
    struct Input {
        let item: AnyObserver<Item>
    }
    
    struct Output {
        let faliure: Observable<[ErrorModel]>
    }
    
    var input: ItemDetailsViewModel.Input
    var output: ItemDetailsViewModel.Output
    
    private let item = PublishSubject<Item>()
    private let faliure = PublishSubject<[ErrorModel]>()
    
    
    override init() {
        input = Input(item: item.asObserver())
        output = Output(faliure: faliure.asObservable())
        super.init()
    }
}
