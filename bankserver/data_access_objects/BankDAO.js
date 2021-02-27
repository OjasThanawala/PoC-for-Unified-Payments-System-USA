/*Configuration file to connect to the databse and perform database related process.*/
let mysql = require('mysql');
require('dotenv').config();

//create cursor to connect to the databse.
let con = mysql.createConnection({
	host: process.env.DB_HOST,
	user: process.env.DB_USER,
	password: process.env.DB_PASS,
	database: process.env.DB_NAME
});

/*Deduct the amount from user's bank account using his bank account number and the amount to be deducted.*/
function performTransaction(account_number, amount){
	console.log("perfrom trans: ", account_number, amount);
	return new Promise((resolve, reject) => {
		let sql = `CALL perform_transaction(?,?)`;
		con.query(sql, [account_number, amount], (error, result, fields) => {
			if(error) {
				reject(error.message);
			}
			console.log("result: ", result[0]);
			return resolve(result[0]);
		});
	});
}

module.exports={
	performTransaction,
};
