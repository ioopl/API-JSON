import UIKit


class SecondViewController: UITableViewController {
    
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
        // ASYNC Call
        modelListViewModel.fetchUpcomingMatches(competitionId: competition.id)
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
        
        
        cell.textLabel?.text = matchesData[indexPath.row].homeTeam.name + " vs " + matchesData[indexPath.row].awayTeam.name
        cell.detailTextLabel?.text = matchesData[indexPath.row].score.winner
        return cell
    }
}


extension SecondViewController: MatchListViewModelDelegate {
    func callbackWhenDataAvailable(matches: [Match]) {
        matchesData = matches
        tableView.reloadData()
        tableView.hideActivityIndicator()
    }
}
