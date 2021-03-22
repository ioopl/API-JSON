import XCTest
@testable import API_JSON

class API_JSONTests: XCTestCase, MatchListViewModelDelegate {

    var data: [Match]? = []

    // Gets called by the View Model
    func callbackWhenDataAvailable(matches: [Match]) {
        // Gets returned by the Web Service
        self.data = matches
    }
    

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
                

        // Fake Web Service Call given to ViewModel
        viewModel.service = dataService
                
        viewModel.delegate = self
        
        viewModel.asyncFetchLatestMatches(competitionId: competition.id)
                
        XCTAssertEqual(data?.first, dataService.expectedMatch)
    }


    override func tearDownWithError() throws {
        homeViewController = nil
        secondViewController = nil
        data = nil
    }
}
