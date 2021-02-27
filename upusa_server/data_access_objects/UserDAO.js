let mysql = require('mysql');
require('dotenv').config();

//create cursor to connect to the database.
let con = mysql.createConnection({
	host: process.env.DB_HOST,
	user: process.env.DB_USER,
	password: process.env.DB_PASS,
	database: process.env.DB_NAME
});


//check if the user is present inside the database and return messages sent by the database accordingly to the client.
function checkUserPresence(userData) {

	return new Promise((resolve, reject) => {
		let resultFromDB = 0;
		let sql = `CALL check_user(?,?,@result)`;
		let paramSent = [userData["username"], userData["password"]];
		con.query(sql, paramSent, (error, results, fields) => {
			if (error) {
				return reject(error.message);
			}
			sql = `SELECT @result`;
			con.query(sql, paramSent, (error, results, fields) => {
				if (error) {
					return reject(error.message);
				}
				let tempTest = {
					"result": results[0]["@result"]
				};
				return resolve(tempTest);
				con.end();
			});
		});
	})
}

/*Insert a new user into the database.*/
function registerUserFirstStage(userData) {

	//console.log("param sent: ", userData);
	return new Promise((resolve, reject) => {
		let sql = `CALL registerUserInitial(?,?,?,?,?,?,?,?,?,?)`;
		let paramSent = [userData["username"],
			userData["password"],
			userData["email"],
			userData["contact"],
			userData["ssn"],
			userData["fullname"],
			userData["address1"],
			userData["address2"],
			userData["city"],
			userData["state"],
		];

		/*call registerUserInitial('ashukla95',123,'ashukla95@gmail.com',7709747097,987654321,'Ars',"test","test2","boston",'ma');*/
		con.query(sql, paramSent, (error, result, field) => {
			if (error) {
				return reject(error.message);
			}
			let tempTest = {
				"message": result[0][0].finalMessage
			};
			return resolve(tempTest);
			con.end();
		});
	});
}

/*Retrieve the outstanding bills of the user from the database.*/
function getUserCurrentBills(username) {
	return new Promise((resolve, reject) => {

		let sql = `CALL get_user_current_bills(?)`;
		con.query(sql, username, (error, result, field) => {
			if (error) {
				return reject(error.message);
			}
			//console.log("result: ", result[0]);
			return resolve(result[0]);
			con.end();
		});
	});
}

/*Retrieve the bill history of the user from the database.*/
function getUserBillHistory(username) {
	return new Promise((resolve, reject) => {

		let sql = `CALL get_user_bill_history(?)`;
		con.query(sql, username, (error, result, field) => {
			if (error) {
				return reject(error.message);
			}
			//console.log("result: ", result[0]);
			return resolve(result[0]);
			con.end();
		});
	});
}

/*Retrieve all the bank account associated with the user from the database.*/
function getUserBankAccountInformation(username) {
	return new Promise((resolve, reject) => {

		let sql = `CALL get_user_bank_information(?)`;
		con.query(sql, username, (error, result, field) => {
			if (error) {
				return reject(error.message);
			}
			//console.log("result: ", result[0]);
			return resolve(result[0]);
			con.end();
		});
	});
}

/*Retrieve a single bill data by its bill id.*/
function getBillData(billId) {
	return new Promise((resolve, reject) => {
		let sql = `CALL get_bill_data(?)`;
		con.query(sql, billId, (error, result, fields) => {
			if (error) {
				return reject(error.message);
			}

			return resolve(result[0]);
			con.end();

		})
	})
}

/*Insert a new bill into the database. This api is used by the biller to insert data into the database.*/
function insertBill(body) {
	console.log("body received: ", body)
	return new Promise ((resolve, reject) => {
		let sql = `CALL insert_new_bill(?,?,?,?,?,?,?)`;
		con.query(sql, [body["upusa_id"],body["bill_id"], body["amount"], new Date(body["bill_gen_dt"]), new Date(body["bill_due_dt"]), body["delayed"], body["service"]], (error, result, field) => {
			if(error) {
				return reject(error.message);
			}
			console.log("result: ", result);
			return resolve(result[0]);
		})
	})
}

/*Changes the bill status to billPaid once the transaction from user side is successful.*/
function removeCurrentBill(body) {
	return new Promise((resolve, reject) => {
		let sql =  `CALL remove_bill(?)`;
		con.query(sql, body["billId"], (error, result, fields) => {
			console.log("result from db: ", result);
			if (error){
				reject(error.message);
			}
			return resolve(result[0]);
		})
	})
}

module.exports = {
	checkUserPresence,
	registerUserFirstStage,
	getUserCurrentBills,
	getUserBillHistory,
	getUserBankAccountInformation,
	getBillData,
	insertBill,
	removeCurrentBill,
};
