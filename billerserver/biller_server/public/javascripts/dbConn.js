const mysql = require('mysql');
require('dotenv').config();

//create cursor to connect to the database.
const dbConnection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME
});


//connect to the database.
dbConnection.connect(function(error) {
    if(!!error) {
        console.log('Error connecting to database ', error);
    }
    else {
        console.log('Connected to database');
    }
});

module.exports = {
    dbConnection
}
