import React from 'react'

const BillHistoryRow = ({bills}) => {
	return (bills.map(bill =>
		<div className="card m-2" key={bill["biller_bill_id"]}>
			<div className="card-body">
				<div className={"container_fluid"}>
					<div className={"row"}>
						<div className={"col-sm-2 mx-auto text-center"}>
							{bill["user_biller_account_number"]}
						</div>
						<div className={"col-sm-1 mx-auto text-center"}>
							{bill["biller_bill_id"]}
						</div>
						<div className={"col-sm-2 mx-auto text-center"}>
							{bill["bill_payment_date"]}
						</div>
						<div className={"col-sm-2 mx-auto text-center"}>
							{bill["user_biller_id"]}
						</div>
						<div className={"col-sm-2 mx-auto text-center"}>
							{bill["service_type_name"]}
						</div>
						<div className={"col-sm-2 mx-auto text-center"}>
							{bill["bill_amount"]}
						</div>
						<div className={"col-sm-1 mx-auto text-center"}>
						</div>
					</div>
				</div>
			</div>
		</div>))
};

export default BillHistoryRow;
