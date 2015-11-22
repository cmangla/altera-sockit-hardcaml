open Core.Std

open HardCaml.Signal.Comb
open HardCaml.Signal.Seq

let leds key0 key1 =
  let in0 = ~: key0 in
  let in1 = ~: key1 in
  reg_fb r_none empty 1 (fun d -> (d &: (~: in1)) |: ((~: d) &: in0))
  

let () =
  let key0 = input "key0" 1 in
  let key1 = input "key1" 1 in
  let circuit = HardCaml.Circuit.make "leds" 
    [ output "q" (leds key0 key1) ] in
  HardCaml.Rtl.Verilog.write (output_string stdout) circuit
