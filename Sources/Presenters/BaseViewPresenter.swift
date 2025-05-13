import UIKit

public protocol BaseViewPresenterProtocol: AnyObject {
    var view: BaseViewProtocol? { get set }
    var coordinator: CoordinatorProtocol? { get set }
}

open class BaseViewPresenter: NSObject, BaseViewPresenterProtocol {
    open weak var view: BaseViewProtocol?
    public var coordinator: CoordinatorProtocol?
}
