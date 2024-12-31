use std::net::TcpStream;
use std::io::Read;

fn main() {
    //Step 1 and 2: Create socket and make connection
    let mut server = match TcpStream::connect("127.0.0.1:23456"){
        Ok(x) => x,
        Err(x) => {println!("Could not connect to server: {x}"); return},
    };

    //Step 3: Read from socket
    let mut buffer : [u8; 128] = [0;128];
    let bytes_read = match server.read(&mut buffer) {
        Ok(x) => x,
        Err(x) => {println!("Could not read from server: {x}"); return},
    };

    let answer = std::str::from_utf8(&buffer[0..bytes_read]);
    println!("{:?}",answer);
    
}
