import DifferenceKit

extension TransactionListTableViewCellState: Differentiable {
	typealias DifferenceIdentifier = String

	var differenceIdentifier: String {
		textLabelText + detailTextLabelText
	}

	func isContentEqual(to source: TransactionListTableViewCellState) -> Bool {
		differenceIdentifier == source.differenceIdentifier
	}
}
