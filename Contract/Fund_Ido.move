script WhitelistedIDO {
    // Define the structure for each whitelisted address
    struct Whitelist {
        address: address,
        whitelisted: bool,
    }

    // Define the fields for the IDO
    struct IDO {
        start_datetime: u64,
        end_datetime: u64,
        cap: u64,
        owner: address,
    }

    // Initialize the IDO and whitelist
    fun init(ido: IDO, whitelist: &mut vector<Whitelist>) {
        assert(ido.cap > 0, 0x1);
        assert(ido.end_datetime > ido.start_datetime, 0x2);
        assert(whitelist.size() > 0, 0x3);

        // Save the IDO data to storage
        move_to::storage::set<IDO>(address_of(sender()), ido);

        // Save the whitelist data to storage
        for index in 0..whitelist.size() {
            move_to::storage::set<Whitelist>(address_of(sender()), whitelist[index]);
        }
    }

    // Whitelist an address
    public fun whitelist_address(address: address) {
        // Check that the sender is the IDO owner
        assert(move_to::sender() == move_to::borrow_global_mut(&IDO::owner(address_of(sender()))), 0x4);

        // Check that the address is not already whitelisted
        let whitelisted_address = move_to::borrow_global_mut(&Whitelist::whitelisted(address_of(sender()), address));
        assert(!whitelisted_address, 0x5);

        // Add the address to the whitelist
        move_to::borrow_global_mut(&Whitelist::whitelisted(address_of(sender()), address)) = true;
    }

    // Fund the IDO
    public fun fund() {
        // Get the IDO and whitelist data from storage
        let ido = move_to::borrow_global_mut(&IDO::owner(address_of(sender())));
        let whitelist = move_to::borrow_global(&Whitelist::whitelisted(address_of(sender())));

        // Check that the sender is whitelisted
        assert(whitelist, 0x6);

        // Check that the IDO has not ended
        assert(env::time() < ido.end_datetime, 0x7);

        // Check that the IDO has not reached the funding cap
        let total_funds = move_to::balance_of(address_of(sender()));
        assert(total_funds <= ido.cap, 0x8);

        // Transfer funds to the IDO owner
        move_to::transfer(address_of(sender()), ido.owner, total_funds);
    }
}
