import React from 'react'
import {Link} from "react-router-dom";

const PaymentRow = ({bankAccountList, payBill, billId}) => {
	const billid = billId;
	return (bankAccountList.map(account =>
			<div className="card m-2 bg-light" key={account["bank_account_number"]}>
				<div className="card-body">
					<div className={"container_fluid"}>
						<div className={"row"}>
							<div className={"col-sm-2 mx-auto text-center"}>
								{account["payment_entity_name"]}
							</div>
							<div className={"col-sm-2 mx-auto text-center"}>
								{account["bank_account_number"]}
							</div>
							<div className={"col-sm-2 mx-auto text-center"}>
								{account["bank_id"]}
							</div>
							<div className={"col-sm-2 mx-auto text-center"}>
								<button onClick={(account_number, billId) => payBill(account["bank_account_number"], billid)} className={"btn btn-primary btn-block"}>Pay Bill</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		)
	);
}

export default PaymentRow;
