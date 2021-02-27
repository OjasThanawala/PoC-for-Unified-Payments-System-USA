//configure module to setup node server.
let express = require('express');
let app = express();
let bodyParser = require('body-parser');

/*Configure acceptable header for the data received from the client.*/
app.use(function (req, res, next) {
	res.header("Access-Control-Allow-Origin", "*");
	res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
	res.header("Access-Control-Allow-Methods", "GET,POST,PUSH,DELETE,OPTIONS");
	res.header("Access-Control-Allow-Credentials", "true");
	next();
});

// functionality to parse data from the request received from the client.
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

//import bank related services.
require("./services/BankService")(app);
console.log("Starting the server.");
app.listen(8081);
console.log("Server active and running.");

