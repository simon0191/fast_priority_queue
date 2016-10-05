#[macro_use]
extern crate ruru;

use ruru::{Class,Object,RString};
class!(FastPriorityQueue);

methods!(
    FastPriorityQueue,
    _itself,
    fn hello_world() -> RString {
        RString::new("hello world")
    }
);

#[no_mangle]
pub extern fn init_fast_priority_queue() {
    Class::from_existing("FastPriorityQueue").define(|itself| {
        itself.def("hello_world", hello_world);
    });
}