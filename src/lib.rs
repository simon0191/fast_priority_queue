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

    fn _bubble_down(arr: Array, cmp: Proc) -> NilClass {
        let mut arr = arr.unwrap();
        let cmp = cmp.unwrap();
        let arr_len = arr.length() as i64;

        let mut curr_index: i64 = 1;

        loop {
            let mut child_index = curr_index * 2;
            if child_index >= arr_len {
                return NilClass::new()
            }

            let not_the_last_element = child_index + 1 < arr_len;
            if not_the_last_element {
                let cmp_result = cmp.call(vec![ arr.at(child_index) , arr.at(child_index + 1) ])
                                        .try_convert_to::<Fixnum>()
                                        .unwrap()
                                        .to_i64();

                if cmp_result > 0 {
                    child_index += 1;
                }
            }
            let cmp_result = cmp.call(vec![ arr.at(curr_index) , arr.at(child_index) ])
                                    .try_convert_to::<Fixnum>()
                                    .unwrap()
                                    .to_i64();
            if cmp_result <= 0 {
                return NilClass::new()
            }
            let curr = arr.at(curr_index);
            let child = arr.at(child_index);
            arr.store(curr_index,child);
            arr.store(child_index,curr);

            curr_index = child_index;
        }
    }
);

#[no_mangle]
pub extern fn init_fast_priority_queue() {
    Class::from_existing("FastPriorityQueue").define(|itself| {
        itself.def("hello_world", hello_world);
        itself.def("_compare", _compare);
        itself.def("_add", _add);
        itself.def("_bubble_down", _bubble_down);
    });
}