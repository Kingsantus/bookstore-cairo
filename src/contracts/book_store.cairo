use crate::Book;
use crate::interfaces::Ibook_store::IBookStore;

#[starknet::contracts]
pub mod BookStore {
    use core::starknet::storage::{Map};
    use super::Book;

    #[storage]
    struct Storage {
        books: Map<Book, bool>
    }

    #[derive(Copy, Drop, starknet::Event)]
    struct AddBook {
        book: Book,
        msg: felt252,
    }

    #[derive(Copy, Drop, starknet::Event)]
    struct UpdateBook {
        book: Book,
        msg: felt252,
    }

    #[derive(Copy, Drop, starknet::Event)]
    struct RemovedBook {
        book: Book,
        msg: felt252,
    }

    #[event]
    #[derive(Copy, Drop, starknet::Event)]
    enum Event {
        AddBook: AddBook,
        UpdateBook: UpdateBook,
        RemovedBook: RemovedBook,
    }

}