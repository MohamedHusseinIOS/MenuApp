//
//  HomeViewModel.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class HomeViewModel: BaseViewModel, ViewModelType {
    
    struct Input {}
    struct Output {
        let tags: Observable<[Tag]>
        let faliure: Observable<[ErrorModel]>
    }
    
    var input: HomeViewModel.Input
    var output: HomeViewModel.Output
    
    private let tags = PublishSubject<[Tag]>()
    private let faliure = PublishSubject<[ErrorModel]>()
    
    var tagsArray = [Tag]()
    
    override init() {
        
        input = Input()
        output = Output(tags: tags.asObservable(),
                        faliure: faliure.asObservable())
        super.init()
        
    }
    
    func getTags(byPage page: Int) {
        guard ReachabilityUtility.shared.isReachable else {
            let resEnum = ResponseHandler.instance.getDataFormDB(key: StorageKeys.tags.rawValue, model: TagsResponse.self)
            pushData(resEnum: resEnum)
            tags.onCompleted()
            return
        }
        requestTags(by: page)
    }
    
    private func requestTags(by page: Int) {
        MHProgress.sharedMHP.show()
        Alamofire.request(MenuRouter.tags(page)).responseJSON { [unowned self] (response) in
            MHProgress.sharedMHP.hide()
            response.interceptResuest("\(MenuRouter.tags(page).requestURL)", MenuRouter.tags(page).parameters)
            let resEnum = ResponseHandler.instance.handleResponse(response, model: TagsResponse.self)
            self.pushData(resEnum: resEnum)
        }
    }
    
    private func pushData(resEnum: ResponseEnum) {
        switch resEnum {
        case .success(let value):
            guard let tagResponse = value as? TagsResponse, let tags = tagResponse.tags else { return }
            self.tagsArray.append(contentsOf: tags)
            saveTags(self.tagsArray)
            self.tags.onNext(self.tagsArray)
        case .failure(_, let data):
            self.handelError(data: data, failer: self.faliure)
        }
    }
    
    private func saveTags(_ tags: [Tag]){
        do{
            let tagResponse = TagsResponse(tags: tags)
            try StorageManager.shared.saveData(value: tagResponse, for: StorageKeys.tags.rawValue)
        } catch let error {
            self.handelError(data: error, failer: self.faliure)
        }
    }
    
}
