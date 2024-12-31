use std::net::{Shutdown, TcpListener};
use std::io::prelude::*;

fn main() -> std::io::Result<()> {

    //Steps 1, 2, and 3: Create a socket, bind an address to it, and listen for incoming
    //connections
    let listener = TcpListener::bind("127.0.0.1:23456")?;

    let mut counter = 0;
    loop {
        //Step 4: Accept incoming connections - program waits here until a connection is made
        //Note that accept() returns a tuple of TcpStream and SockAddr
        let result_tuple = listener.accept()?;
        let mut client = result_tuple.0;

        counter = counter + 1;

        println!("Handling visitor {counter}");

        //Step 5: Client and server transact
        let message = format!("You are visitor number {counter}!");
        client.write(message.as_bytes())?;
        client.flush()?;

        //Step 6: Close the connection
        client.shutdown(Shutdown::Both)?;
    }

}
