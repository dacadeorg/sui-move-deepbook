
module dacade_deepbook::wbtc {
    use sui::coin::{Coin, TreasuryCap, Self};
    use std::option;
    use sui::transfer;
    use sui::tx_context::{TxContext, Self};

    struct WBTC has drop {}

    fun init(witness: WBTC, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"WBTC", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx))
    }

    public entry fun mint(
        treasury_cap: &mut TreasuryCap<WBTC>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

    public entry fun burn(treasury_cap: &mut TreasuryCap<WBTC>, coin: Coin<WBTC>) {
        coin::burn(treasury_cap, coin);
    }
}
