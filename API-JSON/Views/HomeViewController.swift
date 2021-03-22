import UIKit

class HomeViewController: UITableViewController {

    var modelListViewModel = MatchListViewModel()
    var matchesData = [Match]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // hide empty tableview cells
        tableView.tableFooterView = UIView()
        tableView.showActivityIndicator()

        tableView.delegate = self
        tableView.dataSource = self
        
        modelListViewModel = MatchListViewModel()
        modelListViewModel.delegate = self
        let competition = Competition.defaultCompetitions[0]
        modelListViewModel.asyncFetchLatestMatches(competitionId: competition.id)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text =
            matchesData[indexPath.row].homeTeam.name
            + " vs "
            + matchesData[indexPath.row].awayTeam.name
        
        var winningTeam = ""
        if (matchesData[indexPath.row].score.isHomeWinner) {
            winningTeam = matchesData[indexPath.row].homeTeam.name
        } else if (matchesData[indexPath.row].score.isAwayWinner) {
            winningTeam = matchesData[indexPath.row].awayTeam.name
        } else {
            winningTeam = "None"
        }
        
        cell.detailTextLabel?.text = " Winning Team = " + winningTeam
                
        return cell
    }
}


extension HomeViewController: MatchListViewModelDelegate {
    func callbackWhenDataAvailable(matches: [Match]) {
        DispatchQueue.main.async {
            self.matchesData = matches
            if matches.count <= 0 {
                self.handleNoData()
            }
            self.tableView.reloadData()
            self.tableView.hideActivityIndicator()
        }
    }
}

extension HomeViewController {
    private func handleNoData() {
        let ac = UIAlertController(title: "No Match",
                                   message: "Nothing in Next few days",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(ac, animated: true)
    }
}
