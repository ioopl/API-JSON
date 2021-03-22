import XCTest
@testable import API_JSON

class API_JSONTests: XCTestCase {

    var homeViewController: HomeViewController!
    var secondViewController: SecondViewController!
    var dataService: FakeDataService!
    
    override func setUpWithError() throws {
        dataService = FakeDataService()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            homeViewController = storyBoard.instantiateViewController(identifier: "HomeViewController")
            homeViewController.loadViewIfNeeded()
            
            secondViewController = storyBoard.instantiateViewController(identifier: "SecondViewController")
            secondViewController.loadViewIfNeeded()
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    func testHomeViewControllerHasRootView() {
        XCTAssertNotNil(homeViewController.view)
    }
    
    func testHomeViewControllerHasChildView() {
        XCTAssertNotNil(homeViewController.tableView)
    }

    func testSecondViewControllerHasChildView() {
        XCTAssertNotNil(secondViewController.tableView)
    }
    
    func testHomeTableViewItemUpdatesText() {
        let viewModel = MatchListViewModel()
        
        let competition = Competition.defaultCompetitions[0]
        viewModel.fetchLatestMatches(competitionId: competition.id)
        dataService.fetchLatestMatches(competitionId: 1) { (response) in
            _ = response.map { (match)  in
                XCTAssertEqual(match[0].homeTeam.id, 1)
                XCTAssertEqual(match[0].awayTeam.id, 2)
            }
        }
    }

    override func tearDownWithError() throws {
        homeViewController = nil
        secondViewController = nil
    }
}
