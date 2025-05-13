import UIKit

public protocol ViewControllerDependencyProtocol: AnyObject {
    var okString: String? { get }
    var cancelString: String? { get }
    
    var titleView: UIView? { get }
    var backgroundColor: UIColor? { get }
    
    func hideActivity()
    func configureActivity()
    func showActivity(inView view: UIView)
}

@objc open class ViewController: UIViewController, BaseViewProtocol {
    public var okString: String? { dependency?.okString }
    public var cancelString: String? { dependency?.cancelString }
    
    public let presenter: BaseViewPresenterProtocol
    public weak var dependency: ViewControllerDependencyProtocol?

    //MARK: properties to override
    open var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode { .never }
    open override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    //MARK: initialization
    public init(presenter: BaseViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    @available(*, unavailable, message: "Please use -initWithPresenter: instead")
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.dependency = self as? ViewControllerDependencyProtocol
        
        view.backgroundColor = dependency?.backgroundColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
        dependency?.configureActivity()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
        updateTitle(navigationItem.title)
    }
    
    //MARK: BaseViewProtocol
    public func updateTitle(_ title: String?) {
        navigationItem.title = title
        navigationItem.titleView = {
            if title?.isNotEmpty == true {
                return nil
            } else {
                return dependency?.titleView
            }
        }()
    }
    
    public func showAlert(title: String?, message: String?, acceptAction: UIAlertAction, cancelAction: UIAlertAction?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(acceptAction)
        if let cancelAction {
            alert.addAction(cancelAction)
        }
        self.topViewController().present(alert, animated: true, completion: nil)
    }
    
    public func beginLoading(showActivity: Bool) {
        guard showActivity == true else { return }
        dependency?.showActivity(inView: view)
    }
    
    public func endLoading() {
        dependency?.hideActivity()
    }
}
