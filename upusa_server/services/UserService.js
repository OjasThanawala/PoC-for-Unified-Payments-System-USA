const fetch = require('node-fetch');
const axios = require('axios');
module.exports = function (app) {

	let userDao = require("../data_access_objects/UserDAO");

	/*checks if the user is present inside the database.*/
	function checkUserPresence(req, res) {
		userDao.checkUserPresence(req.body)
			.then(response => {
				return res.json(response);
			});
	}

	/*Enters the new information about the user inside the database.*/
	function registerUserFirstStage(req, res) {
		userDao.registerUserFirstStage(req.body)
			.then(response => {
				//console.log("response: ", response);
				return res.json(response);
			})
	}

	/*Retrieves the outstanding bills for a particular user.*/
	function getUserCurrentBills(req, res) {
		userDao.getUserCurrentBills(req.params["userName"]).then(response => {
			//console.log("response: ", response);
			return res.json(response);
		})
	}

	/*Retrieves a bill history of a user.*/
	function getUserBillHistory(req, res) {
		userDao.getUserBillHistory(req.params["userName"]).then(response => {
			//console.log("response: ", response);
			return res.json(response);
		})
	}

	/*Retrieves bank accounts associated with a particular user.*/
	function getUserBankAccountInformation(req, res) {
		userDao.getUserBankAccountInformation(req.params["userName"]).then(response => {
			//console.log(" response: ", response);
			return res.json(response);
		})
	}

	/*performs transaction on behalf of a user to pay the bill amount.*/
	function payBill(req, res) {
		axios.post("http://localhost:8081/api/bank/transaction/debit", req.body).then(response => {
			if (response.data["finalMessage"] === "Transaction Successful") {
				axios.post("http://localhost:8080/api/bill-deactivate", {
					billId: req.body["billId"]
				}).then(response => {/*console.log("res[ponse: ", response.data)*/; res.json(response.data)});
			} else {
				return res.json(response.data)
			}
		});

	}

	/*Retreives a bill data based on bill id.*/
	function getBillData(req, res) {
		userDao.getBillData(req.params["billId"]).then(response => {
			return res.json(response);
		})
	}

	/*Insert a new bill into the database.*/
	function insertBill(req, res) {
		userDao.insertBill(req.body).then(response => {
			return res.json(response);
		})
	}

	/*Change the status of the outstanding bill to 'bill paid'.*/
	function removeCurrentBill(req, res) {
		userDao.removeCurrentBill(req.body).then(response => {
			//console.log("response remove current bill: ", response)
			return res.json(response[0]);
		})
	}

	app.post("/api/checkUser", checkUserPresence);
	app.post("/api/registerUserInitial", registerUserFirstStage);
	app.get("/api/get-user-current-bills/:userName", getUserCurrentBills);
	app.get("/api/get-user-bill-history/:userName", getUserBillHistory);
	app.get("/api/get/user-bank-account-information/:userName", getUserBankAccountInformation);
	app.get("/api/get-bill-data/:billId", getBillData);
	app.post("/api/pay-bill", payBill);
	app.post("/api/insert-bill", insertBill);
	app.post("/api/bill-deactivate", removeCurrentBill);
};
