#[derive(Drop, Serde, starknet::Store)]
pub struct Book {
    title: felt252,
    author: felt252,
    description: felt252,
    price: u16,
    quantity: u8,
}

pub mod interfaces {
    pub mod Ibook_store;
    pub mod Ipurchase;
}

pub mod contracts {
    pub mod book_store;
    pub mod purchase;
}