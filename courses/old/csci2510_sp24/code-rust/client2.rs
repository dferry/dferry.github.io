use std::net::TcpStream;
use std::io::Read;

fn main() -> std::io::Result<()> {
    //Step 1 and 2: Create socket and make connection
    let mut server = TcpStream::connect("127.0.0.1:23456")?; 


    loop{
        //Step 3: Read from socket
        let mut buffer : [u8; 128] = [0;128];
        let bytes_read = server.read(&mut buffer)?;

        if bytes_read == 0 {break;}

        let answer = std::str::from_utf8(&buffer[0..bytes_read]).unwrap()
                                                                .to_string();
        println!("{}",answer);
    }

    Ok(())
}
