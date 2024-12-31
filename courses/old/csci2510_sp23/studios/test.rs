use std::str;

fn main() {

    //"SLU" followed by a Grinning face emoji encoded in UTF-8
    let bytes : [u8; 7] = [ 0x53, 0x4C, 0x55, 0xF0, 0x9F, 0x98, 0x80 ];

    let view_into_bytes = &bytes[0..7]; //normally called a slice

    let result = str::from_utf8( view_into_bytes );
    if result.is_ok(){
        println!("Found UTF characters {}", result.unwrap() );
    } else if result.is_err() {
        println!("Provided bytes were not valid UTF-8");
    }

    println!("Num chars: {}", result.unwrap().chars().count() );
    println!("Num bytes: {}", result.unwrap().bytes().count() );
}
