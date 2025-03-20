#[derive(Copy, Drop, Serde)]
pub struct Book {
    title: felt252,
    author: felt252,
    description: felt252,
    price: u16,
    quantity: u8,
}

#[starknet::interface]
pub trait IBookStore<TContractState> {
    fn add_book(ref self: TContractState, book: Book );
    fn update_books(ref self: TContractState, book: Book);
    fn remove_books(ref self: TContractState, book: Book);
}