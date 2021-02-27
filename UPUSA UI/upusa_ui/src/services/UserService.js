/*Connects to the server running the UPUSA application and thereby performs relevant transactions.*/
export default class UserService {

	static oneInstance = null;

	static getInstance() {
		if (UserService.oneInstance === null) {
			UserService.oneInstance = new UserService();
		}

		return this.oneInstance;
	};

	//find whether a user is registered with UPUSA.
	checkUserPresence = (userName, Password) => {
		let bodyTemp = {
			username: userName,
			password: Password,
		};
		return fetch("http://localhost:8080/api/checkUser", {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(bodyTemp)
		}).then(response => response.json());
	};

	//Enter new user information in UPUSA database.
	registerUser = (userName, Password, email, contact, fullName, ssn, address1, address2, city, state) => {
		let bodyTemp = {
			username: userName,
			password: Password,
			email: email,
			contact: contact,
			fullname: fullName,
			ssn: ssn,
			address1: address1,
			address2: address2,
			city: city,
			state: state
		};

		console.log("bodyTemp: ", bodyTemp);
		return fetch("http://localhost:8080/api/registerUserInitial", {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(bodyTemp)
		}).then(response => response.json());
	};

	//retrieve outstanding bills of a particular user.
	liveBills = (userName) => {
		console.log("username received: ", userName);
		return fetch("http://localhost:8080/api/get-user-current-bills/" + userName)
			.then(response =>
				response.json());
	};

	/*Retrieves bill history of a user.*/
	billHistory = (userName) => {
		return fetch("http://localhost:8080/api/get-user-bill-history/" + userName)
			.then(response =>
				response.json());
	};

	//retrieve bank account associated with a particular user.
	getBankAccountInfo = (userName) => {
		return fetch("http://localhost:8080/api/get/user-bank-account-information/" + userName)
			.then(response =>
				response.json());
	};

	// retrieve a bill data based on bill id.
	getBillData = (billId) => {
		return fetch("http://localhost:8080/api/get-bill-data/"+billId).then(response => response.json());
	};

	//change bill status to bill paid and remove from current bill section.
	payBill = (account_number, billAmount, billId) => {
		return fetch("http://localhost:8080/api/pay-bill",{
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				account_number: account_number,
				bill_amount: billAmount,
				billId: billId
			})
		}).then(response => response.json());
	}
}
