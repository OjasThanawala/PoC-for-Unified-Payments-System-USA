const express = require('express');
const router = express.Router();
const createError = require('http-errors');
const BillService = require('../public/javascripts/billService');
const axios = require('axios');

const service = new BillService();
const addBill_API = 'http://localhost:8080/api/insert-bill';


// Generate new bill and alert usupa
router.post('/newBill', function(req, res, next) {
    service.addNewBill(req.body)
        .then(result => {
            Object.assign(result, {
               biller_id: 12345
            });
            console.log(result);
            axios.post(addBill_API, result)
                .then(result => res.json(result))
                .catch(error => next(createError(500)));
        })
        .catch(error=> {
            next(createError(500));
        });
});

// Confirmation for bill payment
router.post('/billPay', function(req, res, next) {
    service.changePaymentStatus(req.body)
        .then(result => {
            res.json(result);
        })
        .catch(error=> {
            next(createError(500));
        });
});

module.exports = router;
