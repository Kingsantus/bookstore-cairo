use crate::Book;

#[starknet::interface]
pub trait IBookStore<TContractState> {
    fn add_book(ref self: TContractState, book: Book );
    fn update_books(ref self: TContractState, book: Book);
    fn remove_books(ref self: TContractState, book: Book);
}