"use strict";
const {dbConnection}  = require('./dbConn');
const crypto = require('crypto');

class BillService {

    /*Add new bill for a particular user to the biller database.*/
    addNewBill(bill) {
        return new Promise( (resolve, reject) => {
            const query = `CALL generateBill(?,?,?,?,?)`;
            //const q = 'CALL generateBill(1, 156, \'20191008000000\', 1, 1);'
            console.log("Bill: ", bill);
            dbConnection.query(query,
                [bill.user_acc, bill.amount ,new Date(bill.due_dt), bill.service_id , bill.delayed],
                function(error, result) {
                    if(error) {
                        // console.log("Error ", error);
                        reject(error);
                    }
                    // console.log("Resolving: ", result);
                    resolve(result[0][0]);
                });
        });
    }

    /*Change the bill payment status to billPaid once the payment is done by the user.*/
    changePaymentStatus(bill) {
        const query = "CALL billPaid(?,?)";
        return new Promise( (resolve, reject) => {
            dbConnection.query(query, [bill.bill_id, bill.payment_dt],
                function(error, result) {
                if (error) {
                    reject(error);
                }
                resolve(result[0][0]);
            });
        });
    }
}

module.exports = BillService;
