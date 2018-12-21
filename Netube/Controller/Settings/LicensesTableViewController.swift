import UIKit

class LicensesTableViewController: UITableViewController {

        override func viewWillAppear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = true
        }
        
        override func viewDidLoad() {
                super.viewDidLoad()
                title = "Open Source"
                self.clearsSelectionOnViewWillAppear = true
        }


        override func numberOfSections(in tableView: UITableView) -> Int {
                return 0
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 0
        }

}
