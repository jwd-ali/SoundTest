import XCTest
@testable import iOSRefactoringChallenge
class PlayListModuleFactoryTests: XCTestCase {
    private var view: UIViewController?
    private weak var viewModel: PlayListViewModel?
    
    override func setUpWithError() throws {
        let factoryBuilder = PlayListModuleFactory()
                            .makeAndExpose()
        view = factoryBuilder.view
        viewModel = factoryBuilder.viewModel as? PlayListViewModel
    }
    
    func test_module_doesNotLeakMemory() {
            XCTAssertNotNil(viewModel)
            view = nil
            XCTAssertNil(viewModel)
        }

    override func tearDownWithError() throws {
        view = nil
        viewModel = nil
        try super.tearDownWithError()
    }

}
