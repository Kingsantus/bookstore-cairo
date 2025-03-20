use crate::Book;
use crate::interfaces::Ibook_store::IBookStore;

#[starknet::contract]
pub mod BookStore {
    use starknet::storage::StorageMapReadAccess;
    use starknet::event::EventEmitter;
    use super::Book;
    use core::starknet::storage::{Map, StoragePathEntry};
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};


    #[storage]
    struct Storage {
        books: Map<felt252, Book>,
    }

    #[derive(Drop, Serde, starknet::Event)]
    struct AddBook {
        book: felt252,
        msg: felt252,
    }

    #[derive(Drop, Serde, starknet::Event)]
    struct UpdateBook {
        book: felt252,
        msg: felt252,
    }

    #[derive(Drop, Serde, starknet::Event)]
    struct RemovedBook {
        book: felt252,
        msg: felt252,
    }

    #[event]
    #[derive(Drop, Serde, starknet::Event)]
    enum Event {
        AddBook: AddBook,
        UpdateBook: UpdateBook,
        RemovedBook: RemovedBook,
    }

    #[abi(embed_v0)]
    impl BookStoreImpl of super::IBookStore<ContractState> {
        fn add_book(ref self: ContractState, title: felt252, book: Book) {
            self.books.entry(title).write(book);
            self.emit(AddBook { book: title, msg: 'new Book added' });
        }

        fn update_books(ref self: ContractState, title: felt252, book: Book, price: u16, quantity: u8) {
            match self.books.entry(title).read() {
                Option::Some(mut book_exist) => {
                    book_exist.price = price;
                    book_exist.quantity = quantity;
                    self.books.entry(title).write(book_exist);
                    
                    self.emit(
                        Event::UpdateBook(UpdateBook {
                            book: title,
                            msg: 'Book updated',
                        })
                    );
                }, 
                Option::None => {
                    self.emit(
                        Event::UpdateBook(UpdateBook {
                            book: title,
                            msg: 'Book not found',
                        })
                    );
                }
            }
        }

        fn remove_books(ref self: ContractState, title: felt252) {
            self
                .books
                .entry(title)
                .write(Book { title: '', author: '', description: '', price: 0, quantity: 0 });
            self.emit(RemovedBook { book: title, msg: 'Book removed' });
        }
    }
}
