# Protocol Comparison

<table>
  <thead>
    <tr>
      <th align="left"></th>
      <th align="left">UART</th>
      <th align="left">SPI</th>
      <th align="left">I2C</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Wires</strong></td>
      <td><strong>2</strong> signal wires (<code>TX</code> to <code>RX</code>, one per direction), 2 wires (<code>RTS</code>/<code>CTS</code>) for flow control.</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Timing</strong></td>
      <td><strong>Asynchronous:</strong> no clock wire. Both sides agree on the baud rate (e.g. 115,200 bits/s) in advance. One bit-time = clock &divide; baud (434 cycles at 50 MHz).</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Frame</strong></td>
      <td>
        <ul>
          <li>Idle line held at 1</li>
          <li>Start bit (always 0)</li>
          <li>Data bits (usually 8, <code>LSB</code> first)</li>
          <li>Parity bit <em>(optional)</em></li>
          <li>Stop bit (always 1)</li>
        </ul>
        Most common: <strong>8N1</strong> (10 bit-times per byte).
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Receiving</strong></td>
      <td>Start bit's falling edge (1 &rarr; 0) &rarr; wait half a bit-time &rarr; sample once per bit-time. <code>RX</code> passes through a 2-flip-flop synchronizer first.</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Communication</strong></td>
      <td><strong>Full-duplex:</strong> <code>TX</code> and <code>RX</code> are independent, so both directions can run at the same time.</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Errors</strong></td>
      <td>No acknowledgments. <strong>Framing error</strong> if the stop bit reads 0.</td>
      <td></td>
      <td></td>
    </tr>
  </tbody>
</table>
