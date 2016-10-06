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

    fn _pop(arr: Array, cmp: Proc) -> AnyObject {
        let mut arr = arr.unwrap();
        let cmp = cmp.unwrap();
        let mut arr_len = arr.length() as i64;

        if arr_len <= 1 {
            return NilClass::new().to_any_object()
        } else if arr_len == 2 {
            return _itself.send("_pop_last_element",vec![]);
        }

        let top_val = arr.at(1);
        let last_val = arr.at(arr_len - 1);
        arr.store(1,last_val);
        _itself.send("_pop_last_element",vec![]);
        arr_len -= 1;

        let mut curr_index: i64 = 1;

        loop {
            let mut child_index = curr_index * 2;
            if child_index >= arr_len {
                return top_val;
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
                return top_val;
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
        itself.def("_pop", _pop);
    });
}