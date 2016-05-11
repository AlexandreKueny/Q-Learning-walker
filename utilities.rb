def setup_bluetooth
  serial = Serial.new 'COM14', 9600
  serial.write 'A'
  serial
end

def setup_servos(serial, servo_1, servo_2)
  json = {sero1Pos: servo_1.base, servo2Pos: servo_2.base}
  serial.write "#{JSON.generate json}\n"
end

def send_data(serial, servo_1, servo_2)
  json = {sero1Pos: servo_1.pos, servo2Pos: servo_2.pos}
  serial.write "#{JSON.generate json}\n"
end

def read_data(serial)
  entry = ''
  e = ''
  while e != '{'
    e = serial.read 1
  end
  entry += e
  loop do
    e = serial.read 1
    entry += e
    if e == '}'
      puts entry
      json = JSON.parse entry
      return json['distance']
    end
  end
end