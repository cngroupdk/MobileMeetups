import Foundation
import SharedKit

class BaseViewModelWrapper<VM: BaseViewModel>: ObservableObject {
    let viewModel: VM

    required init(parameters: [AnyObject]?) {
        let expectedViewModel: VM?
        if Koin.instance.isRunning {
            expectedViewModel = Koin.instance.get(parameters: parameters)
        } else {
            expectedViewModel = parameters?.first as? VM
        }
        guard let vm = expectedViewModel else {
            fatalError("Cannot construct the ViewModel")
        }
        self.viewModel = vm
        debugPrint("💡 init ViewModelWrapper [\(String(describing: self))]")
    }

    deinit {
        viewModel.cancelScope()
        debugPrint("♻️ deinit ViewModelWrapper [\(String(describing: self))]")
    }

}

#if DEBUG
    extension BaseViewModelWrapper {
        static func preview(vm: VM) -> Self {
            Self.init(parameters: [vm])
        }
    }
#endif
