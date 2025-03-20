use starknet::ContractAddress; 

#[starknet::interface]
pub trait IPurchase<TContractState> {
    fn buy_books(ref self: TContractState, book_address: ContractAddress, title: felt252 ) -> bool;
}