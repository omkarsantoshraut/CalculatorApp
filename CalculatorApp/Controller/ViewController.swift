//MARK: imports

import UIKit

//MARK: ViewController

class ViewController: UIViewController {

    // ViewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        let customView = CalculatorView(frame: CGRect.zero)
        customView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(customView)

        // constaints of the above view in viewcontroller's view.
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            customView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        //initialize model and set delegates.
        let model = Model()
        customView.delegate = model.self
        model.delegate = customView
    }
}
