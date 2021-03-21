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
    
    
    func testHomeTableViewItemUpdatesTextLabel() {
        let viewModel = MatchListViewModel()
        
        let competition = Competition.defaultCompetitions[0]
        viewModel.fetchLatestMatches(competitionId: competition.id)
        dataService.fetchLatestMatches(competitionId: 1) { (response) in
            print(response)
            // what to test here
        }

        
        
//        let photo = Photo(id: "1", title: "photo", thumbnailUrl: "", fullSizeUrl: "")
//        detailViewController.detailItem = photo
//        XCTAssertEqual(detailViewController.detailDescriptionLabel.text, detailViewController.detailItem?.title)

    }
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
