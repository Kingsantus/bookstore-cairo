use crate::Book;
use crate::interfaces::Ibook_store::IBookStore;

#[starknet::contract]
pub mod BookStore {
    use starknet::event::EventEmitter;
use super::Book;
        use core::starknet::storage::{Map, StoragePathEntry};
        use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
        use core::starknet::get_caller_address;


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

    #[abi(embed_v0)]
    impl BookStoreImpl of super::IBookStore<ContractState> {
        fn add_book(ref self: ContractState, book: Book) {
            self.books.entry(book).write(true);
            self.emit(
                AddBook {
                    book,
                    msg: 'new Book added',
                }
            );
        }
        fn update_books(ref self: ContractState, book: Book) {
            self.books.entry(book).write(true);
            self.emit(
                UpdateBook {
                    book,
                    msg: 'Book info updated',
                }
            );
        }
        fn remove_books(ref self: ContractState, book: Book) {
            self.books.entry(book).write(false);
            self.emit(
                RemovedBook {
                    book,
                    msg: 'Book removed',
                }
            );
        }
    }
}