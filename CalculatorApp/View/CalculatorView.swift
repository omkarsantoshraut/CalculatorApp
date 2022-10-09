// MARK: Imports

import UIKit

// MARK: Protocol (calculatorBackendProtocol)

/**
 calculatorBackendProtocol that helps to call methods from Model class that will handle extire data in backend.
 This behaviour will help to implement the MVC model of calculator application.
 */
protocol calculatorBackendProtocol {
    func btnZeroClicked()
    func btnOneClicked()
    func btnTwoClicked()
    func btnThreeClicked()
    func btnFourClicked()
    func btnFiveClicked()
    func btnSixClicked()
    func btnSevenClicked()
    func btnEightClicked()
    func btnNineClicked()
    func btnPlusClicked()
    func btnMinusClicked()
    func btnMultiplyClicked()
    func btnDivideClicked()
    func btnDotClicked()
    func btnEqualToClicked()
    func btnPercentageClicked()
    func btnDELClicked()
    func btnACClicked()
}

//MARK: View

class CalculatorView: UIView {

    /**
     The delegate of calculatorBackendProtocol which helps to call methods of Model class from this class.
     */
    var delegate: calculatorBackendProtocol?
    
    /**
     row1: to show the actual calculation on the screen
     */
    let row1 = UILabel()

