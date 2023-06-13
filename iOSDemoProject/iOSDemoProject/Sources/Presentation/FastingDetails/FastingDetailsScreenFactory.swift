//
//  FastingDetailsScreenFactory.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 13.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit
import BMAbstractions

struct FastingDetailsScreenFactory {
    private let store: Store<State>
    
    init(store: Store<State> = StoreLocator.shared) {
        self.store = store
    }
    
    func `default`() -> FastingDetailsViewController {
        let controller = FastingDetailsViewController()
        var cancelObserving: Command?
        let presenter = FastingDetailsPresenter(
            render: CommandWith { [weak controller] props in
                controller?.render(props: props)
            }.dispatchedOnMain(),
            dispatch: CommandWith { [weak store] action in
                store?.dispatch(action: action)
            },
            endObserving: Command(id: "endObserving") { cancelObserving?.perform() }
        )

        controller.addWillAppearObserver { [weak store] in
            if cancelObserving == nil {
                cancelObserving = store?.observe(with: CommandWith(action: presenter.present))
            }
        }
        
        controller.addDidDisappearObserver {
            cancelObserving?.perform()
            cancelObserving = nil
        }

        return controller
    }
}
