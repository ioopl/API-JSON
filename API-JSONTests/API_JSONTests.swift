import XCTest
@testable import API_JSON

class API_JSONTests: XCTestCase, MatchListViewModelDelegate {

    var matchData: [Match]? = []

    // Gets called by the View Model
    func callbackWhenDataAvailable(matches: [Match]) {
        // Gets returned by the Web Service
        self.matchData = matches
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
            
        // Delegate : A pointer to methods to listen to it's callbacks
        // So this line is super important to become `self` (adhering to the protocol MatchListViewModelDelegate is not enough for this class). It needs to be `self` so that it can listen to the ViewModels Delegate method callback, for the data returned by its method i.e. callbackWhenDataAvailable() <- This is inside asyncFetchLatestMatches() method which returns the Data via callback to this delegate.
        // So basically by doing viewModel.delegate = self we have subscribed to the viewmodel delegate and its callbacks. So below in XCTAssertEqual, this matchData?.first is the matchData which is returned by the ViewModel delegate callback method.
        viewModel.delegate = self
        
        viewModel.asyncFetchLatestMatches(competitionId: competition.id)
                
        XCTAssertEqual(matchData?.first, dataService.expectedMatch)
    }


    override func tearDownWithError() throws {
        homeViewController = nil
        secondViewController = nil
        matchData = nil
    }
}
