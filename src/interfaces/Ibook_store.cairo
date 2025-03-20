use crate::Book;

#[starknet::interface]
pub trait IBookStore<TContractState> {
    fn add_book(ref self: TContractState, title: felt252, book: Book );
    fn update_books(ref self: TContractState, title: felt252, book: Book, price: u16, quantity: u8 );
    fn remove_books(ref self: TContractState, title: felt252);
    fn get_book(ref self: TContractState, title: felt252);
}