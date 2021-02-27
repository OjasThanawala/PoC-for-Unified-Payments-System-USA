module.exports = function (app) {

	let bankDao = require('../data_access_objects/BankDAO');

	/*Function exposed to the api that handles the bank transaction to be done from the customer's side.*/
	function performTransaction(req, res) {
		let body = req.body;
		return bankDao.performTransaction(body['account_number'], body["bill_amount"])
			.then(response => {
				let resultTemp = {
					finalMessage: response[0]["finalMessage"]
				};
				console.log("bank service result: ", resultTemp);
				res.json(resultTemp);
			});
	}

	app.post("/api/bank/transaction/debit", performTransaction)
};
