/*Connects to the server running the biller application and thereby performs relevant transactions.*/
export default class BillerService {


	static oneInstance = null;

	static getInstance() {
		if(BillerService.oneInstance === null) {
			BillerService.oneInstance = new BillerService();
		}
		return BillerService.oneInstance;
	}

	/*Enter a new bill for a user.*/
	generateBill = (account_number, bill_amount, service_id) => {

		let body = {
			account_number: account_number,
			bill_amount: bill_amount,
			due_dt: new Date(),
			service_id: service_id,
			payment_delay: true
		}

		return fetch("http://localhost:8079/bills/newBill", {
			method: 'POST',
			headers: {
				'Contemt-Type':'application/json'
			},
			body: JSON.stringify(body)
		}).then(response => response.json());

	}
}
