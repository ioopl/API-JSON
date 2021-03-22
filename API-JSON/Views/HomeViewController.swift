import UIKit

class HomeViewController: UITableViewController {

    var modelListViewModel = MatchListViewModel()
    var matchesData = [Match]()
    
    var inputDictionaryTable: [String:Int] = [:]

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
        modelListViewModel.fetchLatestMatches(competitionId: competition.id)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(inputDictionaryTable)
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
            var numberOfWins = 0
            numberOfWins = inputDictionaryTable[matchesData[indexPath.row].homeTeam.name] ?? 0
            inputDictionaryTable[matchesData[indexPath.row].homeTeam.name] = numberOfWins
            
        } else if (matchesData[indexPath.row].score.isAwayWinner) {
            winningTeam = matchesData[indexPath.row].awayTeam.name
            
            let numberOfWins = inputDictionaryTable[matchesData[indexPath.row].awayTeam.name]
            inputDictionaryTable[matchesData[indexPath.row].awayTeam.name] = numberOfWins ?? 0 + 1
        } else {
            winningTeam = "None"
        }
        
        cell.detailTextLabel?.text = " Winning Team = " + winningTeam
        
        for (key, value) in inputDictionaryTable {
            print("key :", key)
            print("value :", value)
        }
        return cell
    }
}


extension HomeViewController: MatchListViewModelDelegate {
    func callbackWhenDataAvailable(matches: [Match]) {
        matchesData = matches
        tableView.reloadData()
        tableView.hideActivityIndicator()
    }
}
