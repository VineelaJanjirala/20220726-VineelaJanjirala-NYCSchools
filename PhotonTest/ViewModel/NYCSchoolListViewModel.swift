//
//  NYCSchoolListViewModel.swift
//  PhotonTest
//
//  Created by Navyasree Janjirala on 7/26/22.
//

import UIKit

typealias NYCSchoolListModel = [[String: String]]

class NYCSchoolListViewModel {
    
    var schoolDetails: [SchoolDetails] = [SchoolDetails]()
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    private var cellViewModels: [SchoolListCellViewModel] = [SchoolListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    func getschoolDetails() {
        showLoading?()
        let urlString = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        
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
            let decodedData = try JSONDecoder().decode(NYCSchoolListModel.self,
                                                       from: jsonData)
            for data in decodedData {
                self.schoolDetails.append(SchoolDetails(data["school_name"] ?? "", data["dbn"] ?? "", data["phone_number"] ?? "", data["school_email"] ?? "", data["website"] ?? ""))
            }
            self.createCell(datas: self.schoolDetails)
        } catch {
            print("decode error")
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> SchoolListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(datas: [SchoolDetails]){
        self.schoolDetails = datas
        var vms = [SchoolListCellViewModel]()
        for data in datas {
            vms.append(SchoolListCellViewModel(schoolName: data.schoolName))
        }
        cellViewModels = vms
    }
}

struct SchoolListCellViewModel {
    let schoolName: String
}

