#[macro_use]
extern crate ruru;

use ruru::{Class,Object,RString,Fixnum,AnyObject,Array,Proc,NilClass};
class!(FastPriorityQueue);

methods!(
    FastPriorityQueue,
    _itself,

    fn hello_world() -> RString {
        RString::new("hello world")
    }

    fn length() -> Fixnum {
        unsafe {
            let arr = _itself.instance_variable_get("@array").to::<Array>();
            Fixnum::new((arr.length() - 1) as i64)
        }
    }

    fn _compare(cmp: Proc, a: AnyObject,b: AnyObject) -> Fixnum {
        let result = cmp.unwrap().call(vec![a.unwrap(),b.unwrap()]);
        result.try_convert_to::<Fixnum>().unwrap()
    }

    fn _add(arr: Array, cmp: Proc, x: AnyObject) -> NilClass {
        let mut arr = arr.unwrap();
        let x = x.unwrap();
        let cmp = cmp.unwrap();
        arr.push(x);
        // bubble_up
        let mut curr_index = (arr.length() - 1) as i64;
        loop {
            if curr_index <= 1 {
                return NilClass::new();
            }
            let parent_index = curr_index/2;
            let curr = arr.at(curr_index);
            let parent = arr.at(parent_index);
            let cmp_result = cmp.call(vec![ arr.at(curr_index) , arr.at(parent_index) ])
                                    .try_convert_to::<Fixnum>()
                                    .unwrap()
                                    .to_i64();

            if cmp_result > 0 {
                return NilClass::new();
            }
            // exchange
            arr.store(curr_index,parent);
            arr.store(parent_index,curr);

            curr_index = parent_index;
        }
    }
);

#[no_mangle]
pub extern fn init_fast_priority_queue() {
    Class::from_existing("FastPriorityQueue").define(|itself| {
        itself.def("hello_world", hello_world);
        //itself.def("initialize", initialize);
        itself.def("length", length);
        itself.def("_compare", _compare);
        itself.def("_add", _add);
    });
}
//
//fn _bubble_up(arr: Array, cmp: Proc, index: i64) -> NilClass {
//    let parent_index = index/2;
//    if index <= 1 { return NilClass::new() }
//    if __compare(cmp,arr.at(parent_index),arr.at(index)).to::<Fixnum>().to_i64() > 0 { return NilClass::new() }
//
//    _exchange(arr,index,parent_index);
//    _bubble_up(arr,cmp,parent_index)
//}
//
//fn _exchange(arr: Array, index_a: i64, index_b: i64) -> NilClass {
//    let tmp_a: AnyObject = arr.at(index_a);
//    arr.store(index_a,arr.at(index_b));
//    arr.store(index_b,tmp_a);
//}
//
//fn __compare(cmp: Proc, a: AnyObject, b: AnyObject) -> Fixnum {
//
//}