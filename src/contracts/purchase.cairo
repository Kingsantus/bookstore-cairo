use crate::interfaces::Ipurchase::IPurchase;
use crate::interfaces::Ibook_store::{IBookStoreDispatcher, IBookStoreDispatcherTrait};

#[starknet::contract]
pub mod Purchase {
    use core::starknet::storage::{Map, StoragePointerReadAccess, StoragePointerWriteAccess};
    use super::{IBookStoreDispatcher, IBookStoreDispatcherTrait};
    use core::starknet::ContractAddress;


    #[storage]
    struct Storage {
        purchase_book: Map<felt252, bool>,
    }

    #[derive(Drop, Serde, starknet::Event)]
    struct PurchaseBook {
        book: felt252,
        msg: felt252,
    }

    #[event]
    #[derive(Drop, Serde, starknet::Event)]
    enum Event {
        PurchaseBook: PurchaseBook,
    }

    #[abi(embed_v0)]
    impl PurchaseImpl of super::IPurchase<ContractState> {
        fn buy_books(ref self: ContractState,  book_address: ContractAddress, title: felt252) -> bool {
            let bookstore_dispatcher = IBookStoreDispatcher{ contract_address: book_address };
            // let check = lib_dispatcher.borrow_book(book_name);
            let book_exist = bookstore_dispatcher.get_book(title);
            if book_exist {
                bookstore_dispatcher.update_books({title:title, price: 0, quantity: -1});
                self.emit(BookAvailable {
                    book: title,
                    msg: "book purchased",
                })
                return true;
            } else {
                false
            };
        }
    }
}