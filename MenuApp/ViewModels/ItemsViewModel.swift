//
//  ItemsViewModel.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class ItemsViewModel: BaseViewModel, ViewModelType {
    
    struct Input {}
    struct Output {
        let items: Observable<[Item]>
        let faliure: Observable<[ErrorModel]>
    }
    
    var input: ItemsViewModel.Input
    var output: ItemsViewModel.Output
    
    private let items = PublishSubject<[Item]>()
    private let faliure = PublishSubject<[ErrorModel]>()
    
    var itemsArray: [Item] = []
    
    override init() {
        input = Input()
        output = Output(items: items.asObservable(),
                        faliure: faliure.asObservable())
        super.init()
    }
    
    func getItems(byTag tag: String){
        guard ReachabilityUtility.shared.isReachable else {
            let resEnum = ResponseHandler.instance.getDataFormDB(key: tag, model: ItemResponse.self)
            pushData(resEnum: resEnum)
            items.onCompleted()
            return
        }
        requestItems(by: tag)
    }
    
    private func requestItems(by tagName: String) {
        MHProgress.sharedMHP.show()
        Alamofire.request(MenuRouter.items(tagName)).responseJSON { [unowned self] (response) in
            MHProgress.sharedMHP.hide()
            let resEnum = ResponseHandler.instance.handleResponse(response, model: ItemResponse.self)
            self.pushData(resEnum: resEnum)
            self.saveItems(self.itemsArray, in: tagName)
        }
    }
    
    private func pushData(resEnum: ResponseEnum) {
        switch resEnum {
        case .success(let value):
            guard let itemResponse = value as? ItemResponse, let items = itemResponse.items else { return }
            self.items.onNext(items)
            self.itemsArray.append(contentsOf: items)
        case .failure(_, let data):
            self.handelError(data: data, failer: self.faliure)
        }
    }
    
    private func saveItems(_ items: [Item], in key: String){
        do{
            let itemResponse = ItemResponse(items: items)
            try StorageManager.shared.saveData(value: itemResponse, for: key)
        } catch let error {
            self.handelError(data: error, failer: self.faliure)
        }
    }

}
