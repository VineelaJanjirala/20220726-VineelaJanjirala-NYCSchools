//
//  NycHeighSchoolsListVCViewController.swift
//  PhotonTest
//
//  Created by Navyasree Janjirala on 7/26/22.
//

import UIKit

class NycHeighSchoolsListVC: UIViewController {
    
    @IBOutlet var schoolListTable: UITableView!
    var dataViewModel = NYCSchoolListViewModel()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "School Names"
        initViewModel()
    }
    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.schoolListTable.reloadData() }
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
        dataViewModel.getschoolDetails()
    }
   
}

extension NycHeighSchoolsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NYCHeighSchoolCell", for: indexPath) as? NycHeighSchoolCell else {
            fatalError("Cell not exists in storyboard")
        }
        let cellVM = dataViewModel.getCellViewModel( at: indexPath )
        cell.schoolName.text = cellVM.schoolName
        return cell
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schoolInfoVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NycHeighSchoolInfoVC") as! NycHeighSchoolInfoVC
        schoolInfoVc.schoolDetails = dataViewModel.schoolDetails[indexPath.row]
        self.navigationController?.pushViewController(schoolInfoVc, animated: true)
    }
}


