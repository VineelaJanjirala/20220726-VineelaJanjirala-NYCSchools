//
//  NYCSchoolScoreViewModel.swift
//  PhotonTest
//
//  Created by Navyasree Janjirala on 7/26/22.
//

import UIKit
class NYCSchoolScoreViewModel {
    
    var schoolDetails: [NycScoreModel] = [NycScoreModel]()
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    private var cellViewModels: [ScoreCellViewModel] = [ScoreCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    func getScoreDetails() {
        showLoading?()
        let urlString = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
        
        ApiClient.loadJson(fromURLString: urlString) { (result) in
            self.hideLoading?()
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
            case .failure(let error):
                print(error)
                self.showError?()
            }
        }
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(NYCScore.self,
                                                       from: jsonData)
            for result in decodedData {
                schoolDetails.append(result)
            }
            self.createCell(datas: self.schoolDetails)

            
        } catch {
            print("decode error")
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> ScoreCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(datas: [NycScoreModel]){
        self.schoolDetails = datas
        var vms = [ScoreCellViewModel]()
        for data in datas {
            vms.append(ScoreCellViewModel(dbn: data.dbn, schoolName: data.schoolName, testTaker: data.numOfSatTestTakers, mathScore: data.satMathAvgScore, readingScore: data.satCriticalReadingAvgScore, writingScore: data.satWritingAvgScore))
        }
        cellViewModels = vms
    }
    
    
}

struct ScoreCellViewModel {
    let dbn: String
    let schoolName: String
    let testTaker: String
    let mathScore: String
    let readingScore: String
    let writingScore: String
}
