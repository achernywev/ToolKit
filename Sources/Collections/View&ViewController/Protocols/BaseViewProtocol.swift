import Foundation

public protocol BaseViewProtocol: AnyObject {
    var okString: String? { get }
    var cancelString: String? { get }
    
    func updateTitle(_ title: String?)
    
    func showAlert(title: String?, message: String?, acceptAction: UIAlertAction, cancelAction: UIAlertAction?)
    
    func beginLoading(showActivity: Bool)
    func endLoading()
}

public extension BaseViewProtocol {
    func showError(_ error: String?) {
        show(title: nil, message: error, handler: nil)
    }
    
    func show(title: String? = nil, message: String? = nil, handler: (() -> Void)? = nil) {
        show(title: title, message: message, action: defaultAccept(handler: handler))
    }
    
    func show(title: String? = nil, message: String? = nil, action: UIAlertAction) {
        showAlert(title: title, message: message, acceptAction: action, cancelAction: nil)
    }
    
    func showDialog(title: String? = nil, message: String? = nil, acceptHandler: @escaping () -> Void, cancelHandler: (() -> Void)? = nil) {
        showDialog(title: title, message: message, action: defaultAccept(handler: acceptHandler), cancelHandler: cancelHandler)
    }
    
    func showDialog(title: String? = nil, message: String? = nil, action: UIAlertAction, cancelHandler: (() -> Void)? = nil) {
        showAlert(title: title, message: message, acceptAction: action, cancelAction: defaultCancel(handler: cancelHandler))
    }
    
    private func defaultAccept(handler: (() -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: okString, style: .default, handler: { _ in handler?() })
    }
    
    private func defaultCancel(handler: (() -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: cancelString, style: .cancel, handler: { _ in handler?() })
    }
}
