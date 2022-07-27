//
//  NycHeighSchoolInfoVC.swift
//  PhotonTest
//
//  Created by Navyasree Janjirala on 7/26/22.
//

import UIKit

class NycHeighSchoolInfoVC: UIViewController {
    
    @IBOutlet var scoreTable: UITableView!
    
    @IBOutlet var schoolame_Lbl: UILabel!
    @IBOutlet var email_Lbl: UILabel!
    @IBOutlet var phone_Lbl: UILabel!
    @IBOutlet var website_Lbl: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var dataViewModel = NYCSchoolScoreViewModel()
    var schoolDetails : SchoolDetails?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolame_Lbl.text = schoolDetails?.schoolName
        email_Lbl.text = schoolDetails?.email
        phone_Lbl.text = schoolDetails?.phone
        website_Lbl.text = schoolDetails?.website
        
        initViewModel()
    }
    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.scoreTable.reloadData() }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async { self.showAlert("Ups, something went wrong.") }
        }
        dataViewModel.showLoading = {
            DispatchQueue.main.async { self.activityIndicator.startAnimating() }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
        }
        dataViewModel.getScoreDetails()
    }
    
}

extension NycHeighSchoolInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NYVHeighSchoolSchoreCell", for: indexPath) as? NycHeighSchoolSchoreCell else {
            fatalError("Cell not exists in storyboard")
        }
        let cellVM = dataViewModel.getCellViewModel( at: indexPath )
        cell.bdn_lbl.text = cellVM.dbn
        cell.schoolName_lbl.text = cellVM.schoolName
        cell.testTaker_lbl.text = cellVM.testTaker
        cell.mathScore_lbl.text = cellVM.mathScore
        cell.readingScore_lbl.text = cellVM.readingScore
        cell.writingScore_lbl.text = cellVM.writingScore
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0;//Choose your custom row height
    }
    
}


