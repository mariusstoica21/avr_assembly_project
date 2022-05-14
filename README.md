<p align="left">
  <img 
    src="https://github.com/mariusstoica21/avr_assembly_project/blob/main/Images/header.png"
  >
</p>

# AVR Assembly Project

A project done in AVR Assembly that uses external interrupts, internal interrupts, ADC and I2C communication protocol. The communication is done between an Arduino Mega 2560 board, as master, and an Arduino Uno board, as a slave.

**External interrupts** : on master (Arduino Mega 2560), using a button and 3 red leds.
- the value of a 3 bit binary number is incremented as the button is being pressed.
- the value of the 3 bit number is displayed on the leds;
- the main registers are : EIMSK, EICRA, EICRB.

**Internal interrupts**: on master (Arduino Mega 2560), using a blue led.
- the led blinks once per second;
- the main registers are: TIMSK1, TCCR1A, TCCR1B, OCR1A.

**ADC**: on master (Arduino Mega 2560), using a potentiometer and ten green leds.
- the value of potentiometer is read by the Arduino Mega board, using ADC;
- the value is displayed on the 10 leds;
- the range of the value is 0 (all leds are turned off) to 1023 (all leds are turned on);
- the main registers are: ADCSRA, ADCSRB, ADMUX.

**I2C** : between master (Arduino Mega 2560) and slave (Arduino Uno).
- Arduino Mega sends the number of times the button connected was pressed to Arduino Uno;
- Arduino Uno reads the value and displays it on the leds.

## Summary
✅ G.U.I. 

❌ Ease of installation

✅ Additional hardware needed

✅ Video available

## Project description

### Folder structure

📁 Images : contains the images required by the readme file.

📄 [Master.asm](https://github.com/mariusstoica21/avr_assembly_project/blob/main/Master.asm): assembly file loaded on Arduino Mega (master) that implements external interrupts, internal interrupts, ADC and I2C sender.

📄 [Slave.asm](https://github.com/mariusstoica21/avr_assembly_project/blob/main/Slave.asm): assembly file loaded on Arduino Uno (slave) that implements I2C receiver.

### Technologies

<table>
  <tr>
    <th>🔨 Tools/Framework</th>
    <th>📘 Language</th>
    <th>📃 Usage </th>
    <th>📚 Files</th>
    <th> ℹ Details  </th>
  </tr>
  <tr>
    <td>AVR Assembly</td>
    <td>Assmebly</td>
    <td>Utilization of interrupts, ADC and I2C</td>
    <td>Master.asm, Slave.asm</td>
    <td>
       <ul>
        <li>Master.asm is an assembly file loaded on Arduino Mega (master) that implements external interrupts, internal interrupts, ADC and I2C sender.</li>
        <li>Slave.asm is an assembly file loaded on Arduino Uno (slave) that implements I2C receiver.</li>
      </ul>
   </td>
  </tr>
</table>




