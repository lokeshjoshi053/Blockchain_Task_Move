// Define the IDO struct
struct IDO {
  startDateTime: u64,
  endDateTime: u64,
  cap: u64,
  whitelist: vector<Address>,
  owner: Address,
  balance: u64
}

// Define the TransferIDOFund module
module TransferIDOFund {

  // Define the transfer function
  public transfer_fund(
    ido_ref: &mut IDO,
    recipient: &signer Address,
    amount: u64,
  ) {
    // Only the owner can transfer funds
    assert(ido_ref.owner == move_from());

    // Check that the recipient is whitelisted
    assert(ido_ref.whitelist.contains(recipient));

    // Check that the transfer amount is within the available balance
    assert(amount <= ido_ref.balance);

    // Update the IDO balance
    ido_ref.balance -= amount;

    // Transfer the funds to the recipient
    let recipient_bal = balance_of(move(*recipient));
    send_from_faucet(move(*recipient), amount);
    assert(balance_of(move(*recipient)) == recipient_bal + amount);
  }
}
