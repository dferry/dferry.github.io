use std::net::{Shutdown, TcpListener};
use std::io::Write;

fn main() {

    //Steps 1, 2, and 3: Create a socket, bind an address to it, and listen for incoming
    //connections
    let listener = match TcpListener::bind("127.0.0.1:23456") {
        Ok(x) => x,
        Err(x) => {println!("Could not create listener: {x}"); return},
    };

    let mut counter = 0;
    loop {
        //Step 4: Accept incoming connections - program waits here until a connection is made
        let mut client = match listener.accept() {
            Ok((x,_)) => x,
            Err(x) => {println!("Error accepting socket connection: {x}"); return},
        };

        counter = counter + 1;

        //Step 5: Client and server transact
        let message = String::from("You are visitor number {counter}!");
        match client.write(message.as_bytes()) {
            Ok(_) => (),
            Err(x) => println!("Could not write to client: {x}"),
        };

        //Step 6: Close the connection
        match client.shutdown(Shutdown::Both) {
            Ok(_) => (),
            Err(x) => println!("Error during shutdown: {x}"),
        };
    }

}