    /**
     Init methods for the initialization of the view.
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    /**
     method that will set the view of calculator.
     */
    func setView() {
        self.backgroundColor = .black

        // Verticle stackview that will store entire view of calculator.
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 1.0
        addSubview(stackView)

        // Constraints for the vericle stackview.
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor)
        ])

        /**
         First row that wil show the expression on the screen.
         */
        row1.text = "0"
        row1.textAlignment = .right
        row1.textColor = .white
        row1.font = UIFont.systemFont(ofSize: 30)
        stackView.addArrangedSubview(row1)

        /**
         Second row that contains %, DEL, AC, ÷ buttons of the calculator.
         */
        let row2 = UIStackView()
        addHorizontalStackViewConstraints(stackView: row2)

        for button in [createButton(backgroundColor: .gray, text: "%"), createButton(backgroundColor: .gray, text: "DEL"), createButton(backgroundColor: .gray, text: "AC"), createButton(backgroundColor: .orange, text: "÷")] {
            row2.addArrangedSubview(button)
        }
        stackView.addArrangedSubview(row2)

        /**
         Third row that contains 7, 8, 9, x buttons of the calculator.
         */
        let row3 = UIStackView()
        addHorizontalStackViewConstraints(stackView: row3)

        for button in [createButton(backgroundColor: .systemBlue, text: "7"), createButton(backgroundColor: .systemBlue, text: "8"), createButton(backgroundColor: .systemBlue, text: "9"), createButton(backgroundColor: .orange, text: "x")] {
            row3.addArrangedSubview(button)
        }
        stackView.addArrangedSubview(row3)

        /**
         Fourth row that contains 4, 5, 6, - buttons of the calculator.
         */
        let row4 = UIStackView()
        addHorizontalStackViewConstraints(stackView: row4)

        for button in [createButton(backgroundColor: .systemBlue, text: "4"), createButton(backgroundColor: .systemBlue, text: "5"), createButton(backgroundColor: .systemBlue, text: "6"), createButton(backgroundColor: .orange, text: "-")] {
            row4.addArrangedSubview(button)
        }
        stackView.addArrangedSubview(row4)

        /**
         Fifth row that contains 1, 2, 3, + buttons of the calculator.
         */
        let row5 = UIStackView()
        addHorizontalStackViewConstraints(stackView: row5)

        for button in [createButton(backgroundColor: .systemBlue, text: "1"), createButton(backgroundColor: .systemBlue, text: "2"), createButton(backgroundColor: .systemBlue, text: "3"), createButton(backgroundColor: .orange, text: "+")] {
            row5.addArrangedSubview(button)
        }
        stackView.addArrangedSubview(row5)

        /**
         Sixth row that contains 0, ., = buttons of the calculator.
         */
        let row6 = UIStackView()
        row6.distribution = .fillProportionally
        row6.axis = .horizontal
        row6.translatesAutoresizingMaskIntoConstraints = false
        row6.spacing = 1.0

        let btnZero = createButton(backgroundColor: .systemBlue, text: "0")
        let btnDot = createButton(backgroundColor: .systemBlue, text: ".")
        let btnEqualTo = createButton(backgroundColor: .orange, text: "=")

        for button in [btnZero, btnDot, btnEqualTo] {
            row6.addArrangedSubview(button)
        }

        // special constraints for the sixth row.
        NSLayoutConstraint.activate([
            btnZero.widthAnchor.constraint(equalTo: row6.widthAnchor, multiplier: 0.5),
            btnDot.widthAnchor.constraint(equalTo: row6.widthAnchor, multiplier: 0.25),
            btnEqualTo.widthAnchor.constraint(equalTo: row6.widthAnchor, multiplier: 0.25),
        ])
        stackView.addArrangedSubview(row6)
    }

    //MARK: Private helper methods.
    /**
     Function that helps to set constraints of the horizontal stackview.
     */
    private func addHorizontalStackViewConstraints(stackView: UIStackView) {
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 1.0
    }

    /**
     Function that will create buttons along its target.
     */
    private func createButton(backgroundColor: UIColor, text: String) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        switch(text) {
        case "0":
            button.addTarget(self, action: #selector(btnZeroClicked), for: .touchUpInside)
        case "1":
            button.addTarget(self, action: #selector(btnOneClicked), for: .touchUpInside)
        case "2":
            button.addTarget(self, action: #selector(btnTwoClicked), for: .touchUpInside)
        case "3":
            button.addTarget(self, action: #selector(btnThreeClicked), for: .touchUpInside)
        case "4":
            button.addTarget(self, action: #selector(btnFourClicked), for: .touchUpInside)
        case "5":
            button.addTarget(self, action: #selector(btnFiveClicked), for: .touchUpInside)
        case "6":
            button.addTarget(self, action: #selector(btnSixClicked), for: .touchUpInside)
        case "7":
            button.addTarget(self, action: #selector(btnSevenClicked), for: .touchUpInside)
        case "8":
            button.addTarget(self, action: #selector(btnEightClicked), for: .touchUpInside)
        case "9":
            button.addTarget(self, action: #selector(btnNineClicked), for: .touchUpInside)
        case ".":
            button.addTarget(self, action: #selector(btnDotClicked), for: .touchUpInside)
        case "+":
            button.addTarget(self, action: #selector(btnPlusClicked), for: .touchUpInside)
        case "-":
            button.addTarget(self, action: #selector(btnMinusClicked), for: .touchUpInside)
        case "x":
            button.addTarget(self, action: #selector(btnMultiClicked), for: .touchUpInside)
        case "÷":
            button.addTarget(self, action: #selector(btnDivideClicked), for: .touchUpInside)
        case "AC":
            button.addTarget(self, action: #selector(btnACClicked), for: .touchUpInside)
        case "DEL":
            button.addTarget(self, action: #selector(btnDELClicked), for: .touchUpInside)
        case "%":
            button.addTarget(self, action: #selector(btnPercentageClicked), for: .touchUpInside)
        case "=":
            button.addTarget(self, action: #selector(btnEqualToClicked), for: .touchUpInside)
        default:
            assertionFailure("This case should not call...")
        }
        return button
    }
    
    @objc func btnZeroClicked() {
        delegate?.btnZeroClicked()
    }
    @objc func btnOneClicked() {
        delegate?.btnOneClicked()
    }
    @objc func btnTwoClicked() {
        delegate?.btnTwoClicked()
    }
    @objc func btnThreeClicked() {
        delegate?.btnThreeClicked()
    }
    @objc func btnFourClicked() {
        delegate?.btnFourClicked()
    }
    @objc func btnFiveClicked() {
        delegate?.btnFiveClicked()
    }
    @objc func btnSixClicked() {
        delegate?.btnSixClicked()
    }
    @objc func btnSevenClicked() {
        delegate?.btnSevenClicked()
    }
    @objc func btnEightClicked() {
        delegate?.btnEightClicked()
    }
    @objc func btnNineClicked() {
        delegate?.btnNineClicked()
    }
    @objc func btnACClicked() {
        delegate?.btnACClicked()
    }
    @objc func btnDELClicked() {
        delegate?.btnDELClicked()
    }
    @objc func btnPercentageClicked() {
        delegate?.btnPercentageClicked()
    }
    @objc func btnDotClicked() {
        delegate?.btnDotClicked()
    }
    @objc func btnPlusClicked() {
        delegate?.btnPlusClicked()
    }
    @objc func btnMinusClicked() {
        delegate?.btnMinusClicked()
    }
    @objc func btnMultiClicked() {
        delegate?.btnMultiplyClicked()
    }
    @objc func btnDivideClicked() {
        delegate?.btnDivideClicked()
    }
    @objc func btnEqualToClicked() {
        delegate?.btnEqualToClicked()
    }
}

//MARK: Extension

/**
 Extension that will implement the protocol method.
 */
extension CalculatorView: calculatorProtocol {

    // Method that will show updated text (expression) on the screen.
    func showUpdatedTextOnScreen(textOnLabel: String) {
        self.row1.text = textOnLabel
    }
}
