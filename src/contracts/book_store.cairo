use crate::interfaces::Ibook_store::{IBookStore, Book};

#[starknet::contracts]
pub mod BookStore {
    use core::starknet::storage::{Map};
    super::Book;
    
    #[storage]
    struct Storage {
        books: Map<Book, bool>
    }
}