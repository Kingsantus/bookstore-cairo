use crate::interfaces::Ipurchase::IPurchase;
use crate::interfaces::Ibook_store::{IBookStoreDispatcher, IBookStoreDispatcherTrait};

#[starknet::contract]
pub mod Purchase {
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    struct Storage {

    }

    #[abi(embed_v0)]
    impl PurchaseImpl of super::IPurchase<ContractState> {
        fn buy_books(){

        }
    }
}