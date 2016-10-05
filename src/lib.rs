#[macro_use]
extern crate ruru;

use ruru::{Class,Object,RString,Fixnum,AnyObject,Array,Proc};
class!(FastPriorityQueue);

methods!(
    FastPriorityQueue,
    _itself,

    fn hello_world() -> RString {
        RString::new("hello world")
    }

//    fn initialize(cmp: Proc) -> AnyObject {
//        _itself.instance_variable_set("@array",Array::new());
//        _itself.instance_variable_set("@cmp",cmp.ok().expect("proc"))
//    }

    fn length() -> Fixnum {
        unsafe {
            let arr = _itself.instance_variable_get("@array").to::<Array>();
            Fixnum::new(arr.length() as i64)
        }
    }

    fn _compare(cmp: Proc, a: AnyObject,b: AnyObject) -> Fixnum {
        let result = cmp.unwrap().call(vec![a.unwrap(),b.unwrap()]);
        result.try_convert_to::<Fixnum>().unwrap()
    }

);

#[no_mangle]
pub extern fn init_fast_priority_queue() {
    Class::from_existing("FastPriorityQueue").define(|itself| {
        itself.def("hello_world", hello_world);
        //itself.def("initialize", initialize);
        itself.def("length", length);
        itself.def("_compare", _compare);
    });
}